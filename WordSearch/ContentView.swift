//
//  ContentView.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-08-28.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
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
                
                Spacer()
                                
                ModelBoard()
                
                Spacer()

            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
