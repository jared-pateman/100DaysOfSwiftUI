//
//  ContentView.swift
//  iExpense
//
//  Created by Jared Pateman on 15/08/2023.
//

import SwiftUI

struct ExpenseView: View {
    var item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .black : .red)
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                if !expenses.personalItems.isEmpty {
                    Section("Personal") {
                        ForEach(expenses.personalItems) { personalItem in
                            ExpenseView(item: personalItem)
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if !expenses.businessItems.isEmpty {
                    Section("Business") {
                        ForEach(expenses.businessItems) { businessItem in
                            ExpenseView(item: businessItem)
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    // Look through each item in the list. Find the specific item we're trying to delete
    // set index to be the corresponding item in expenses.items, then remove it if found.
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
