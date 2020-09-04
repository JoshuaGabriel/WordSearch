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

class Point:Equatable{
    var xIndex: Int
    var yIndex: Int

    init(xIndex:Int, yIndex:Int) {
        self.xIndex = xIndex
        self.yIndex = yIndex
    }
    
    func getX()->Int{
        return self.xIndex
    }
    func getY()->Int{
        return self.yIndex
    }


    
    static func == (lhs: Point, rhs: Point) -> Bool {
        if((lhs.xIndex == rhs.xIndex) && (lhs.yIndex == rhs.yIndex)){
            return true
        }else{
            return false
        }
        
    }
}


struct Step:Equatable{
    var stepX: Int
    var stepY: Int
    var step: Direction = Direction.up
    
    mutating func add(first:Point)->Void{
        
        switch self.step {
        case .up:
            self.stepY-=1
        case .down:
            self.stepY+=1
        case .left:
            self.stepX-=1
        case .right:
            self.stepX+=1
        case .upLeft:
            self.stepY-=1
            self.stepX-=1
        case .upRight:
            self.stepY-=1
            self.stepX+=1
        case .downLeft:
            self.stepY+=1
            self.stepX-=1
        case .downRight:
            self.stepY+=1
            self.stepX+=1
        }
    }
    func compare(first: Point, second: Point) -> Bool{
        let xMove = second.xIndex - first.xIndex
        let yMove = second.yIndex - first.yIndex

        
        
        switch self.step{
        case .up:
            if(yMove==self.stepY && xMove==0){
                return true
            }
        case .down:
            if(yMove==self.stepY && xMove==0){
                return true
            }
        case .left:
            if(yMove==0 && xMove==self.stepX){
                return true
            }
        case .right:
            if(yMove==0 && xMove==self.stepX){
                return true
            }
        default:
            if(yMove==self.stepY && xMove==self.stepX){
                return true
            }
        }
        return false
    }
    
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        if((lhs.stepX == rhs.stepX) && (lhs.stepY == rhs.stepY)){
            return true
        }else{
            return false
        }
    }
}

enum Direction{
    case up
    case down
    case left
    case right
    case upLeft
    case upRight
    case downLeft
    case downRight
}

struct ModelBoard: View{

    private var squares: [[String]] = []
    @ObservedObject private var board: Algorithm
    private var random_letter = "a"
    @State var score:Int = 0
    @State private var hovering_i: Int? = nil
    @State private var hovering_j: Int? = nil
    @State private var curLetter: String = ""
    @State var wordBank: [String] = ["SWIFT", "KOTLIN", "OBJECTIVEC", "VARIABLE", "JAVA", "MOBILE"]
    @State var wordBankState: [Bool] = [false,false,false,false,false,false]
    @GestureState private var location: CGPoint = .zero
    
    @State private var coords: [Point] = []
    @State private var finished: [Point] = []
    @State private var direction: Step? = nil
    private let grid_size = 12
    
    
    init() {
        self.squares = Array(repeating: Array(repeating: "_", count: self.grid_size), count: self.grid_size)
        self.board = Algorithm(squares: self.squares)

        self.squares = self.board.crossWord()
        
        for k in 0..<self.grid_size{
            for j in 0..<self.grid_size{
                

                if(self.squares[k][j]=="_"){
                    self.squares[k][j] = String(characters[Int.random(in: 0..<26)])
                }

            }
        }
    }

    
    func movement(first:Point, second:Point) -> Void{
        let xMove = second.xIndex - first.xIndex
        let yMove = second.yIndex - first.yIndex
        
        if(yMove==0){
            if(xMove>0){
                self.direction = Step(stepX: 1,stepY: 0,step: .right)
            }else{
                self.direction = Step(stepX: -1,stepY: 0,step: .left)
            }
        }else if(xMove==0){
            if(yMove>0){
                self.direction = Step(stepX: 0,stepY: 1,step: .down)
            }else{
                self.direction = Step(stepX: 0,stepY: -1,step: .up)
            }
        }else if(xMove>0){
            if(yMove>0){
                self.direction = Step(stepX: 1,stepY: 1,step: .downRight)
            }else{
                self.direction = Step(stepX: 1,stepY: -1,step: .upRight)
            }
        }else{
            if(yMove>0){
                self.direction = Step(stepX: -1,stepY: 1,step: .downLeft)
            }else{
                self.direction = Step(stepX: -1,stepY: -1,step: .upLeft)
            }
        }
    }
    
    

    
    func rectReader(index_i: Int, index_j: Int) -> some View{
        let cur = Point(xIndex:index_i,yIndex:index_j)
        return GeometryReader { (geometry) -> AnyView in

            if geometry.frame(in: .global).contains(self.location) {
                DispatchQueue.main.async {
                    
                    
                    if(self.direction != nil){
                        
                        if(!self.coords.contains(cur) &&
                            self.direction!.compare(first: self.coords[0], second: cur) &&
                            !self.finished.contains(cur)){
                            
                            self.direction!.add(first: cur)
                            
                            self.coords.append(cur)
                            self.curLetter += self.squares[index_i][index_j]
                        }

                    }else if(!self.coords.contains(cur) && !self.finished.contains(cur)){
                        self.coords.append(cur)
                        self.curLetter += self.squares[index_i][index_j]
                    }
                    
                    if(self.coords.count==2){
                        self.movement(first: self.coords[0], second: self.coords[1])
                        self.direction!.add(first: cur)
                    }
                    

                    for index in 0..<self.wordBank.count{
                        if(self.wordBank[index]==self.curLetter && !self.wordBankState[index]){
                            
                            self.wordBankState[index] = true
                            for point in self.coords{
                                self.finished.append(point)
                            }
                            self.score += 1
                        }
                    }
                    
                    self.hovering_i = index_i
                    self.hovering_j = index_j
                }
            }
            return AnyView(Circle())
        }
    }

    private var Grid: some View{
        VStack{
            Score(score: self.$score)
            Spacer()
            Spacer()
            ZStack{
                HStack{
                    ForEach(0..<self.grid_size){i in
                        VStack{
                            ForEach(0..<self.grid_size){ j in
                                LetterView( highlight: ((self.hovering_i==i && self.hovering_j==j)),
                                            character: self.squares[i][j],
                                            hovering: self.coords.contains(Point(xIndex: i, yIndex: j)),
                                            finished: self.finished.contains(Point(xIndex: i, yIndex: j)))
                                    .background(self.rectReader(index_i: i, index_j: j))
                            }
                        }
                    }
                }
            }
            Spacer()
            CurrentWord(word:self.curLetter)
            Spacer()
            WordBox(wordBank: self.$wordBank,state: self.$wordBankState)
        }
    }
        
    
    var body: some View{
        let hover = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .updating($location){(value,state,transaction) in
                state = value.location
            }.onEnded{_ in
                withAnimation{
                    self.hovering_j = nil
                    self.hovering_i = nil
                    self.coords.removeAll()
                    self.direction = nil
                    self.curLetter = ""
                }
            }
        return
            ZStack{
                Grid.gesture(hover)
            }

    }
    
}

struct ModelBoard_Previews: PreviewProvider {
    static var previews: some View {
        ModelBoard()
    }
}


