//  ViewModel.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 11/30/25.

import SwiftUI
import Foundation
import Combine
@MainActor

struct AnimalSearch: View {
    @State private var searchText = ""
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var animalViewModel = AnimalSearchViewModel()
    @State private var searchTask: Task<Void, Never>? = nil
    @State private var isLoggedOut = false
    
    private var filteredAnimals: [ZooAnimal] {
        if searchText.isEmpty { return animalViewModel.animals }
        return animalViewModel.animals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                TiledBackground(imageName: "Image")
                List {
                    if animalViewModel.isLoading {
                        ProgressView("Searching...")
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if filteredAnimals.isEmpty && !searchText.isEmpty {
                        Text("No results found")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(filteredAnimals) { zooAnimal in
                            NavigationLink {
                                ZooAnimalDetailView(animal: zooAnimal.mergedWithLocalInfo())
                            } label: {
                                SpeciesRow(species: nil, zooAnimal: zooAnimal)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search animals…")
                .onChange(of: searchText) { newValue in
                    debounceSearch(for: newValue)
                }
                .scrollContentBackground(.hidden)
            }
         
            .navigationTitle("Animal Search")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        authViewModel.logout()
                        isLoggedOut = true
                    }
                    .navigationDestination(isPresented: $isLoggedOut) {
                        LoginView(authViewModel: authViewModel)
                    }
                }
            }
        }
    }

    private func debounceSearch(for query: String) {
        self.searchTask?.cancel()
        self.searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            if !Task.isCancelled {
                await animalViewModel.searchAnimals(query)
            }
        }
    }
}


  
