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


struct LetterView:View{
    var highlight: Bool = false
    var character: String
    
    var body: some View{
        ZStack{
            Circle()
                .fill(highlight ? Color.red : Color.blue)
                .frame(width:25,height:25)
                .scaleEffect(highlight ? 1.5 : 1)
                .animation(.easeOut(duration: 0.25))
            
                
            Text(character)
                .frame(width: 25, height: 25)
                .scaleEffect(highlight ? 1.5 : 1)
                .animation(.easeOut)

        }
    }
}

struct Point{
    private var xIndex: Int
    private var yIndex: Int

    func getX()->Int{
        return self.xIndex
    }
    func getY()->Int{
        return self.yIndex
    }

}

struct ModelBoard: View{
    
    private var squares: [[String]] = []
    private var random_letter = "a"
    
    @State private var hovering_i: Int? = nil
    @State private var hovering_j: Int? = nil
    @GestureState private var location: CGPoint = .zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
//    @State private var coords: [Point] = []
    

    init() {
        self.squares = Array(repeating: Array(repeating: "_", count: 10), count: 10)
        
        for k in 0..<10{
            for j in 0..<10{
                random_letter = String(characters[Int.random(in: 0..<26)])
                self.squares[k][j] = random_letter
            }
        }
    }
    
    func rectReader(index_i: Int, index_j: Int) -> some View{
        return GeometryReader { (geometry) -> AnyView in

            if geometry.frame(in: .global).contains(self.location) {
                DispatchQueue.main.async {
                    self.hovering_i = index_i
                    self.hovering_j = index_j
                    self.isDragging = true

                }
            }
            return AnyView(Circle())
        }
    }
    
    
//    func rows(i: Int)-> some View{
//
//        var isHoveringX = self.hovering_i==i
//
//        var side : some View{
//            VStack{
//                ForEach(0..<10){ j in
//                    LetterView(highlight: isHoveringX && self.hovering_j==j, character: self.squares[i][j])
//                        .background(self.rectReader(index_i: i, index_j: j))
//
//                }
//            }
//        }
//        return side
//    }
        
    private var Grid: some View{
        ZStack{
            Text("\(self.squares[hovering_i ?? 0][hovering_j ?? 0])")
            HStack{
                ForEach(0..<10){i in
                    Spacer()
                        VStack{
                            ForEach(0..<10){ j in
                                LetterView(highlight: self.hovering_i==i && self.hovering_j==j, character: self.squares[i][j])
                                    .background(self.rectReader(index_i: i, index_j: j))
                                
                            }
                    }
                    Spacer()
                }
            }
        }
    }
        
    
    var body: some View{

                
        let hover = DragGesture(minimumDistance: 0, coordinateSpace: .global)
//            .onChanged{ change in
//                self.offset = change.translation
//                withAnimation{
//                    self.isDragging = true
//                }
//            }
            .updating($location){(value,state,transaction) in
                state = value.location
                
            }.onEnded{_ in
                withAnimation{
                    self.hovering_j = nil
                    self.hovering_i = nil
//                    self.isDragging = false

                }
            }
        
        return
            ZStack{
                Grid
                    .gesture(hover)
               
                
                
        }

    }
    
}







//struct DrawLine:Shape{
//
//    @State private var currentPosition: Position
//    @State private var newPosition: Position
//
//
//    func path(in rect: CGRect)->Path{
//        var path = Path()
//
//        path.move(to:CGPoint(x:rect.minX,y:rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//
//        return path
//    }
//
//}


struct DragGestureView: View{
    @State private var offset = CGSize.zero
    @Binding var isDragging: Bool


    var body: some View{
        
        
        let dragGesture = DragGesture()
                    
            .onChanged{ value in
                self.offset = value.translation
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
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return
            ZStack{
                Circle()
                .fill(isDragging ? Color.yellow : Color.green)
                .frame(width:25,height:25)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(CGSize(width: 0, height: offset.height))
                .gesture(combined)
                
        }
    }
}






struct Grid_view: View {
    @State private var grid = ModelBoard()
    private var words = ["Swift", "Kotlin", "ObjectiveC", "Variable", "Java", "Mobile"]
    @State var numbers = [0,0,0,0,0,0]
    
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
