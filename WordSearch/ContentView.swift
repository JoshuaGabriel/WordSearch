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
                    Color(red: 25/255,
                          green: 59/255,
                          blue: 104/255))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("star")
                    Text("Word Search")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .padding(.all, 5.0)
                        .background(Color(red: 84/255, green: 158/255, blue: 1))
                        .cornerRadius(20)
                        .frame(height: 100)
                        
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
