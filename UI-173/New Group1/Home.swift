//
//  Home.swift
//  UI-173
//
//  Created by にゃんにゃん丸 on 2021/05/03.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "Incoming"
    @Namespace var animation
    
    @State var weeks : [Week] = []
    @State var currentDay = Week(day: "", date: "", amount: 0)
    var body: some View {
        VStack{
            
            HStack{
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("m1")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                })
                
                Spacer(minLength: 0)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("menu")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                })
                
                
                
                
            }
            .padding()
            
            
            Text("Statics")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .kerning(5)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
            
            
            HStack{
                
                Text("Incoming")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    
                    .background(
                        ZStack{
                            
                            if selectedTab == "Incoming"{
                                
                                Color.white
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                
                                
                            }
                            
                            
                        }
                    
                    
                    )
                    .foregroundColor(selectedTab == "Incoming" ? Color.black : Color.white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            selectedTab = "Incoming"
                            
                        }
                    }
                
                
                Text("Outcoming")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    
                    .background(
                        ZStack{
                            
                            if selectedTab == "Outcoming"{
                                
                                Color.white
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                
                                
                            }
                            
                            
                        }
                    
                    
                    )
                    .foregroundColor(selectedTab == "Outcoming" ? Color.black : Color.white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            selectedTab = "Outcoming"
                            
                        }
                    }
                    
                
                
            }
            .padding(.vertical,7)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding(.top,20)
            
            
            
            HStack(spacing:35){
                
                ZStack{
                    
                    
                    Circle()
                        .stroke(Color.white,lineWidth: 20)
                    
                    let progress = currentDay.amount / 10000
                    
                    Circle()
                    
                        .trim(from: 0, to: progress)
                        .stroke(Color.yellow,style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(radians: -90))
                        
                    
                    Image(systemName: "dollarsign.square")
                        .font(.system(size: 55, weight: .heavy))
                        .foregroundColor(.purple)
                       
                    
                }
                .frame(maxWidth: 180)
                //.padding(.top,20)
                
                
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Spent")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    let amount = String(format: "%.f", currentDay.amount)
                    
                    Text("\(amount)円")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                    
                   
                        Text("MAXIUM")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(0.6))
                        
                        Text("10000円")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    
                })
                .frame(maxWidth: .infinity,alignment: .leading)
                
                
                
                
                
            }
            .padding(.leading,30)
            
            ZStack{
                
                if UIScreen.main.bounds.height < 750{
                    ScrollView(.vertical, showsIndicators: false, content: {
                        BottomSheet(weeks: $weeks, currentDay: $currentDay)
                            .padding([.horizontal,.top])
                            .padding(.bottom)
                    })
                    
                
                }
                
                else{
                    BottomSheet(weeks: $weeks, currentDay: $currentDay)
                        .padding([.horizontal,.top])
                }
            }
            
            
           
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            .background(Color.white.clipShape(CustomShape(corner: [.topLeft,.topRight], radi: 35)) .ignoresSafeArea(.all, edges: .bottom))
           
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg").ignoresSafeArea())
        .onAppear(perform: {
            GetWeeks()
        })
    }
    func GetWeeks(){
        
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: Date())
        
        
        guard let startDate = week?.start else{return}
        
        for index in 0..<7{
            
            guard let date = calender.date(byAdding: .day, value: index, to: startDate) else{return}
            
            
            let formate = DateFormatter()
            
            formate.dateFormat = "EEE"
            
            var day = formate.string(from: date)
            
            day.removeLast()
            
            
            formate.dateFormat = "d"
            
            let dateString = formate.string(from:date)
            
            
            weeks.append(Week(day: day, date: dateString, amount: index == 0 ? 1000 : CGFloat(index)*1500))
            
            
            
        }
        self.currentDay = weeks.first!
        
        
    }
     
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct BottomSheet : View {
    @Binding var weeks : [Week]
    @Binding var currentDay : Week
    var body: some View{
        
        VStack{
            
           
                
                
                Capsule()
                    .fill(Color.green)
                    .frame(width: 200, height: 5)
                
                
                HStack(spacing:15){
                    
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        Text("Your Burance")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Text("May 2 2021")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    })
                    
                    Spacer(minLength: 0)
                    
                    
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                        .offset(y: -5)
                    
                }
                .padding(.top)
                
                
                HStack{
                    
                    Text("10000")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    
                    
                    Spacer(minLength: 0)
                    
                    
                    Image(systemName: "arrow.up")
                        .foregroundColor(.gray)
                    
                    
                    Text("15%")
                        .font(.headline)
                        .fontWeight(.regular)
                       
                    
                    
                }
                .padding(.top,5)
                
                HStack(spacing:15){
                    
                    
                    ForEach(weeks){week in
                        
                        VStack(spacing: 10, content: {
                            Text(week.day)
                               
                                .fontWeight(.bold)
                                .foregroundColor(currentDay.id == week.id ? Color.blue : Color.black)
                               
                            
                    
                            
                            Text(week.date)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(currentDay.id == week.id ? Color.green : Color.black)
                                
                                
                        })
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(currentDay.id == week.id ? 1 : 0))
                        
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation{
                                
                                currentDay = week
                            }
                        }
                        
                    }
                    
                }
                .padding(.top,30)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("right-arrow")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .padding(.vertical,12)
                        .padding(.horizontal,30)
                        .background(Color("bg"))
                        .cornerRadius(10)
                })
                .padding(.top,20)
                
            
            
        }
    }
}
