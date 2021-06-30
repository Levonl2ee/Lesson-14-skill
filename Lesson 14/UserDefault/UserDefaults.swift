//
//  UserDefaults.swift
//  Lesson 14
//
//  Created by Левон Амбарцумян on 17.06.2021.
//

import Foundation

class NamesUserDefaults {
    
    static let shared = NamesUserDefaults()
    
    private let kNameKay = "NamesUserDefaults.kNameKay"
    
    var name: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: kNameKay)
        }
        get {
            return UserDefaults.standard.string(forKey: kNameKay)
        }
    }
    
    
    private let ksurNameKay = "NamesUserDefaults.ksurNameKay"
    
    var surName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: ksurNameKay)
        }
        get {
            return UserDefaults.standard.string(forKey: ksurNameKay)

        }
    }
}
