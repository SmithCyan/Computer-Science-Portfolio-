//  AnimalSoundsScreen.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/7/25.

import SwiftUI
import AVFoundation

struct Animal: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let sound: String
}

struct AnimalSoundsScreen: View {
    @State private var audioPlayer: AVAudioPlayer?

    let animals: [Animal] = [
        Animal(name: "cow", image: "Image 1", sound: "cow-mooing-343423"),
        Animal(name: "dolphin", image: "Image 2", sound: "0gta0w44xnhk-dolphin-sfx-5"),
        Animal(name: "parrot", image: "Image 3", sound: "parrots-88486"),
        Animal(name: "lion", image: "Image 4", sound: "33j6ktl7l4e-lion-roar-1")
    ]

    func playSound(_ name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    var body: some View {
        VStack {
            Text("Animal Sounds")
                .font(.largeTitle)
                .bold()
                .padding()

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(animals) { animal in
                    VStack {
                        Image(animal.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .onTapGesture {
                                playSound(animal.sound)
                            }

                        Text(animal.name)
                            .font(.headline)
                            .padding(.top, 5)
                    }
                    .padding()
                }
            }
        }
    }
}

struct AnimalSoundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimalSoundsScreen()
    }
}
