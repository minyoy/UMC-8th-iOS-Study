//
//  Place.swift
//  MapExample
//
//  Created by 주민영 on 4/10/25.
//

import Foundation
import MapKit

struct Place: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem
}
