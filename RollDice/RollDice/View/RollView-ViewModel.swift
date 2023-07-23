//
//  RollView-ViewModel.swift
//  RollDice
//
//  Created by Berardino Chiarello on 22/07/23.
//

import Foundation
import SwiftUI

extension RollView {
    
    @MainActor class ViewModel : ObservableObject {
        
        @Published var data : Dice
        
        
        @Published var time = 0
        @Published var timer = Timer.publish(every: 0.2,tolerance: 0.5, on: .main,in: .common).autoconnect()
        
        let columns = [GridItem(.flexible(maximum: 150)), GridItem(.flexible(maximum: 150))]
        
        @Published var results = [1,1,1,1]
        @Published var isShowed = false
        
        @Published var sum = 0
        @Published var feedback = UINotificationFeedbackGenerator()
        
        init() {
            self.data = DataManager.loadData()
        }
        
        func start(){
            timer = Timer.publish(every: 0.2,tolerance: 0.5, on: .main,in: .common).autoconnect()
            time = 0
            feedback.notificationOccurred(.success)
        }
        
        func roll(){
            results[0] = Int.random(in: 1..<data.diceFaces.rawValue)
            results[1] = Int.random(in: 1..<data.diceFaces.rawValue)
            results[2] = Int.random(in: 1..<data.diceFaces.rawValue)
            results[3] = Int.random(in: 1..<data.diceFaces.rawValue)
        }
        
        func calculateTotal(){
            sum = 0
            for index in 0..<data.numberOfDice.rawValue {
                sum += results[index]
            }
        }
        
        func stop(){
            timer.upstream.connect().cancel()
            print("\(results)")
            calculateTotal()
            data.results.append(sum)
            DataManager.save(data)
            withAnimation {
                isShowed = true
            }
            feedback.notificationOccurred(.success)
        }
        
    }
}
