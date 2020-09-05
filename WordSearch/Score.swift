//
//  Score.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct Score:View{
    
    @Binding var score:Int
    
    var body: some View{
        
            
            
        Text("Words Found: " + String(self.score))
        .frame(width: 140, height: 45)
            .multilineTextAlignment(.center)
            .padding(.all, 3.0)
            .background(Color.yellow)

            .cornerRadius(20)
        
            .scaleEffect(1.2)
    }
}

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        Score(score: Binding.constant(0))
    }
}
