//
//  PlayGame1View.swift
//  calczombie
//
//  Created by Irfan Dary Sujatmiko on 13/04/23.
//

import SwiftUI
import AVFoundation

struct PlayGame1View: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    var sound=SoundControl()
    @State private var zombieHp = 10.0

    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
    ]
    @State var data:[ResultModel]=[
        .init(id: "1", value: "7.0", isTrue: false),
        .init(id: "2", value: "10.0", isTrue: false),
        .init(id: "3", value: "13.0", isTrue: false),
        .init(id: "4", value: "18.0", isTrue: false),
        .init(id: "5", value: "23.0", isTrue: false),
        .init(id: "6", value: "30.0", isTrue: false),
        .init(id: "7", value: "34.0", isTrue: false),
        .init(id: "8", value: "43.0", isTrue: false),
        .init(id: "9", value: "47.0", isTrue: false),
        .init(id: "10", value: "50.0", isTrue: false),
    ]
    let animation: Animation = Animation.linear(duration: 120.0)
    @State private var showArrow=false
    @State private var arrowMove=false
    //isActive=false to stop timer
    @State private var timeRemaining = 120.0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = false
    @State var animate: Bool = false
    let grid = [
        ["AC", "⌦", "", ""],
        ["", "", "", "X"],
        ["", "", "", ""],
        ["", "2", "3", "+"],
        ["", "", "", "="]
    ]
   
    
    let operators = ["/", "+", "X", "%"]
    @State var visibleWorkings = ""
    @State var visibleResults = ""
    @State private var showPlayPopUp = true
    @State private var showTimesUpPopUp = false
    @State private var showWinPopUp = false
    @State private var showConfirmationPopUp = false
    @State var showAlert = false
    var body: some View {
        GeometryReader { geo in
         
                ZStack(alignment: .top){
                    VStack{
                        ZStack(alignment: .top){
                            
                            Image("background").resizable().scaledToFill()
                            HStack{
                                
                                    Image(systemName: "chevron.left").font(.system(size: 50)).foregroundColor(.white).padding(.top,100).padding(.leading,50).onTapGesture {
                                        self.showConfirmationPopUp=true
                                    }
                                Spacer()
                            }
                           
                            HStack{
                                GhostView(
                                    
                                    image: .constant(String("ghost2")),
                                    moveOffsetLeft:.constant(CGFloat(-25)), moveOffsetRight: .constant(CGFloat(25))
                                );
                            }.offset(x:130,y:150)
                            
                            HStack{
                                GhostView(
                                    image: .constant(String("ghost1")),
                                    moveOffsetLeft:.constant(CGFloat(25)), moveOffsetRight: .constant(CGFloat(-25))
                                )
                                
                            }.offset(x:220,y:250)
                            HStack{
                                GhostView(image: .constant(String("ghost3")),
                                          moveOffsetLeft:.constant(CGFloat(25)), moveOffsetRight: .constant(CGFloat(-25))
                                          
                                )
                                
                            }.offset(x: -120, y:180 )
                           
                            HStack{
                                GhostView(image: .constant(String("ghost4")),
                                          moveOffsetLeft:.constant(CGFloat(-25)), moveOffsetRight: .constant(CGFloat(25))
                                )
                            }.offset(x: -220, y:320 )
                            
                            VStack{
                                Spacer()
                                HStack(spacing: -1) {
                                    
                                    Image("childScared").resizable().scaledToFit().frame(height: 350).padding(.leading).padding(.bottom)
                                    
                                    
                                }
                                .frame(width: geo.size.width,
                                       
                                       alignment: .leading )
                            }
                            VStack{
                                Spacer()
                                HStack(spacing: -1) {
                                    VStack{
                                        ProgressView(value: zombieHp,total:10)
                                            .scaleEffect(CGSize(width: 1, height: 5)) .frame(width: 100)
                                        ZStack{
                                            Image("zombie1").resizable().scaledToFit().frame(height: 250).padding(.bottom)
                                           
                                        }
                                        
                                               
                                            
                                            
                                        
                                    }
                                    
                                    
                                }
                                .frame(width: geo.size.width,
                                       
                                       alignment: animate ? .leading : .trailing)
                            }
                            if(showArrow){
                                VStack{
                                    Spacer()
                                    HStack(spacing: -1) {
                                        
                                        Image("arrow").resizable().scaledToFit().frame(height: 30).padding(.leading).padding(.bottom,100).padding(.leading,50).offset(x: arrowMove ? 700 : 0 ).animation(Animation.linear(duration: 1), value: arrowMove)
                                        
                                        
                                        
                                    }.onAppear{
                                        arrowMove=true
                                    }
                                    .frame(width: geo.size.width,
                                           
                                           alignment: .leading )
                                }
                            }
                           
                               
                            
                            
                        }.frame(height: 600)
                        
                        HStack{
                         
                            VStack{
                                HStack{
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text(visibleWorkings=="" ? "0" : visibleWorkings).font(.system( size: 30)).padding(.vertical,5).padding(.horizontal,20)
                                        Text(visibleResults=="" ? "0" :visibleResults).font(.system( size: 60)).padding(.horizontal,10).padding(.vertical,5)
                                    }
                                    
                                }
                                .background(Color("Cream")).cornerRadius(10).padding(.horizontal,30).padding(.vertical,5).padding(.top)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.black, lineWidth: 0)
                                ).frame(maxWidth: .infinity, maxHeight: .infinity)
                                ForEach(grid, id: \.self)
                                {
                                    row in
                                    HStack
                                    {
                                        ForEach(row, id: \.self)
                                        {
                                            cell in
                                            
                                            Button(action: {
                                                buttonPressed(cell: cell)
                                            }, label: {
                                                HStack{
                                                    Text(cell)
                                                        .foregroundColor(Color.black)
                                                        .font(.system( size: 40))
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                }.background(cell == "" ? Color("GrayCalculator") : Color("WhiteCalculator")).cornerRadius(10).padding()
                                                
                                            })
                                            
                                        }
                                    }
                                }
                                .padding(.horizontal,20)
                                
                                .alert(isPresented: $showAlert)
                                {
                                    Alert(
                                        title: Text("Invalid Input"),
                                        message: Text(visibleWorkings),
                                        dismissButton: .default(Text("Okay"))
                                    )
                                }
                            }.frame(
                                
                                width: geo.size.width*0.55).background(Color("GrayCalculator"))
                                .cornerRadius(20)
                                .padding(.top,60).padding(.leading)
                            VStack{
                              
                            
                                Text("Think of the best combination of numbers based on the given result. \nUse the calculator to find the answer").padding().font(.system(size:20)).foregroundColor(.black).background(RoundedRectangle(cornerRadius: 15).fill(Color.white)).padding()
                                Text("Result :").foregroundColor(.white).font(.system(size:25).bold())
                                
                                LazyVGrid(columns: columns,spacing: 30) {
                                    ForEach(data) { item in
                                        let a = item.value.components(separatedBy: ".")
                                        
                                        if(!item.isTrue){
                                            HStack{
                                                Text(
                                                    
                                                    a[0]).font(.system(size: 35).bold()).foregroundColor(Color.black).padding(.vertical,5).padding(.horizontal,5).frame(height:100)
                                                    
                                                  
                                            }.background(Circle().fill(Color.white).frame(width:250))
                                                .animation(.easeIn).transition(.move(edge: .top))
                                        }
                                        else{
                                            HStack{
                                                Text(a[0]).font(.system(size: 35).bold()).foregroundColor(Color.white).padding(.vertical,5).padding(.horizontal,5).frame(height:100)
                                                    
                                            }.background(Circle().fill(Color.green).frame(width:250))
                                                .animation(.easeOut).transition(.move(edge: .bottom))
                                        }
                                    }
                                    
                                               }.frame(maxWidth: .infinity)
                                Spacer()
                            }.padding(.top,50)
                            
                            
//                            HStack{
//                                ForEach(data){s in
//                                    let a = s.value.components(separatedBy: ".")
//                                    Text(a[0]).font(.system(size: 30).bold()).foregroundColor(s.isTrue ? Color.green : Color.black)
//                                }
//                            }
                            
                        }.padding(.bottom)
                        
                    }.background(Color("DarkPurple"))
                    
                
                
            }
            if $showPlayPopUp.wrappedValue {
               
                Modal(content: VStack{
                    
                    Text("Tap start to play the game").font(.system(size:40).bold())
                    Image("childConfuse")
                        .resizable()
                        .scaledToFit()
                        
                        .frame(height:300)
                   
                    Text("Think of the best combination of numbers based on the given result. \nUse the calculator to find the answer").font(.system(size:30))
                        Button("Start") {
                            withAnimation(animation) {
                                animate.toggle()
                            }
                            
                            showPlayPopUp=false
                            isActive=true
                            start()
                        }.padding()
                         .font(.system(size: 40, weight: Font.Weight.bold))
                         .foregroundColor(Color.white)
                         .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                         .buttonStyle(PlainButtonStyle())
                    
                },height:700 ).animation(.easeOut)
                    .transition(.move(edge: .top)).position(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
            }
            if $showTimesUpPopUp.wrappedValue {
                
                Modal(content: VStack{
                    Text("Time Out!!!").font(.system(size:40).bold())
                    Image("childCrying")
                        .resizable()
                        .scaledToFit()
                        
                        .frame(height:300)
                    Text("Pay atention about the time").font(.system(size:30))
                        Button("Back to menu") {
                            showTimesUpPopUp=false
//                            sound.stopBacksong()
                            AudioServicesPlaySystemSound(1018)
                            dismiss()
                        }.padding()
                         .font(.system(size: 40, weight: Font.Weight.bold))
                         .foregroundColor(Color.white)
                         .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                         .buttonStyle(PlainButtonStyle())
                    
                },height:600).onAppear{
                    sound.playLose()
                }.animation(.easeOut)
                    .transition(.move(edge: .top)).position(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
            }
            if $showWinPopUp.wrappedValue {
                Modal(
                 
                    content: VStack{
                    
                    Text("CONGRATULATION 🥳✨🎉🎉!!!").font(.system(size:40).bold())
                    Image("childWithCandy")
                        .resizable()
                        .scaledToFit()
                        
                        .frame(height:300)
                    Text("congratulations, you have successfully completed this level, as a token of gratitude, kevin gives you a candy, accept it!").font(.system(size:30))
                        Button("Play Again?") {
                            showWinPopUp=false
                            AudioServicesPlaySystemSound(1018)
                            dismiss()
                        }.padding()
                         .font(.system(size: 40, weight: Font.Weight.bold))
                         .foregroundColor(Color.white)
                         .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                         .buttonStyle(PlainButtonStyle())
                    
                },height:700
                ).animation(.easeOut)
                    .transition(.move(edge: .top)).position(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
                
            }
            if $showConfirmationPopUp.wrappedValue {
                Modal(
                 
                    content: VStack{
                    
                    Text("Are you sure exit the game? ").font(.system(size:40).bold())
                    Image("childScream")
                        .resizable()
                        .scaledToFit()
                        
                        .frame(height:300)
                        HStack{
                            Spacer()
                            Button("Cancel") {
                                showConfirmationPopUp=false
                                
                            }.padding()
                                .font(.system(size: 40, weight: Font.Weight.bold))
                                .foregroundColor(Color.white)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                                .buttonStyle(PlainButtonStyle())
                            Spacer()
                            Button("Yes") {
                                showConfirmationPopUp=false
                                AudioServicesPlaySystemSound(1018)
//                                sound.stopBacksong()
                                dismiss()
                                
                            }.padding().padding(.horizontal,20)
                                .font(.system(size: 40, weight: Font.Weight.bold))
                                .foregroundColor(Color.white)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                                .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }.padding(.top,20)
                        
                    
                },height:600
                ).animation(.easeOut)
                    .transition(.move(edge: .top)).position(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
                
            }
            
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
                if(timeRemaining == 80.0){
                    sound.playHelp()
                }
                else if(timeRemaining == 40.0){
                    sound.playHelp()
                }
                else if(timeRemaining == 10.0){
                    sound.playHelp()
                }
                
                
            }
            if timeRemaining == 0 {
//                sound.stopBacksong()
                showTimesUpPopUp=true
            }
           
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                isActive = true
                
            } else {
                isActive = false
            }
            
           
        }.onAppear {
//            sound.playBacksong()
            stop()
          }
        .ignoresSafeArea()
        

    }
    
    
    
    
    func stop() {
          timer.upstream.connect().cancel()
    }
    func start() {
          timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    func buttonColor(_ cell: String) -> Color
    {
        if(cell == "AC" || cell == "⌦")
        {
            return .red
        }
        
        if(cell == "-" || cell == "=" || operators.contains(cell))
        {
            return .orange
        }
        
        return .white
    }
    
    func buttonPressed(cell: String)
    {
        
        switch (cell)
        {
        case "AC":
            visibleWorkings = ""
            visibleResults = ""
        case "⌦":
            visibleWorkings = String(visibleWorkings.dropLast())
        case "=":
            visibleResults = calculateResults()
        case "-":
            addMinus()
        case "X", "/", "%", "+":
            addOperator(cell)
        default:
            visibleWorkings += cell
        }
        
    }
    func updateShowArrow(){
        showArrow=true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showArrow=false
            arrowMove=false
           // your function
        }

    }
    
    func addOperator(_ cell : String)
    {
        if !visibleWorkings.isEmpty
        {
            let last = String(visibleWorkings.last!)
            if operators.contains(last)
            {
                visibleWorkings.removeLast()
            }
            visibleWorkings += cell
        }
    }
    
    func addMinus()
    {
        if visibleWorkings.isEmpty || visibleWorkings.last! != "-"
        {
            visibleWorkings += "-"
        }
    }
   
    
    func calculateResults() -> String
    {
        if(validInput())
        {
            var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
            workings = workings.replacingOccurrences(of: "X", with: "*")
            let expression = NSExpression(format: workings)
            print(expression)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            
            var stringRes=String(result)
            
            print(result)
            if let i = data.firstIndex(where: { $0.value == stringRes && $0.isTrue == false}) {
                data[i].isTrue=true
                sound.playCorrect()
              
                zombieHp=zombieHp-1.0
                updateShowArrow()
            }
            if data.contains(where: {$0.isTrue == false}) {
               // it exists, do something
            } else {
               showWinPopUp=true
//                sound.stopBacksong()
                isActive=false
                animate=false
                sound.playWin()
            }
            
           
         
            return formatResult(val: result)
        }
        showAlert = true
        return ""
    }
    func validInput() -> Bool
    {
        if(visibleWorkings.isEmpty)
        {
            return false
        }
        let last = String(visibleWorkings.last!)
        
        if(operators.contains(last) || last == "-")
        {
            if(last != "%" || visibleWorkings.count == 1)
            {
                return false
            }
        }
        
        return true
    }
    
    func formatResult(val : Double) -> String
    {
        if(val.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", val)
        }
        
        return String(format: "%.2f", val)
    }
}


struct PlayGame1View_Previews: PreviewProvider {
    static var previews: some View {
     PlayGame1View()
    }
}
