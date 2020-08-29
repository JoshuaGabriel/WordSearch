//
//  Grid.view.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-08-28.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI
import Combine

private let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
private let characters = Array(letters)
private let numbers = Array(repeating: 0, count: 26)
private let words = ["Swift", "Kotlin", "ObjectiveC", "Variable", "Java", "Mobile"]


class Square {
    var char:Character
    init(_ char: Character) {
        self.char = char
    }
}

class ModelBoard {
    var squares = [Square]()
    
    init() {
        for _ in 0...99 {
            squares.append(Square("_"))
        }
    }
    
}

struct SquareView:View{
    
    var body: some View{
        Button(action:{
            
        }){
            Text(String(characters[Int.random(in: 0..<26)]))
            .bold()
                .foregroundColor(.black)
        }
    }
}
struct Grid_view: View {
    
    private var grid = ModelBoard()
    
    var body: some View {
        VStack{
            ForEach(0..<10){_ in
                
                HStack{
                    ForEach(0..<10){_ in
                        Spacer()
                        SquareView()
                            .padding(.all, 5.0)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct Grid_view_Previews: PreviewProvider {
    static var previews: some View {
        Grid_view()
    }
}
