//
//  MainModel.swift
//  demiurg
//
//  Created by Beymamat Rakhmatov on 14.08.24.
//

import UIKit

enum MainModelState {
    case alive
    case dead
}

struct MainModel {
    let text: String
    let detailText: String
    let emoji: String
    let state: MainModelState
}

class MainModelManager {
    
    private(set) var cells: [MainModel] = []
    private var consecutiveAliveCount = 0
    private var consecutiveDeadCount = 0
    
    func addCell() {
        let newCellState: MainModelState
        
        if consecutiveAliveCount == 3 {
            newCellState = .dead
            consecutiveAliveCount = 0
            consecutiveDeadCount += 1
        } else if consecutiveDeadCount == 3 {
            newCellState = .alive
            consecutiveDeadCount = 0
            consecutiveAliveCount += 1
        } else {
            newCellState = Bool.random() ? .alive : .dead
            if newCellState == .alive {
                consecutiveAliveCount += 1
                consecutiveDeadCount = 0
            } else {
                consecutiveDeadCount += 1
                consecutiveAliveCount = 0
            }
        }
        
        switch newCellState {
        case .alive:
            cells.append(MainModel(text: "Живая", detailText: "и шевелится!", emoji: "💥", state: newCellState))
        case .dead:
            cells.append(MainModel(text: "Мёртвая", detailText: "или прикидывается", emoji: "💀", state: newCellState))
        }
    }
    
}
