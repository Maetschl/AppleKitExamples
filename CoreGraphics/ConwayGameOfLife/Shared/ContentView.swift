//
//  ContentView.swift
//  Shared
//
//  Created by Julian Arias Maetschl on 04-01-21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var image: Image?
    @State private var showPicker: Bool = true
    var body: some View {
        ZStack {
            image?
                .interpolation(.none)
                .resizable()
                .scaledToFill()
                .onReceive(timer, perform: { _image in
                    nextGeneration()
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
                    Button(action: { loadImage() }) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }.font(.largeTitle)
                    Spacer()
                    Button(action: { runLoop() }) {
                        isPlaying ?
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
        .background(Color(.black))
        .onAppear(perform: loadImage)
        .ignoresSafeArea()
    }

    let widthSize: Int = 45
    let heightSize: Int = 90
    @State var isPlaying: Bool = true
    let loopTime: TimeInterval = 10
    @State var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State var matrix: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 90), count: 45)
    @State var matrixAuxiliar: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 90), count: 45)

    func nextGeneration() {
        for x in 0 ..< widthSize {
            for y in 0 ..< heightSize {
                matrixAuxiliar[x][y] = isLiveOnNextCycle(x, y)
            }
        }
        matrix = matrixAuxiliar
        render(matrix)
    }

    func isLiveOnNextCycle(_ x: Int, _ y: Int) -> Bool {
        //        if x%2 == 0 {
        //            return false
        //        } else {
        //            return true
        //        }
        if x == 0 || y == 0 || y == heightSize-1 || x == widthSize-1 {
            return matrix[x][y]
        }
        let total =
            matrix[x-1][y-1].intValue +
            matrix[x][y-1].intValue +
            matrix[x+1][y-1].intValue +
            matrix[x-1][y].intValue +
            matrix[x+1][y].intValue +
            matrix[x-1][y+1].intValue +
            matrix[x][y+1].intValue +
            matrix[x+1][y+1].intValue

        switch total {
        case 2:
            if matrix[x][y] {
                return true
            } else {
                return false
            }
        case 3:
            if matrix[x][y] {
                return true
            } else {
                return true
            }
        default: return false
        }
    }

    func render(_ matrix: [[Bool]]) {
        let black = RGBA(r: 0, g: 0, b: 0, a: 255)
        let green = RGBA(r: 0, g: 255, b: 0, a: 255)

        var data = [RGBA]()


        for y in 0 ..< heightSize {
            for x in 0 ..< widthSize {
                if matrix[x][y] {
                    data.append(green)
                } else {
                    data.append(black)
                }
            }
        }

        let bitsPerComponent: Int = MemoryLayout<UInt8>.size * 8
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()

        let cgContext = CGContext(
            data: &data,
            width: widthSize,
            height: heightSize,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: widthSize * 4,//(4 * size) / 8,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )

        guard let cgImage = cgContext?.makeImage() else {
            fatalError()
        }

        let uiImage: UIImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }

    func runLoop() {
        if isPlaying {
            self.timer.upstream.connect().cancel()
        } else {
            self.timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
        }
        self.isPlaying.toggle()
    }

    func loadImage() {
        let black = RGBA(r: 0, g: 0, b: 0, a: 255)
        let yellow = RGBA(r: 0, g: 255, b: 0, a: 255)

        var data = [RGBA]()

        for y in 0 ..< heightSize {
            for x in 0 ..< widthSize {
                if Bool.random() {
                    matrix[x][y] = false
                    data.append(black)
                } else {
                    if Bool.random() {
                        matrix[x][y] = true
                        data.append(yellow)
                    }
                }
            }
        }
        render(matrix)
        return
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
