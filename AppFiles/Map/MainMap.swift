//
//  MainMap.swift
//  Looper
//
//  Created by Samuel Ridet on 5/17/23.
//


import SwiftUI
import MapKit
import CoreLocation

struct MainMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0451, longitude: -87.6877),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            CustomMap(coordinateRegion: $region)
                .accentColor(.blue)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        if let location = locationManager.location {
                            region.center = location.coordinate
                        }
                    }) {
                        Image(systemName: "location.circle.fill")
                            .padding()
                            .background(Color.white.opacity(0.75))
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
    }
}

struct CustomMap: UIViewRepresentable {
    @Binding var coordinateRegion: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .standard
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(coordinateRegion, animated: true)
    }
}

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
    }
}

struct MainMap_Previews: PreviewProvider {
    static var previews: some View {
        MainMap()
    }
}

