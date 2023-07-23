//
//  SettingsView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            Form{
                Section("How many dice you want?"){
                    Picker("Number of dice", selection: $vm.data.numberOfDice) {
                        ForEach(DiceNumber.allCases) { number in
                            Text("\(number.rawValue)")
                        }
                        //                    .onChange(of: vm.appData.numberOfDice, perform: { _ in DataManager.save(vm.appData) })
                    }
                }
                
                Section("How many faces?") {
                    Picker("Number of faces", selection: $vm.data.diceFaces) {
                        ForEach(DiceFaces.allCases) { number in
                            Text("\(number.rawValue)")
                        }
                        //                    .onChange(of: vm.appData.diceFaces, perform: { _ in DataManager.save(vm.appData) })
                    }
                }
            }
            
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
