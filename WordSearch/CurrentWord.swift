//
//  CurrentWord.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

/*
    Presents the current word being highlighted 
 */

struct CurrentWord: View{
    
    var word: String
    
    var body: some View{
        Text(word)
            .frame(width: 150, height: 50/1.3)
            .background(Color.orange)
            

            .cornerRadius(15)
            .scaleEffect(1.3)
            .frame(width: 300, height: 50)
    
        
    }
        
}

struct CurrentWord_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWord(word:"QWERTYUIOPAS")
    }
}
