//
//  SettingView-ViewModel.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import Foundation

extension SettingsView {
    
    
    @MainActor class ViewModel : ObservableObject{
        
        @Published var data = DataManager.loadData() {
            willSet(newValue) {
                DataManager.save(newValue)
            }
        }
        
    }
    
}
