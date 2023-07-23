//
//  RollView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct RollView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack{
                    Text("You are rolling")
                    Text("\(vm.data.numberOfDice.rawValue) dice with \(vm.data.diceFaces.rawValue) faces")
                }
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
                
                Spacer()
                
                Button{
                    vm.start()
                } label: {
                    Text("Roll")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(.secondary)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)  )
                }
                Spacer()
            }
            .onAppear{ vm.data = DataManager.loadData()
                vm.timer.upstream.connect().cancel()
                vm.roll()
                vm.feedback.prepare()
            }
            .onReceive(vm.timer) { time in
                if vm.time < 10 {
                    vm.time += 1
                    vm.roll()
                    print("\(vm.time)")
                } else {
                    vm.stop()
                }
            }
            .allowsHitTesting(vm.isShowed == false ? true : false)
            .blur(radius: vm.isShowed == true ? 1.5 : 0)
            
            
            
            if vm.isShowed {
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                        .shadow(radius: 20)
                    VStack(spacing: 10){
                        Text("You total score is:")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("\(vm.sum)")
                            .font(.system(size: 60))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    VStack{
                        HStack{
                            Spacer()
                            Button{
                                vm.isShowed = false
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .font(.title)
                                    .padding()
                                    .foregroundColor(.red)
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
