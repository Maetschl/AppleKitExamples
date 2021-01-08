//
//  ConwayGameOfLife.swift
//  ConwayGameOfLife
//
//  Created by Julian Arias Maetschl on 06-01-21.
//

import SwiftUI
import Combine

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
    let yellow = RGBA(r: 0, g: 255, b: 0, a: 255)
    let green = RGBA(r: 0, g: 255, b: 0, a: 255)

    init() {
        loadImage()
    }

    func nextGeneration() {
        for x in 0 ..< Self.widthSize {
            for y in 0 ..< Self.heightSize {
                matrixAuxiliar[x][y] = isLiveOnNextCycle(x, y)
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

    func render() {

        data = [RGBA]()
        for y in 0 ..< Self.heightSize {
            for x in 0 ..< Self.widthSize {
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
            width: Self.widthSize,
            height: Self.heightSize,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: Self.widthSize * 4,//(4 * size) / 8,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )

        guard let cgImage = cgContext?.makeImage() else {
            fatalError()
        }

        self.cgImage = cgImage
        counter += 1
    }

    func getRender() -> UIImage {
        return UIImage(cgImage: cgImage)
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
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }

}