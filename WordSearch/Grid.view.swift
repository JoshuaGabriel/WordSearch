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
        let str = String(self.squares[i][j])
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

class Position{
    
    private var xcur:CGSize
    private var ycur:CGSize
    private var xaft:CGSize
    private var yaft:CGSize
    
    init(_ xcur:CGSize,_ ycur:CGSize,_ xaft:CGSize,_ yaft:CGSize) {
        self.xcur = xcur
        self.ycur = ycur
        self.xaft = xaft
        self.yaft = yaft
    }
}

struct DrawLine:Shape{
    
    @State private var currentPosition: Position
    @State private var newPosition: Position
    
    
    func path(in rect: CGRect)->Path{
        var path = Path()
        
        path.move(to:CGPoint(x:rect.minX,y:rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
    
}


struct TapGestureView: View {
    @State var tapped = false

    var tap: some Gesture {
        TapGesture(count : 1)
            .onEnded { _ in self.tapped = !self.tapped }
    }

    var body: some View {
        Circle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 25, height: 25, alignment: .center)
            .gesture(tap)
    }
}
    
struct DragGestureView: View{
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var hasTimeElapsed = false
    var letter: String

    var body: some View{
        let dragGesture = DragGesture()
            .onChanged{ value in self.offset = value.translation
                withAnimation{
                    self.isDragging = true
                }
            }
            .onEnded{ _ in
                withAnimation{
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        let pressGesture = LongPressGesture(minimumDuration:0)
            .onChanged{_ in
                withAnimation{
                   self.isDragging = true
                }
                
            }
            .onEnded{ value in
                withAnimation{
                    self.isDragging = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation{
                       self.isDragging = false
                    }
                }
                
        }
        
        let combined = pressGesture.simultaneously(with: dragGesture)
        
        return
            ZStack{
                Circle()
                .fill(isDragging ? Color.red : Color.blue)
                .frame(width:25,height:25)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
                Text(letter)
                    .frame(width: 25, height: 25)
                    .scaleEffect(isDragging ? 1.5 : 1)
                
        }
            
    }


}


struct Grid_view: View {
    @State private var grid = ModelBoard()
    private var words = ["Swift", "Kotlin", "ObjectiveC", "Variable", "Java", "Mobile"]
    @State var numbers = [0,0,0,0,0,0]
    
    @State var x_cur = 0
    @State var y_cur = 0
    @State var letter_cur = ""

    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State var xPos: CGFloat = 0
    @State var yPos: CGFloat = 0

    var body: some View {
        
            ZStack{
                Text("\(self.xPos) || \(self.yPos)")
                HStack{
                    ForEach(0..<10){i in
                        Spacer()
                        VStack{
                            ForEach(0..<10){ j in
                                ZStack{
                                    DragGestureView(letter:self.grid.lookup(i, j))
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 20.0)
//                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                    .onEnded { dragGesture in
//                        self.xPos = dragGesture.location.x
//                        self.yPos = dragGesture.location.y
//                        print(self.x_cur)
//                })
            }
        }
            
    
}


struct Grid_view_Previews: PreviewProvider {
    static var previews: some View {
        Grid_view()
    }
}
