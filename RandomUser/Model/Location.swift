//
//  Location.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 07.03.2022.
//

import Foundation

struct Location: Decodable {
    let street: Street
    let city: String
    let state: String
    
    func getAddress() -> String {
        state + ", " + city + ", " + street.getStreet()
    }
}

struct Street: Decodable {
    let number: Int
    let name: String
    
    func getStreet() -> String {
        String(number) + " " + name
    }
}
