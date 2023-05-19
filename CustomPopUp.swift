//
//  CustomPopUp.swift
//  calczombie
//
//  Created by Irfan Dary Sujatmiko on 14/04/23.
//
import SwiftUI

struct Modal<Content: View >: View {
    @State private var sheetHeight: CGFloat = .zero
   
    let content: Content
    let height:CGFloat
    var body: some View {
        GeometryReader { geo in
            
            ZStack(alignment: .center) {
                Group{
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        .shadow(color: Color.gray.opacity(0.4), radius: 4)
                    
                    VStack(alignment: .center) {
                        content
                    }.padding(.vertical, 20).padding(.horizontal,20)
                }.position(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
                
                
                
            }
            .frame(maxWidth: geo.size.width*0.70,maxHeight: height)
        }.background(Color.black.opacity(0.5))
    }
}



struct Modal_Previews: PreviewProvider {
    static var previews: some View {
        Modal( content: Text("Content"),height: CGFloat(500))
    }
}
