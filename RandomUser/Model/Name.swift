//
//  Name.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 07.03.2022.
//

import Foundation

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
    
    func getFullName() -> String {
        first + " " + last
    }
}
