//
//  Response.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 07.03.2022.
//

import Foundation

struct Response: Decodable {
    let results: [User]
}
