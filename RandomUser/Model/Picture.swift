//
//  Picture.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 07.03.2022.
//

import Foundation

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
