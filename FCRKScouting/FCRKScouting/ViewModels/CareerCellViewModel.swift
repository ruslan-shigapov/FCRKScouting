//
//  CareerCellViewModel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

protocol CareerCellViewModelProtocol {
    var year: String { get }
    var league: String { get }
    var coachName: String { get }
}

final class CareerCellViewModel: CareerCellViewModelProtocol {
    
//    private let player: Player
    
    var year: String {
        "2024"
    }
    
    var league: String {
        "Рубин-М. Тренер:"
    }
    
    var coachName: String {
        "Яруллин/Хораськин"
    }
    
//    init(player: Player) {
//        self.player = player
//    }
}
