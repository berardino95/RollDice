//
//  LatestResaultView.swift
//  RollDice
//
//  Created by Berardino Chiarello on 21/07/23.
//

import SwiftUI

struct LatestResultView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            Group{
                if vm.data.results.isEmpty {
                    Text("You didn't roll the dice yet")
                } else {
                    List{
                        ForEach(vm.data.results, id: \.self) { result in
                            Text("\(result)")
                        }
                        .onDelete(perform: deleteRow)
                    }
                }
            }
            .navigationTitle("Latest results")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Delete all"){
                        vm.confirmIsShowed  = true
                    }
                    .disabled(vm.data.results.isEmpty)
                }
            }
            .alert("Deleting all results", isPresented: $vm.confirmIsShowed) {
                Button("Yes", role: .destructive) { vm.deleteAllResults() }
                Button("No", role: .cancel) { }
            } message: {
                Text("Are you sure you want to delete all the results?")
            }
        }
        .onAppear{vm.data = DataManager.loadData()}
    }
    
    func deleteRow(at index: IndexSet){
        vm.data.results.remove(atOffsets: index)
        DataManager.save(vm.data)
    }
    
}

struct LatestResultView_Previews: PreviewProvider {
    static var previews: some View {
        LatestResultView()
    }
}
