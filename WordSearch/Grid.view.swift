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

private let orientation = ["leftright","updown","diagonalup","diagonaldown"]

class Square {
    var char:String
    init(_ char: String) {
        self.char = char
    }
    
    func getter() -> String{
        return self.char
    }
    
}

class ModelBoard{
    private var squares: [[Square]] = []
    private var random_letter = String(characters[Int.random(in: 0..<26)])
    
    init() {
        self.squares = Array(repeating: Array(repeating: Square(random_letter), count: 10), count: 10)
    }
    
    func lookup(_ i:Int,_ j:Int) -> String{
        let str = String(self.squares[i][j].getter())
        return str
    }
    
}

struct SquareView:View{

    @State private var grid = ModelBoard()
    private var random_letter = characters[Int.random(in: 0..<26)]

    var body: some View{
        Text(grid.lookup(2, 4))
    }
}
struct Grid_view: View {
    @State private var grid = ModelBoard()
    
    var body: some View {
        
        VStack{
            HStack{
                ForEach(0..<10){i in
                    
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
