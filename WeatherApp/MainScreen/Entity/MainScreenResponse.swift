import Foundation

struct Response: Codable {
    var location: Location
    var current: Current
}

struct Location: Codable {
    var name: String?
}

struct Current: Codable {
    var temp: Double?
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case condition
    }
}

struct Condition: Codable {
    var icon: String? 
}
