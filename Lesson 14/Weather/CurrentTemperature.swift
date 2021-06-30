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

}

class Weather: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var main: String = ""
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
