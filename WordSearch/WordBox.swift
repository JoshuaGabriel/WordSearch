//
//  WordBox.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-04.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct WordBox:View {
    
    @Binding var wordBank: [String]
    @Binding var state: [Bool]
    
    var body: some View{
        
        VStack(alignment: .center){
            HStack(alignment: .center, spacing: 14.0){
                ForEach(0..<3){k in
                    Text(self.wordBank[k])
                        .strikethrough(self.state[k])
                        .frame(width: 120.0, height: 55)
                }
            }
            
            HStack{
                ForEach(3..<6){k in
                    Text(self.wordBank[k])
                        .strikethrough(self.state[k])
                        .frame(width: 120.0, height: 55)
                    
                }
            }
        }       //.background(Color(red: 84/255, green: 158/255, blue: 1))
                .background(Color.yellow)
                .cornerRadius(20)
    }
}


struct WordBox_Previews: PreviewProvider {
    static var previews: some View {
        WordBox(wordBank: Binding.constant(["Example","Example"]),state: Binding.constant([false,false]))
    }
}
