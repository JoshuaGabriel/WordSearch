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
        HStack(alignment: .center){
            Spacer()
            
            Text("Words Found: " + String(self.score))
                .multilineTextAlignment(.center)
                .padding([.top, .bottom, .trailing], 3.0)
                .background(Color.yellow)

                .cornerRadius(20)
            Spacer()
        }.scaleEffect(1.2)
    }
}

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        Score(score: Binding.constant(0))
    }
}
