//
//  ContentView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = Tab.rollView
    
    var body: some View {
        TabView(selection: $selectedTab){
            RollView()
                .tabItem {
                    Label("Roll", systemImage: "dice")
                }
                .tag(Tab.rollView)
            LatestResultView()
                .tabItem {
                    Label("Result", systemImage: "list.bullet.clipboard")
                }
                .tag(Tab.resultView)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
                .tag(Tab.settingsView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
