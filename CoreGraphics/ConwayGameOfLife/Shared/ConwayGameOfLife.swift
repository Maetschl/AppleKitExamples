//
//  ConwayGameOfLife.swift
//  ConwayGameOfLife
//
//  Created by Julian Arias Maetschl on 06-01-21.
//

import SwiftUI
import Combine
import Accelerate

class ConwayGameOfLife {

}

class ConwayGameOfLifeRenderer: ObservableObject {
    
    @Published var counter: Int = 0
    @Published var image: Image?
    var cgImage: CGImage!
    @Published var isPlaying: Bool = true

    static let widthSize: Int = 45*3
    static let heightSize: Int = 90*3
    let loopTime: TimeInterval = 10
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    var matrix: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: heightSize), count: widthSize)
    var matrixAuxiliar: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: heightSize), count: widthSize)

    var data = [RGBA]()

    let black = RGBA(r: 0, g: 0, b: 0, a: 255)
    let yellow = RGBA(r: 100, g: 100, b: 0, a: 255)
    let green = RGBA(r: 0, g: 255, b: 0, a: 255)

    init() {
        loadImage()
    }

    func nextGeneration() {

        data = [RGBA](repeating: black, count: Self.heightSize * Self.widthSize)
        for y in 0 ..< Self.heightSize {
            for x in 0 ..< Self.widthSize {
                matrixAuxiliar[x][y] = isLiveOnNextCycle(x, y)
                if matrixAuxiliar[x][y] {
                    data[y * Self.widthSize + x] = green
                }
            }
        }
        matrix = matrixAuxiliar
        render()
    }

    func isLiveOnNextCycle(_ x: Int, _ y: Int) -> Bool {
        //        if x%2 == 0 {
        //            return false
        //        } else {
        //            return true
        //        }
        if x == 0 ||
            y == 0 ||
            y == Self.heightSize - 1 ||
            x == Self.widthSize - 1 {
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
            return matrix[x][y]
        case 3:
            return true
        default:
            return false
        }
    }

    static let bitsPerComponent: Int = MemoryLayout<UInt8>.size * 8
    static let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    var cgContext: CGContext!

    func render() {
        self.cgContext = CGContext(
            data: &data,
            width: Self.widthSize,
            height: Self.heightSize,
            bitsPerComponent: Self.bitsPerComponent,
            bytesPerRow: Self.widthSize * 4,//(4 * size) / 8,
            space: Self.colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        self.cgImage = cgContext.makeImage()
        counter += 1
    }

    func getRender() -> UIImage {
        return UIImage(cgImage: cgImage)
    }

    let interval: TimeInterval = 0.01
    func runLoop() {
        if isPlaying {
            self.timer.upstream.connect().cancel()
        } else {
            self.timer = Timer.publish(every: interval, on: .main, in: .default).autoconnect()
        }
        self.isPlaying.toggle()
    }

    func loadImage() {
        data = [RGBA](repeating: black, count: Self.heightSize * Self.widthSize)
        for y in 0 ..< Self.heightSize {
            for x in 0 ..< Self.widthSize {
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
        render()
        self.timer = Timer.publish(every: interval, on: .main, in: .default).autoconnect()
    }

}
