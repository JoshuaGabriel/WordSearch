//
//  ContentView.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-08-28.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI
import Combine





struct ContentView: View {
    
    @State private var score = 0
    @State private var words_found = 0
    private var grid = ModelBoard()
    @State private var isGameOver = false
    
    func buttonAction(_ index: Int) {
        
    }
    
    
    var body: some View {
        
        
        ZStack{
            Rectangle()
                .foregroundColor(
                    Color(red: 0/255,
                          green: 200/255,
                          blue: 220/255))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("star")
                    Text("Word Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Image("star")
                    Spacer()
                }.scaleEffect(1)
                
                Grid_view()
                
                Spacer()
                
                
                HStack{
                    Spacer()
                    Text("Score: " + String(score))
                        
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Text("Words Found: " + String(words_found))
                        
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    Spacer()
                }.scaleEffect(1.4)
                
                
                
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
