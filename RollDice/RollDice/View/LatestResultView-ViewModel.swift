//
//  LatestResultView-ViewModel.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation
extension LatestResultView{
    
    @MainActor class ViewModel : ObservableObject {
        
        @Published var data = DataManager.loadData()
        @Published var confirmIsShowed = false
        
        func deleteAllResults(){
            data.results = []
            DataManager.save(data)
        }
        
    }
    
}
