import UIKit

class DashboardDataManager
{
    static func fetchDashboardData(onSuccess : @escaping(DashboardDataWrapper) -> Void,
                              onFailure : @escaping(ResponseModel) -> Void)
    {
        
        WebserviceHelper
            .webserviceCall(url: UrlConstants.sampleJsonBlobUrl,
                            method: .get,
                            dataModal: DashboardDataWrapper.self,
                            onSuccess: { (dashboardData) in
                    onSuccess(dashboardData)
        }) { (failureModel) in
            onFailure(failureModel)
        }
  }
}

