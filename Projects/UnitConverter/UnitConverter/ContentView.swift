//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jared Pateman on 27/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert: Double = 20.0
    @State private var selectedInputUnit: String = "meters"
    @State private var selectedOutputUnit: String = "miles"
    @FocusState private var conversionIsFocused: Bool

    private let units: [String: UnitLength] = [
        "millimeters": .millimeters,
        "centimeters": .centimeters,
        "meters": .meters,
        "kilometers": .kilometers,
        "feet": .feet,
        "yards": .yards,
        "miles": .miles,
        "inches": .inches
    ]

    var convertedValue: Double {
        guard
            let inputUnitType = units[selectedInputUnit],
            let outputUnitType = units[selectedOutputUnit]
        else { return 0 }

        let inputUnitAmount = Measurement(value: valueToConvert, unit: inputUnitType)
        let convertedUnit = inputUnitAmount.converted(to: outputUnitType)

        return convertedUnit.value
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit", selection: $selectedInputUnit) {
                        ForEach(Array(units.keys), id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Input unit")
                }

                Section {
                    TextField("Amount to convert", value: $valueToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($conversionIsFocused)
                } header: {
                    Text("Input unit amount")
                }

                Section {
                    Picker("Unit", selection: $selectedOutputUnit) {
                        ForEach(Array(units.keys), id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Output unit")
                }

                Section {
                    Text(convertedValue, format: .number)
                }
                header: {
                    Text("Conversion from \(selectedInputUnit) to \(selectedOutputUnit)")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        conversionIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
