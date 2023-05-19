//
//  GhostView.swift
//  Calculator vs Zombie
//
//  Created by Irfan Dary Sujatmiko on 16/04/23.
//

import SwiftUI

struct GhostView: View{
    @Binding var image:String
    @State var move=false
    @Binding var moveOffsetLeft:CGFloat
    @Binding var moveOffsetRight:CGFloat
    
    var body: some View {
        Image(image).resizable().scaledToFit().frame(height: 60).offset(x: move ? moveOffsetLeft : moveOffsetRight ).task{
            withAnimation(.easeInOut(duration: 1).speed(0.5).repeatForever()){
                move.toggle()
            }
        }
    }
    
}


