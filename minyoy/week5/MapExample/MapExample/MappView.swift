//
//  MappView.swift
//  MapExample
//
//  Created by 주민영 on 4/10/25.
//

import SwiftUI
import MapKit

struct MappView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack {
            CustomMap(locationManager: locationManager)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    MappView()
}
