//
//  LetterView.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct LetterView:View{
    
    var highlight: Bool = false
    var character: String
    var hovering: Bool = false
    var finished: Bool = false
    
    var body: some View{
        ZStack{
            Circle()
                .fill(hovering || finished ? Color.red : Color.blue)
                .frame(width:25,height:20)
                .scaleEffect(highlight && !finished ? 1.5 : 1)
                .animation(.easeInOut(duration: 0.25))
            
                
            Text(character)
                .frame(width: 25, height: 20)
                .scaleEffect(highlight && !finished  ? 1.5 : 1)
                .animation(.easeInOut)
                .font(.system(size:18))
            
            

        }
    }
}
struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView( highlight: true,
                    character: "A",
                    hovering: true,
                    finished: false)
    }
}
