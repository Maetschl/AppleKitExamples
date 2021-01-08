//
//  ContentView.swift
//  TreeExplorer
//
//  Created by Julian Arias Maetschl on 07-01-21.
//

import SwiftUI
import MapKit

struct ProfileImage: View {
    var body: some View {
        Image("tree")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}

struct MapContent: View {
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.52, longitude: 111.75), latitudinalMeters: CLLocationDistance(38.52), longitudinalMeters: CLLocationDistance(111.75))))
            .flipsForRightToLeftLayoutDirection(true)
    }
}


struct ContentView: View {
    var body: some View {

        GeometryReader { geometry in
            HStack(spacing: 0.0) {
                ZStack {
                    Color(.systemBackground).opacity(0.8)

                    ScrollView {
                        VStack {
                            ProfileImage()
                            Text("Pando Forest")
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                            Text("Quaking aspen")
                                .kerning(2.0)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            HStack {
                                VStack(alignment: .leading) {
                                    Divider()
                                    Text("Latitude: 38.52° N").font(.caption)
                                    Text("Logitude: 111.75° W").font(.caption)
                                    Divider()
                                    Text("Wikipedia:\n- Pando, also known as the trembling giant, is a clonal colony of an individual male quaking aspen determined to be a single living organism by identical genetic markers and assumed to have one massive underground root system. Wikipedia")
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()
                        HStack {
                            Spacer()
                            Text("Created by Maetschl").font(.caption2)
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: geometry.size.width / 4)

                MapContent()
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1100, height: 600))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.colorScheme, .dark)
    }
}
