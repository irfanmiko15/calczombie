//
//  ChooseLevelView.swift
//  Calculator vs Zombie
//
//  Created by Irfan Dary Sujatmiko on 16/04/23.
//

import SwiftUI
import AVFoundation
struct ChooseLevelView: View {
    @State var selection:Int?
    
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
                        Image("iconApp").resizable().scaledToFit().frame(width: 500).padding(.bottom,50)
                        Text("Choose level").foregroundColor(.white).font(.system(size:50).bold()).padding(.bottom,50)
                        NavigationLink(destination: PlayGame1View().navigationBarHidden(true), tag: 1,selection: $selection) {
                            Button("Level 1") {
                                self.selection=1
                                AudioServicesPlaySystemSound(1018)
                            }.padding()
                                .font(.system(size: 40, weight: Font.Weight.bold)).padding(.horizontal,30)
                                .foregroundColor(Color("DarkPurple"))
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                                .buttonStyle(PlainButtonStyle())
                        }.padding()
                        NavigationLink(destination: PlayGame2View().navigationBarHidden(true), tag: 2,selection: $selection) {
                            Button("Level 2") {
                                self.selection=2
                                AudioServicesPlaySystemSound(1018)
                            }.padding()
                                .font(.system(size: 40, weight: Font.Weight.bold)).padding(.horizontal,30)
                                .foregroundColor(Color("DarkPurple"))
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                                .buttonStyle(PlainButtonStyle())
                        }.padding()
                        NavigationLink(destination: PlayGame3View().navigationBarHidden(true), tag: 3,selection: $selection) {
                            Button("Level 3") {
                                self.selection=3
                                AudioServicesPlaySystemSound(1018)
                            }.padding()
                                .font(.system(size: 40, weight: Font.Weight.bold)).padding(.horizontal,30)
                                .foregroundColor(Color("DarkPurple"))
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                                .buttonStyle(PlainButtonStyle())
                        }.padding()
                        
                        
                        
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }.navigationViewStyle(.stack)
        }
    }
}

struct ChooseLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLevelView()
    }
}
