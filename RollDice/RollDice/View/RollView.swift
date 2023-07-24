//
//  RollView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct RollView: View {
    
    @StateObject var vm = ViewModel()
    @Environment(\.colorScheme) var colorSceme
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOver
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack{
                    Text("You are rolling")
                    Text("\(vm.data.numberOfDice.rawValue) dice with \(vm.data.diceFaces.rawValue) faces")
                }
                .accessibilityElement(children: .combine)
                .font(.title)
                .foregroundColor(.secondary)
                
                Spacer()
                
                LazyVGrid(columns: vm.columns, alignment: .center){
                    ForEach(0..<vm.data.numberOfDice.rawValue, id: \.self){ number in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(.red)
                                .frame(width: 100, height: 100)
                            Text("\(vm.results[number])")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
                .accessibilityElement(children: .ignore)
                
                Spacer()
                
                Button{
                    vm.start(voiceOver: voiceOver)
                } label: {
                    Text("Roll")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(.primary)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)  )
                }
                Spacer()
                
                if vm.sum != 0 && voiceOver == true {
                    Text("Your total score is: \(vm.sum)")
                }
                
                Spacer()
                
            }
            .onAppear{ vm.data = DataManager.loadData()
                vm.timer.upstream.connect().cancel()
                vm.roll()
                vm.feedback.prepare()
                vm.prepareHaptics()
            }
            .onReceive(vm.timer) { time in
                if vm.time < 10 {
                    
                    if voiceOver == true {
                        vm.time = 10
                    } else {
                        vm.time += 1
                    }
                    
                    vm.roll()
                } else {
                    vm.stop(voiceOver: voiceOver)
                }
            }
            .allowsHitTesting(vm.isShowed == false && voiceOver == false ? true : false)
            .blur(radius: vm.isShowed == true && voiceOver == false ? 1.5 : 0)
            
            
            
            if vm.isShowed && voiceOver == false {
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(colorSceme == .dark ? Color(uiColor: .systemGray4) : .white)
                        .shadow(radius: 20)
                    VStack(spacing: 10){
                        Text("Your total score is:")
                            .font(.title)
                            .foregroundColor(colorSceme == .dark ? .white : .black)
                        Text("\(vm.sum)")
                            .font(.system(size: 60))
                            .multilineTextAlignment(.center)
                            .foregroundColor(colorSceme == .dark ? .white: .black)
                    }
                    .accessibilityElement(children: .combine)
                    VStack{
                        HStack{
                            Spacer()
                            Button{
                                vm.isShowed = false
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .font(.title)
                                    .padding()
                                    .symbolRenderingMode(.multicolor)
                            }
                        }
                        Spacer()
                    }
                }
                .frame(width: 300, height: 300)
            }
            
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
