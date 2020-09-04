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



struct LetterView:View{
    
    var highlight: Bool = false
    var character: String
    var hovering: Bool = false
    
    var body: some View{
        ZStack{
            Circle()
                .fill(hovering ? Color.red : Color.blue)
                .frame(width:25,height:20)
                .scaleEffect(highlight ? 1.5 : 1)
                .animation(.easeInOut(duration: 0.25))
            
                
            Text(character)
                .frame(width: 25, height: 20)
                .scaleEffect(highlight  ? 1.5 : 1)
                .animation(.easeInOut)
                .font(.system(size:18))
            
            

        }
    }
}

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
        //let xNegate = -xMove
        
        
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
    
    @State private var hovering_i: Int? = nil
    @State private var hovering_j: Int? = nil
    @GestureState private var location: CGPoint = .zero
    
    @State private var coords: [Point] = []
    @State private var direction: Step? = nil
//    private var gridReference: [Point] = []
    private let grid_size = 12

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
    
    
    init() {
        self.squares = Array(repeating: Array(repeating: "_", count: self.grid_size), count: self.grid_size)
        self.board = Algorithm(squares: self.squares)
        self.squares = self.board.crossWord()
        
        for k in 0..<self.grid_size{
            for j in 0..<self.grid_size{
                random_letter = String(characters[Int.random(in: 0..<26)])
//                self.gridReference.append(Point(xIndex: k, yIndex: j))
                if(self.squares[k][j]=="_"){
                    self.squares[k][j] = random_letter
                }
                
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
                            self.direction!.compare(first: self.coords[0], second: cur)){
                            
                            self.direction!.add(first: cur)
                            
                            self.coords.append(cur)
                        }

                    }else if(!self.coords.contains(cur)){
                        self.coords.append(cur)
                    }
                    
                    if(self.coords.count==2){
                        self.movement(first: self.coords[0], second: self.coords[1])
                        self.direction!.add(first: cur)
                    }
                    
//                    for i in self.coords{
//                        print("\(i.xIndex) || \(i.yIndex) || step: \(self.direction?.stepX ?? 0) || \(self.direction?.stepY ?? 0)")
//                    }

                    self.hovering_i = index_i
                    self.hovering_j = index_j

                }
            }
            return AnyView(Circle())
        }
    }

    private var Grid: some View{
        VStack{
            Spacer()
            ZStack{
                Text("\(self.squares[hovering_i ?? 0][hovering_j ?? 0])")
                HStack{
                    ForEach(0..<self.grid_size){i in
                        //Spacer()
                            VStack{
                                ForEach(0..<self.grid_size){ j in
                                    LetterView(highlight: ((self.hovering_i==i && self.hovering_j==j)),
                                               character: self.squares[i][j],
                                               hovering: self.coords.contains(Point(xIndex: i, yIndex: j)))
                                        .background(self.rectReader(index_i: i, index_j: j))
                                }
                                
                        }
                        //Spacer()
                    }
                }
            }
            Spacer()
            VStack{
                HStack{
                    ForEach(0..<3){k in
                        Text(self.board.wordBank[k])
                    }
                }
                HStack{
                    ForEach(3..<6){k in
                        Text(self.board.wordBank[k])
                    }
                }

            }

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

                }
            }
        
        return
            ZStack{
                Grid
                    .gesture(hover)
               
                
                
        }

    }
    
}





struct Grid_view: View {
    @State private var grid = ModelBoard()
    

    
    @State private var x_cur = 0
    @State private var y_cur = 0

    var body: some View {
            self.grid
    }
}


struct Grid_view_Previews: PreviewProvider {
    static var previews: some View {
        Grid_view()
    }
}


