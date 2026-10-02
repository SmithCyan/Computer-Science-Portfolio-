//  Find_My_ResourceApp.swift
//  Find My Resource
//  Created by Nitsa Saint Fort, Sebastian Torres, Veljko Stojanovic, Annette Perez, Musab Hafez on 3/19/26.
//

import SwiftUI
import FirebaseCore


struct FindMyResourceApp: App {
    var body: some Scene {
        WindowGroup {
            AuthViewModel()
        }
    }
}
