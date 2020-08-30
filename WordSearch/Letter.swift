//
//  Letter.swift
//  WordSearch
//
//  Created by Joshua Blanch on 2020-08-29.
//  Copyright © 2020 Joshua Blanch. All rights reserved.
//

import SwiftUI


struct Oblong:Shape{
    func path(in rect: CGRect)->Path{
        var path = Path()
        
        path.move(to:CGPoint(x:rect.minX,y:rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        return path
    }
    
}

struct Letter: View {
    var body: some View {

        Oblong()
            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
        
        
    }
}

struct Letter_Previews: PreviewProvider {
    static var previews: some View {
        Letter()
    }
}






//
//struct DragGestureView: View {
//    @State var isDragging = false
//
//    var drag: some Gesture {
//        DragGesture()
//            .onChanged { _ in self.isDragging = true }
//            .onEnded { _ in self.isDragging = false }
//    }
//
//    var body: some View {
//        Circle()
//            .fill(self.isDragging ? Color.red : Color.blue)
//            .frame(width: 100 , height: 100, alignment: .center)
//            .gesture(drag)
//    }
//}
//
//
//struct MyView: View {
//
//    @State var xPos: CGFloat = 0
//    @State var yPos: CGFloat = 0
//    var body: some View {
//        GeometryReader { geometry in
//            HStack {
//                Text("\(self.xPos) || \(self.yPos)")
//            }
//        }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded { dragGesture in
//
//            self.xPos = dragGesture.location.x
//            self.yPos = dragGesture.location.y
//
//
//        })
//    }
//}
