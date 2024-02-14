//
//  AccountPickerPill.swift
//  Looper
//
//  Created by Samuel Ridet on 1/19/23.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    @Binding var selection : Int
    var titles = ["Listings", "Posts"]
    var colors = [CustomColor.mainPurple, CustomColor.mainPurple]
    @State var frames = Array<CGRect>(repeating: .zero, count: 2)
    let width : CGFloat
    let height : CGFloat
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { self.selection = index }) {
                            Spacer()
                            Text(self.titles[index])
                                .font(.custom("Montserrat-Bold", size: 12))
                                .foregroundColor(.white)
                            Spacer()
                            
                            
                            
                        }.padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }    .frame(width: width)
                .background(
                    Capsule().fill(
                        self.colors[self.selection])
                    
                    .frame(width: width / 2,
                           height: height * 0.04, alignment: .topLeading)
                    
                    
                    .offset(x: (selection == 0 ? 0 : width/2))
                    , alignment: .leading
                    
                    
                    
                )
            }
            .animation(.default, value: selection)
            .frame(width: width, height: height * 0.04)
            .background(Capsule().foregroundColor(CustomColor.grayBackground))
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}


struct CustomSegmentedPickerViewMessages: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Binding var selection : Int
    var titles = ["Messages", "Offers", "Sent Offers"]
    var colors = [CustomColor.mainPurple, CustomColor.mainPurple]
    @State var frames = Array<CGRect>(repeating: .zero, count: 3)
    let width : CGFloat
    let height : CGFloat
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { self.selection = index }) {
                            Spacer()
                            
                            Text(self.titles[index])
                                .font(.custom("Montserrat-Bold", size: 12))
                                .foregroundColor(.white)
                            
                            Spacer()
                            if index == 0{
                            
                                if firestoreConnector.notificationsData.messages > 0 {
                                    Text("\(firestoreConnector.notificationsData.messages)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                
                                }else{
                                    Text(" ")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .opacity(0)
                                }
                              
                            }else if index == 1{
                                if firestoreConnector.notificationsData.offers > 0 {
                                    Text("\(firestoreConnector.notificationsData.offers)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                
                                }else{
                                    Text(" ")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .opacity(0)
                                }
                            
                            }
                            
                            
                            
                            
                        }.padding(EdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }    .frame(width: width)
                .background(
                    Capsule().fill(
                        CustomColor.mainPurple)
                    
                    .frame(width: width / 3,
                           height: height * 0.04, alignment: .topLeading)
                    
                    
                    .offset(x: ((width * 0.33) * CGFloat(selection)))
                    , alignment: .leading
                    
                    
                    
                )
            }
            .animation(.default, value: selection)
            .frame(width: width, height: height * 0.04)
            .background(Capsule().foregroundColor(CustomColor.grayBackground))
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}


struct CustomSegmentedPickerViewSell: View {
    @Binding var selection : Bool
    var titles = ["Item", "Bulk"]
    var colors = [CustomColor.mainPurple, CustomColor.mainThird]
    @State var frames = Array<CGRect>(repeating: .zero, count: 2)
    let width : CGFloat
    let height : CGFloat
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 15) {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { self.selection.toggle() }) {
                            Spacer()
                            
                            Text(self.titles[index])
                                .font(.custom("Montserrat-SemiBold", size: 12))
                                .foregroundColor(.white)
                            
                            Spacer()
                         
                            
                            
                            
                        }
                    }
                }     .frame(width: width)
                .background(
                    Capsule()
                        .foregroundColor(
                        selection == true ? CustomColor.mainThird : CustomColor.mainPurple)
                    
                        .frame(width: width / 2)
                    
                    
                    .offset(x: (selection == false ? 0 : width/2))
                    , alignment: .leading
                    
                    
                    
                )
            }
            .animation(.default, value: selection)
            .frame(width: width)
            //.padding(.vertical, 5)
            .background(Capsule().foregroundColor(CustomColor.grayBackground))
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

