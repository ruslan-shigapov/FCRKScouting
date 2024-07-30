//
//  FiltersViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 21.07.2024.
//

protocol FiltersViewModelProtocol {
    var isFiltersActive: Bool { get set }
    var wasRatioOfAgesWrong: (() -> Void)? { get set }
    func checkRatioOf(
        age: String?,
        andAge toAge: String?,
        completion: () -> Void)
}

final class FiltersViewModel: FiltersViewModelProtocol {
        
    var isFiltersActive: Bool 
    
    var wasRatioOfAgesWrong: (() -> Void)?
    
    init(isFiltersActive: Bool) {
        self.isFiltersActive = isFiltersActive
    }
    
    func checkRatioOf(
        age: String?,
        andAge toAge: String?,
        completion: () -> Void
    ) {
        guard Int(age ?? "") ?? 0 <= Int(toAge ?? "") ?? 0 else {
            wasRatioOfAgesWrong?()
            return
        }
        completion()
    }
}
