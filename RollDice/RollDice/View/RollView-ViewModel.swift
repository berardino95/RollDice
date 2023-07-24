//
//  RollView-ViewModel.swift
//  RollDice
//
//  Created by Berardino Chiarello on 22/07/23.
//

import CoreHaptics
import Foundation
import SwiftUI

extension RollView {
    
    @MainActor class ViewModel : ObservableObject {
        
        @Published var data : Dice
        
        
        @Published var time = 0
        @Published var timer = Timer.publish(every: 0.2,tolerance: 0.5, on: .main,in: .common).autoconnect()
        
        var columns : [GridItem]{
            if data.numberOfDice.rawValue == 2 || data.numberOfDice.rawValue == 4{
                return [GridItem(.flexible(maximum: 150)), GridItem(.flexible(maximum: 150))]
            }
            return [GridItem(.flexible(maximum: 150))]
        }
        
        @Published var results = [1,1,1,1]
        @Published var isShowed = false
        
        @Published var sum = 0
        @Published var feedback = UINotificationFeedbackGenerator()
        
        @Published var engine: CHHapticEngine?
        @Published var resultForEachDice = ""
        
        init() {
            self.data = DataManager.loadData()
        }
        
        func start(voiceOver: Bool){
            timer = Timer.publish(every: 0.2,tolerance: 0.5, on: .main,in: .common).autoconnect()
            time = 0
            
            if data.hapticFeedbackIsEnable && voiceOver == false {
                
                feedback.notificationOccurred(.success)
                complexSuccess()
                
            }
            
            print("start")
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
            print("sum")
        }
        
        func stop(voiceOver: Bool){
            timer.upstream.connect().cancel()
            calculateTotal()
            calculateResultForEachDice()
            withAnimation {
                isShowed = true
            }
            
            if voiceOver == false{
                feedback.notificationOccurred(.success)
            }
            
            data.results.append(Result(total: sum, resultForEachDice: resultForEachDice))
            DataManager.save(data)
            print("stop")
        }
        
        func calculateResultForEachDice(){
            var filteredResult = [Int]()
            for index in 0..<data.numberOfDice.rawValue {
                filteredResult.append(results[index])
            }
            resultForEachDice = filteredResult.map{String($0)}.joined(separator: ", ")
            print("each dice string")
        }
        
        func prepareHaptics() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            }catch {
                print("There was an error creating the engine: \(error.localizedDescription)")
            }
        }
        
        
        func complexSuccess() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            var events = [CHHapticEvent]()
            
            for i in stride(from: 0, to: 1, by: 0.15){
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: Double(2 - i))
                events.append(event)
            }
            
            // convert those events into a pattern and play it immediately
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            }catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        }
        
    }
    
    
}
