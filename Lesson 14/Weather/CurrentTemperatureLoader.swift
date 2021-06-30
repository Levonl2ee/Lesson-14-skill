//
//  CurrentTemperatureLoader.swift
//  lesson 12
//
//  Created by Левон Амбарцумян on 07.05.2021.
//

import Foundation
import Alamofire

class CurrentTemperatureLoader {

    var currentTemperature = CurrentTemperature()

    func loadCurrentTemperature2(completion: @escaping (CurrentTemperature) -> Void) {
        
        AF.request("https://api.openweathermap.org/data/2.5/forecast?lat=55.7522&lon=37.6156&appid=6642ae967314b9eb8f16732b4dfcb033&cnt=8&units=metric&lang=ru").responseJSON {response in
            guard response.error == nil else {
                print("DataTask error: \(response.error!.localizedDescription)")
                return
            }
            do {
                self.currentTemperature = try JSONDecoder().decode(CurrentTemperature.self, from: response.data!)
                DispatchQueue.main.async {
                    completion(self.currentTemperature)
                }
                
            } catch {
                print("It is: \(error.localizedDescription)")
            }
        }
    }
    
}



        
    

