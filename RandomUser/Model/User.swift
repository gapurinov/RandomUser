//
//  User.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 06.03.2022.
//

import Foundation
import UIKit

struct User: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let picture: Picture
}
