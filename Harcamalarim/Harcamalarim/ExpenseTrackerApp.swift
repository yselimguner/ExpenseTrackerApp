//
//  HarcamalarimApp.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionsListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionsListVM)
        }
    }
}
