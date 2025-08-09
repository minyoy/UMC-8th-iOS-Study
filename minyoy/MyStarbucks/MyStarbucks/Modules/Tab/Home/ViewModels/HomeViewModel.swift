//
//  HomeViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/27/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class HomeViewModel {
    
    let dummyCoffees: [CoffeeModel] = CoffeeDataSource.dummyCoffees
    
    let dummyNews: [NewsModel] = NewsDataSource.dummyNews
    
    let dummyDessert: [DessertModel] = DessertDataSource.dummyDessert
    
    var selectedCoffeeModel: CoffeeModel? = CoffeeDataSource.dummyCoffees.first
}
