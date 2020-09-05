//
//  ContentView.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-08-28.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var reset: Bool = false
    
    
    var body: some View {
        
        
        ZStack{
            Rectangle()
            .foregroundColor(Color(red: 27/255, green: 27/255, blue: 27/255))
                    .edgesIgnoringSafeArea(.all)
                       
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("star")
                    Text("Word Search")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .padding(.all, 14.0)
                        .background(Color.yellow)
                        .cornerRadius(20)
                        .frame(width:250.0,height: 100)
          
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
