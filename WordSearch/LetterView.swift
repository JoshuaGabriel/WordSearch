//
//  LetterView.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

/*
    Represents each individual letter on the grid, this struct is called how many times there are bubbles on the grid
 
 Boolean values:
    highlight - has been passed by
    hovering -  where the mouse is currently hovering
    finished - if the word has been found keep it highlighted
 */


struct LetterView:View{
    
    var highlight: Bool = false
    var character: String
    var hovering: Bool = false
    var finished: Bool = false
    
    private let colors: [String] = ["red","orange","pink","blue","green","purple","clear"]
    
    var body: some View{
        ZStack{
            Circle()
                .fill(hovering || finished ?  Color.orange : Color.yellow)
                .frame(width:23,height:23)
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
