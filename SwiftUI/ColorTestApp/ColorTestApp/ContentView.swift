//
//  ContentView.swift
//  ColorTestApp
//
//  Created by Julian Arias Maetschl on 18-03-21.
//

import SwiftUI

struct ContentView: View {
    let yellow: UIColor = UIColor(red: 240.0/255.0, green: 218.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    let purple: UIColor = UIColor(red: 108.0/255.0, green: 24.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    var body: some View {
        ZStack {
            Color(yellow)
            VStack {
                HStack {
                    Image(systemName: "exclamationmark.square.fill")
                        .foregroundColor(Color(purple))
                        .font(.system(size: 30.0))
                    Text("Perdiste")
                        .foregroundColor(Color(purple))
                        .font(.system(size: 30.0))
                        .fontWeight(.heavy)
                        .padding()
                    Image(systemName: "exclamationmark.square.fill")
                        .foregroundColor(Color(purple))
                        .font(.system(size: 30.0))
                }
                Text("1000 Puntos!")
                    .foregroundColor(Color(purple))
                    .font(.system(size: 20.0))
                    .fontWeight(.heavy)
                    .padding(40.0)

                HStack {
                    Spacer()

                    Button(action: {}, label: {
                        ZStack {
                            Color(purple)
                            HStack {
                                Text("Volver a jugar")
                                    .foregroundColor(Color(yellow))
                                    .font(.system(size: 20.0))
                                    .fontWeight(.heavy)
                                Spacer()
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .foregroundColor(Color(yellow))
                                    .font(.system(size: 30.0))
                            }.padding()
                        }
                    }).frame(width: 230, height: 60, alignment: .center)
                    .cornerRadius(20.0)

                    Spacer()
                }
                HStack {
                    Spacer()

                    Button(action: {}, label: {
                        ZStack {
                            HStack {
                                Text("Volver al menú")
                                    .foregroundColor(Color(purple))
                                    .font(.system(size: 20.0))
                                    .fontWeight(.heavy)
                                Spacer()
                                Image(systemName: "line.horizontal.3.circle")
                                    .foregroundColor(Color(purple))
                                    .font(.system(size: 30.0))
                            }.padding()
                        }
                    }).frame(width: 228, height: 58, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(purple), lineWidth: 4)
                    )
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
