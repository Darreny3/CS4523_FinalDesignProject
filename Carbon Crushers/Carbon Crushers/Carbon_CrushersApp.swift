//
//  Carbon_CrushersApp.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/6/22.
//

import SwiftUI

@main
struct Carbon_CrushersApp: App {
    var viewModel = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
