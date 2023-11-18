//
//  TestModel.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import Foundation

class TestModel: ObservableObject {
    
    let httpClient = HttpClient()
    
    func register(username: String, password: String) async throws -> Bool {
        
        let postData = ["username" : username, "password": password]
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(postData)), modelType: RegisterResponseDTO.self)
        
        let registerResponseDTO = try await httpClient.load(resource)
        
        return !registerResponseDTO.error
    }
}
