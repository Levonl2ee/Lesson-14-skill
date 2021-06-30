//
//  CurrentTemperatureLoader.swift
//  lesson 12
//
//  Created by Левон Амбарцумян on 07.05.2021.
//

import Foundation
import CoreLocation
import Alamofire

protocol CurrrentTemperatureLoderDelegate{
    func louder(currentTemperatures: CurrentTemperature)
}

class CurrentTemperatureLoader {

    var delegate: CurrrentTemperatureLoderDelegate?
    var currentTemperature = CurrentTemperature()

    
//    func loadCurrentTemperature(completion: @escaping (CurrentTemperature) -> Void) {
//
//        let locations: [Double] = ViewController().startLocationManager()
//       // print(locations[0])
//        //var currentTemperature = CurrentTemperature()
//        let session = URLSession.shared
//        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(locations[0])&lon=\(locations[1])&appid=6642ae967314b9eb8f16732b4dfcb033&cnt=8&units=metric&lang=ru")!
//
//
//
//
//      //  print(longitude.description)
//        let task = session.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                print("DataTask error: \(error!.localizedDescription)")
//                return
//            }
//            do {
//                //self.currentTemperature = try JSON().decode(CurrentTemperature.self, from: data!)
//                self.currentTemperature = try JSONDecoder().decode(CurrentTemperature.self, from: data!)
//                DispatchQueue.main.async {
//                   // self.delegate?.louder(currentTemperatures: self.currentTemperature)
//                    completion(self.currentTemperature)
//                }
//
//            } catch {
//                print("It is: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
    
    func loadCurrentTemperature2(completion: @escaping (CurrentTemperature) -> Void) {
        
        AF.request("https://api.openweathermap.org/data/2.5/forecast?lat=55.7522&lon=37.6156&appid=6642ae967314b9eb8f16732b4dfcb033&cnt=8&units=metric&lang=ru").responseJSON {response in
            guard response.error == nil else {
                print("DataTask error: \(response.error!.localizedDescription)")
                return
            }
            do {
                //self.currentTemperature = try JSON().decode(CurrentTemperature.self, from: data!)
                self.currentTemperature = try JSONDecoder().decode(CurrentTemperature.self, from: response.data!)
                DispatchQueue.main.async {
                   // self.delegate?.louder(currentTemperatures: self.currentTemperature)
                    completion(self.currentTemperature)
                }
                
            } catch {
                print("It is: \(error.localizedDescription)")
            }
        }
    }
    
}



        
    

