//
//  CurrentWord.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct CurrentWord: View{
    
    var word: String
    
    var body: some View{
        Text(word)
            
            .background(Color(red: 20/255, green: 235/255, blue: 1))
            .cornerRadius(15)
            .padding(.all,20)
            .scaleEffect(1.3)
            .frame(width: 300, height: 50)
    
        
    }
        
}

struct CurrentWord_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWord(word:"Example")
    }
}
