//
//  ContentView.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject private var model: TestModel
    
    var body: some View {
        HStack {
            Button("Register") {
                Task {
                    await register()
                }
            }
        }
    }
    
    private func register() async {
        do {
            let registered = try await model.register(username: "abc", password: "efg")
            if registered {
                // take the user to login screen
            } else {
                // display error
            }
        } catch {
            print(error)
        }
        
    }
}

#Preview {
    ContentView().environmentObject(TestModel())
}
