//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Jacob Frick on 10/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation
class User {
    
    // MARK: Properties
    var name: String?
    var screenName: String?
    var profilePicture: URL?
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        if let profile: String = dictionary["profile_image_url_https"] as? String {
            print(profile)
            profilePicture = URL(string: profile)!
        }
        // Initialize any other properties
    }
}
