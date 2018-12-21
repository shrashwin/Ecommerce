import UIKit

class HeaderItem: NSObject, Codable {
    var id: Int?
    var opensExternalUrl: Bool?
    var imageurl: String?
    var externalUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case opensExternalUrl = "opens_external_url"
        case imageurl = "image_url"
        case externalUrl = "extrenal_url"
    }
}

class DashboardHeader: NSObject, Codable {
    
    var headerItems: [HeaderItem]?
    var itemDuration: Int?
    
    enum CodingKeys: String, CodingKey {
        case headerItems = "header_items"
        case itemDuration = "item_duration"
    }
}

class Food: NSObject, Codable {
    
    var id: Int?
    var name: String?
    var opensExternalUrl: Bool?
    var imageurl: String?
    var externalUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case opensExternalUrl = "opens_external_url"
        case imageurl = "image"
        case externalUrl = "extrenal_url"
    }
}

class DashboardSection: NSObject, Codable {
    
    var id: Int?
    var name: String?
    var hasMore: Bool?
    var itemWidth: Int?
    var foods: [Food]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case hasMore = "has_more"
        case itemWidth = "item_width"
        case foods = "items"
    }
}

class DashboardData: NSObject, Codable {
    
    var dashboardHeader: DashboardHeader?
    var dashboardSections : [DashboardSection]?
    
    override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case dashboardHeader = "header_data"
        case dashboardSections = "dashboard_sections"
    }
    
}

class DashboardDataWrapper: NSObject, Codable {
  
    var dashboardData: DashboardData?
    
    override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
       case dashboardData = "dashboard_data"
    }
  
}
