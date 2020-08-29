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

//class Square {
//    var char:String
//    init(_ char: String) {
//        self.char = char
//    }
//
//    func getter() -> String{
//        return self.char
//    }
//
//}

class ModelBoard{
    private var squares: [[String]] = []
    
    private var random_letter = "a"
    
    
    
    // TODO: Create logic to display words needed for crossword puzzle
    // Completed today : able to view all words in an array
    
    init() {
        self.squares = Array(repeating: Array(repeating: "_", count: 10), count: 10)
        
        for k in 0..<10{
            for j in 0..<10{
                random_letter = String(characters[Int.random(in: 0..<26)])
                self.squares[k][j] = random_letter
            }
        }
        
        
    }
    
    func lookup(_ i:Int,_ j:Int) -> String{
        let str = self.squares[i][j]
        return str
    }
    
}



//struct SquareView: View{
//
//    @State private var grid = ModelBoard()
//
//    private var random_letter = characters[Int.random(in: 0..<26)]
//
//    public init() {}
//
//    var body: some View{
//        Text(grid.lookup(0,0))
//    }
//}
struct Grid_view: View {
    @State private var grid = ModelBoard()
    var body: some View {
        
        HStack{
            ForEach(0..<10){i in
                
                Spacer()
        
                VStack{
                    ForEach(0..<10){ j in
                        Text(self.grid.lookup(i, j))
                            
                        .frame(width: 25, height: 25)
                    }
                }
                Spacer()
            }
        }
        
    }
}


struct Grid_view_Previews: PreviewProvider {
    static var previews: some View {
        Grid_view()
    }
}
