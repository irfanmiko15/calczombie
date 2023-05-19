//
//  WelcomeView.swift
//  Calculator vs Zombie
//
//  Created by Irfan Dary Sujatmiko on 15/04/23.
//

import SwiftUI
import AVFoundation

struct WelcomeView: View {
    @State var selection:Int?
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        GeometryReader { geo in
            NavigationView{
                ZStack{
                    Image("bgSplash").resizable().scaledToFill()
                    
                    VStack(spacing: -1) {
                        Spacer()
                        Image("childWithCandy").resizable().scaledToFit().frame(height: 250).padding(.leading).padding(.bottom)
                        
                        
                    }
                    .frame(width: geo.size.width,
                           height: geo.size.height
                           
                           )
                    Rectangle().fill(.black.opacity(0.4))
                    VStack{
                        Image("iconApp").resizable().scaledToFit().frame(width: 500).padding(.bottom,100)
                        NavigationLink(destination: ChooseLevelView().navigationBarHidden(true), tag: 1,selection: $selection) {
                            Button("Start") {
                                self.selection=1
                                AudioServicesPlaySystemSound(1018)
                            }.padding()
                                .font(.system(size: 40, weight: Font.Weight.bold)).padding(.horizontal,30)
                                .foregroundColor(Color("DarkPurple"))
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                   
                }.onAppear{
                    SoundControl().playBacksong()
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }.navigationViewStyle(.stack)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
