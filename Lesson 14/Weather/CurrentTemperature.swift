//
//  CurrentTemperature.swift
//  lesson 12
//
//  Created by Левон Амбарцумян on 06.05.2021.
//

import Foundation
import RealmSwift

class CurrentTemperature: Codable {
    var list: [Lists] = []
    var city: City = City()
}

class Lists: Object, Codable {
    var weather = List<Weather>()
    @objc dynamic var main: Main? = Main()
    @objc dynamic var wind: Wind? = Wind()
    @objc dynamic var dt: Int = 0
    @objc dynamic var visibility: Int = 0
    @objc dynamic var pop: Double = 0
}

class City: Object, Codable {
   @objc dynamic var name: String = ""
//    public override static func primaryKey() -> String? {
//        return "name"
//    }
}

class Weather: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var main: String = ""
  //  @objc dynamic var description: String
    @objc dynamic var icon: String = ""
}

class Main: Object, Codable {
    @objc dynamic   var temp: Double = 0
    @objc dynamic var temp_min: Double = 0
    @objc dynamic var temp_max: Double = 0
    @objc dynamic var pressure: Double = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var feels_like: Double = 0
}
class Wind: Object, Codable {
    @objc dynamic var speed: Double = 4.6
    @objc dynamic var deg: Int = 119
}

//
//class CurrentTemperature{
// //   var weather: [CurrentTemperature2]
////    var main:
//    var dt: Int
//    var name: String
//
//    init?(data: NSDictionary) {
//        guard let dt = data["dt"] as? Int,
//              let name = data["name"] as? String
//             // let weather = data["weather"]
//
//              else { return nil }
//
//        self.dt = dt
//        self.name = name
//       // self.weather = weather as! [CurrentTemperature2]
//
//
//    }
//
//}
//
//class CurrentTemperature2{
//
//    var description: String
//    var icon: String
//
//    init?(data: NSDictionary) {
//        guard let description = data["description"] as? String,
//              let icon = data["icon"] as? String else {
//            return nil
//        }
//        self.description = description
//        self.icon = icon
//    }
//
//
//
    
//    let name: String
//    let temp: Double
//    let sortOrder: Int
//
//    init?(data: NSDictionary) {
//        guard let name = data["name"] as? String,
//              let temp = data["temp"] as? String,
//              let sortOrder = data["sortOrder"] as? String else {return nil}
//        self.name = name
//        self.temp = Double(temp) ?? 0
//        self.sortOrder = Int(sortOrder) ?? 0
//    }
//    let name: String
//    let imageURL: String
//    let sortOrder: Int
//  //  let temp: Double
//
//    init?(data: NSDictionary){
//        guard let name = data["name"] as? String,
//            let imageURL = data["image"] as? String,
//         //   let temp = data["temp"] as? String,
//            let sortOrder = data["sortOrder"] as? String else { return nil }
//        self.name = name
//        self.imageURL = imageURL
//        self.sortOrder = Int(sortOrder) ?? 0
//       // self.temp = Double(temp) ?? 0
//    }

//
