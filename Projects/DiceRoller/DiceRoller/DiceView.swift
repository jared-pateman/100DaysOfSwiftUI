//
//  DiceView.swift
//  DiceRoller
//
//  Created by Jared Pateman on 19/10/2023.
//

import SwiftUI

struct DiceView: View {
    var roll: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .frame(width: 50, height: 50)
            
            Text("\(roll)")
        }
    }
}

#Preview {
    DiceView(roll: 6)
}
