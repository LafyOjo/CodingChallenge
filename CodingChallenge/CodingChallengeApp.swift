//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Isaiah Ojo on 28/06/2023.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ProductView(viewModel: ProductViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
