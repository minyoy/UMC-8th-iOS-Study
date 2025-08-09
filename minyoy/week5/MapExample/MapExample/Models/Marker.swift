//
//  Marker.swift
//  MapExample
//
//  Created by 주민영 on 4/10/25.
//

import Foundation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}
