//
//  Constants.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import Foundation

struct Constants {
    
    private static let baseUrlPath = "http://127.0.0.1/api"
    
    struct Urls {
        
        static let register = URL(string: "\(baseUrlPath)/register")!
    }
}
