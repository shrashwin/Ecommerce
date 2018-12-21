
import UIKit
import Alamofire


class WebserviceHelper {
    
    @discardableResult
    static func webserviceCall<T>(url: String,
                                  method: HTTPMethod = .post,
                                  jsonData: Data? = nil,
                                  header: [String:String]? = nil,
                                  dataModal: T.Type,
                                  onSuccess: @escaping(T) -> Void,
                                  onFailure: @escaping(ResponseModel) -> Void) -> DataRequest? where T : Codable {
        
        guard let cleanURL = url.getCleanedUrl() else {
            onFailure(ResponseModel())
            return nil
        }
        
        var request = URLRequest(url: cleanURL)
        
        request.httpMethod = method.rawValue
        
        request.setValue( WebConstants.WebServiceParams.kContentTypeJsonValue , forHTTPHeaderField: WebConstants.WebServiceParams.kContentTypeKey)
        
        if let headerValue = header?[WebConstants.WebServiceParams.kAuthorizationKey] {
            request.setValue(headerValue, forHTTPHeaderField: WebConstants.WebServiceParams.kAuthorizationKey)
        }
        
        if let json = jsonData {
            request.httpBody = json
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        return  manager.request(request as URLRequestConvertible).responseJSON(completionHandler: { response in
            
            WebserviceHelper.getApiResponse(from: response,
                                            dataModal: dataModal,
                                            onSuccess: { (successResponse) in
                            onSuccess(successResponse)
            }, onFailure: { (failureResponse) in
                onFailure(failureResponse)
            })
            
        })
    }
    
    static func updateInfoWithImage<T>(images: [UIImage?]?,
                                    imageNames: [String],
                                    url: String,
                                    method: HTTPMethod = .post,
                                    param: [String: AnyObject]? = nil,
                                    header: [String: String]? = nil,
                                    compressImage: Bool = false,
                                    dataModal: T.Type,
                                    onProgress: @escaping(Double) -> Void,
                                    onSuccess: @escaping(T) -> Void,
                                    onFailure : @escaping(ResponseModel) -> Void) where T : Codable {
        
        
        let imageDataArray = WebserviceHelper.getImagesData(from: images, with: imageNames, with: compressImage)
        
       
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (index,data) in imageDataArray.0.enumerated() {
                
                multipartFormData.append(data, withName: imageDataArray.1[index], fileName: "\(imageDataArray.1[index]).jpg", mimeType: "image/jpeg")
                
            }
            
            for (key, value) in (param ?? [String: AnyObject]()) {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            
        }, to: url.getCleanUrlString(),
           method: method,
           headers: header,
           encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    
                    onProgress(progress.fractionCompleted)
                    
                })
                upload.responseJSON { response in
                    
                    WebserviceHelper.getApiResponse(from: response,
                                                    dataModal: dataModal,
                                                    onSuccess: { (successResponse) in
                                                        onSuccess(successResponse)
                    }, onFailure: { (failureResponse) in
                        onFailure(failureResponse)
                    })
                    
                }
            case .failure(let error):
                onFailure(ResponseModel.errorResponse(with: error.localizedDescription))
            }
        })
        
    }
    
    static func uploadFile<T>(at fileUrl: URL,
                           fileName: String,
                           url: String,
                           method: HTTPMethod = .post,
                           param: [String: AnyObject]? = nil,
                           header: [String: String]? = nil,
                           dataModal: T.Type,
                           onSuccess: @escaping(T) -> Void,
                           onFailure : @escaping(ResponseModel) -> Void) where T : Codable {
        
        Alamofire.upload(multipartFormData: {(multipartFormData) in
            
            multipartFormData.append(fileUrl, withName: fileName)
            
            for (key, value) in (param ?? [String: AnyObject]()) {
                
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                
            }
            
        },to: url.getCleanUrlString(),
          method: method,
          headers: header!,
          encodingCompletion: {(result) in
            
            switch result {
                
            case .success(let upload, _, _) :
                
                upload.responseJSON(completionHandler: {(response) in
                    
                    WebserviceHelper.getApiResponse(from: response,
                                                    dataModal: dataModal,
                                                    onSuccess: { (successResponse) in
                                                        onSuccess(successResponse)
                    }, onFailure: { (failureResponse) in
                        onFailure(failureResponse)
                    })
                    
                })
            case .failure(let error):
                onFailure(ResponseModel.errorResponse(with: error.localizedDescription))
            }
            
        })
    }
    
}

extension WebserviceHelper {
    
    static func getData(from anyObj: Any) -> Data? {
        guard let dictionary = anyObj as? [String: AnyObject],
        let dataDictionary = dictionary["data"] as? [String: AnyObject]
            else {
                return nil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            return jsonData
        } catch {
            return nil
        }
       
    }
    
    static func getApiResponse<T>(from response: DataResponse<Any>,
                           dataModal: T.Type,
                           onSuccess: @escaping(T) -> Void,
                           onFailure : @escaping(ResponseModel) -> Void) where T : Codable {
        
        switch response.result {
            
        case .success(let responseObj):
            
            guard let json = response.data else {
                onFailure(ResponseModel())
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let responseModel = try decoder.decode(ResponseModel.self, from: json)
                
                if responseModel.code == WebConstants.WebServiceCodes.kSuccessCode {
                    
                    guard let data = WebserviceHelper.getData(from: responseObj) else {
                        onFailure(ResponseModel())
                        return
                    }
                    
                    let succesResponse = try decoder.decode(dataModal, from: data)
                    onSuccess(succesResponse)
                    
                }
                else {
                    onFailure(responseModel)
                }
                
            } catch {
                onFailure(ResponseModel())
            }
            
            
        case .failure(let error):
            onFailure(ResponseModel.errorResponse(with: error.localizedDescription))
            
        }
        
    }
    
    static func getImagesData(from images: [UIImage?]?, with names: [String], with imageCompressionEnabled: Bool) -> ([Data],[String]) {
        
        var imageDatas = [Data]()
        var imageNamesArray = [String]()
        
        for (index,eachImage) in (images ?? [UIImage]()).enumerated() {
            var imageToUpload = eachImage
            
            if imageCompressionEnabled {
                
                if let width = imageToUpload?.size.width, width > 640 {
                    if let image = imageToUpload?.getCompressedImage() {
                        imageToUpload = image
                    }
                }
                
            }
            
            if let image = imageToUpload,
                let imageDataRep = image.jpegData(compressionQuality: 1.0){
                imageDatas.append(imageDataRep)
                imageNamesArray.append(names[index])
                
            }
        }
        return (imageDatas,imageNamesArray)
        
    }
}

