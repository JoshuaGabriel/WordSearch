//
//  WordAlgorithm.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-09-03.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI

class Algorithm: ObservableObject{
    @Published var squares: [[String]]
    private var wordBank: [String] = ["SWIFT", "KOTLIN", "OBJECTIVEC", "VARIABLE", "JAVA", "MOBILE"]
    
    
    private let directions = ["leftright","updown","diagonaldown","diagonalup"]
    private var orientation: String
    private var step: Step
    private var start: Step
    private var end: Step
    private var cur: Step
    private var letter: String
    private var condition : Bool
    private var placed : Bool
    private let grid_size = 12
    
    
    init(squares:[[String]]){
        self.squares = squares
        self.orientation = ""
        self.placed = false
        self.step = Step(stepX: 0,stepY: 0)
        self.start = Step(stepX: 0,stepY: 0)
        self.end = Step(stepX: 0,stepY: 0)
        self.cur = Step(stepX: 0,stepY: 0)
        self.letter = ""
        self.condition = false

    }
    
    func crossWord() -> [[String]]{

        for word in wordBank{
            
            self.placed = false
            
            while(!self.placed){
                
                orientation = directions.randomElement()!
                
                if(orientation=="leftright"){
                    self.step = Step(stepX: 1, stepY: 0)
                }
                if(orientation=="updown"){
                    self.step = Step(stepX: 0, stepY: 1)
                }
                if(orientation=="diagonaldown"){
                    self.step = Step(stepX: 1, stepY: 1)
                }
                if(orientation=="diagonalup"){
                    self.step = Step(stepX: 1, stepY: -1)
                }
                
                self.start = Step(stepX: Int.random(in: 0..<self.grid_size),
                                  stepY: Int.random(in: 0..<self.grid_size))
                
                self.end = Step(stepX: self.start.stepX + word.count*self.step.stepX,
                                  stepY: self.start.stepY + word.count*self.step.stepY)
                
                if(self.end.stepX<0 || self.end.stepX>=self.grid_size){
                    continue
                }
                if(self.end.stepY<0 || self.end.stepY>=self.grid_size){
                    continue
                }
                
                self.condition = false
                
                for i in 0..<word.count{
                    self.letter = String(word[word.index(word.startIndex, offsetBy:i)])
                    
                    self.cur = Step(stepX: self.start.stepX + i*step.stepX,
                                    stepY: self.start.stepY + i*step.stepY)
                    
                    //print("\(String(self.squares[self.cur.stepX][self.cur.stepY]) == String("_")) || \(word)")
                    if(self.squares[self.cur.stepX][self.cur.stepY] == String("_")){
                        
                        continue
                    }else{
                        self.condition = true
                        break
                    }
            
                }
                
                if(self.condition){
                    continue
                }else{
//                    print("placing")
                    for num in 0..<word.count{
                        

                        self.letter = String(word[word.index(word.startIndex, offsetBy:num)])
                        
                        self.cur = Step(stepX: self.start.stepX + num*step.stepX,
                                        stepY: self.start.stepY + num*step.stepY)
                        
                        self.squares[self.cur.stepX][self.cur.stepY] = self.letter
                    }
                    self.placed = true
                }
            }
            
        }
        return self.squares
    }
}

struct WordAlgorithm: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WordAlgorithm_Previews: PreviewProvider {
    static var previews: some View {
        WordAlgorithm()
    }
}
