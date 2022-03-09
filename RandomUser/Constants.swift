//
//  Constants.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 09.03.2022.
//

import Foundation
import UIKit

enum Constants {
    static let urlToServer: String = "https://randomuser.me/api/?inc=gender,name,location,email,phone,picture"
    static let navigationBarHeight: CGFloat = 44
    static let labelSpacing: CGFloat = 10
    static let labelHeight: CGFloat = 50
    static let navigationBarTitle: String = "Random User"
    static let newUserButtonTitle: String = "New User"
    static let imageBorderWidth: CGFloat = 3
    static let imageWidth: CGFloat = 150
    static let imageHeight: CGFloat = 150
    
    enum LabelPrefix {
        static let name = "Name: "
        static let address = "Address: "
        static let email = "Email: "
        static let phone = "Phone: "
        static let gender = "Gender: "
    }
    
    enum LabelsStackViewInsets {
        static let leading: CGFloat = 20
        static let trailing: CGFloat = -20
        static let top: CGFloat = 20
        static let bottom: CGFloat = -20
    }
}
