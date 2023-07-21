//
//  SettingsView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var dm = DataManager()
    
    var body: some View {
        Form{
            Section("How many dices you want?"){
                Picker("Number of dice", selection: $dm.numberOfDice) {
                    ForEach(DiceNumber.allCases) { number in
                        Text("\(number.rawValue)")
                    }
                }
                .onChange(of: dm.numberOfDice, perform: { _ in
                    dm.save()
                    print(dm.numberOfDice)
                })
            }
            
            Section("How many faces?") {
                Picker("Number of faces", selection: $dm.diceFaces) {
                    ForEach(DiceFaces.allCases) { number in
                        Text("\(number.rawValue)")
                    }
                }
            }
        }
        .onAppear(perform: dm.loadData)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
