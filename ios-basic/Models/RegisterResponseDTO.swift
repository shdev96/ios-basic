//
//  RegisterResponseDTO.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import Foundation

struct RegisterResponseDTO: Codable {
    let error: Bool
    var response: String? = nil
}
