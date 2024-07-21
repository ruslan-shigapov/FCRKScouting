//
//  FiltersViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 21.07.2024.
//

protocol FiltersViewModelProtocol {
    var isFiltersActive: Bool { get }
}

final class FiltersViewModel: FiltersViewModelProtocol {
    
    var isFiltersActive: Bool {
        false
    }
}
