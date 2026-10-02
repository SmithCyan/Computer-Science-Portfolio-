//  TitledBackground.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/7/25.

import SwiftUI

struct TiledBackground: View {
    var imageName: String
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size

            // Tiling the background
            ForEach(0..<4) { x in
                ForEach(0..<8) { y in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.width / 2) // tuning for spacing
                        .position(
                            x: CGFloat(x) * size.width/2 + size.width/4,
                            y: CGFloat(y) * size.width/2 + size.width/4
                        )
                }
            }
        }
        .ignoresSafeArea()
    }
}
