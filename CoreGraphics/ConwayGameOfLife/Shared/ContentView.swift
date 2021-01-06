//
//  ContentView.swift
//  Shared
//
//  Created by Julian Arias Maetschl on 04-01-21.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @StateObject private var gameRender = ConwayGameOfLifeRenderer()
    @State private var showPicker: Bool = false

    var body: some View {
        ZStack {
            Image(uiImage: gameRender.getRender())
                .interpolation(.none)
                .resizable()
                .scaledToFill()
                .onReceive(gameRender.timer, perform: { image in
                    gameRender.nextGeneration()
                })
            VStack(spacing: 0.0) {
                Spacer()
                Color.black.opacity(0.8)
                    .frame(height: showPicker ? 200: 0)
                HStack {
                    Spacer()
                    Button(action: { showPicker.toggle() }) {
                        Image(systemName: "largecircle.fill.circle")
                    }.font(.largeTitle)
                    Spacer()
                    Text("\(gameRender.counter)")
                    Spacer()
                    Button(action: { gameRender.loadImage() }) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }.font(.largeTitle)
                    Spacer()
                    Button(action: { gameRender.runLoop() }) {
                        gameRender.isPlaying ?
                            Image(systemName: "pause.circle"):
                            Image(systemName: "play.circle")
                    }.font(.largeTitle)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.black.opacity(0.8))
                .accentColor(.green)
            }
            .animation(.easeInOut)
        }
        .ignoresSafeArea()
        .background(Color(.black))
        .onAppear(perform: gameRender.loadImage)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
