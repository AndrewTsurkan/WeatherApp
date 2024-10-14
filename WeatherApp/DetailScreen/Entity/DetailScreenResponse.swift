import Foundation

struct DetailScreenResponse: Codable {
    var location: Location
    var current: Current
    var forecast: Forecast
}

struct Forecast: Codable {
    var forecastDay: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct ForecastDay: Codable {
    var date: Int?
    var day: Day
    var hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date = "date_epoch"
        case day
        case hour 
    }
}

struct Day: Codable {
    var temp: Double?
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case temp = "maxtemp_c"
        case condition
    }
}

struct Hour: Codable {
    var time: Int?
    var temp: Double?
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time = "time_epoch"
        case temp = "temp_c"
        case condition
    }
}

struct HourlyWeather: Codable {
    
}
