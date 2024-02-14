//
//  DataCardViewAccount.swift
//  Looper
//
//  Created by Samuel Ridet on 1/20/23.
//

import SwiftUI

struct DataCardViewAccount: View {
    @ObservedObject var firestoreConnector : FirebaseConnector
    var width : CGFloat
    var height : CGFloat
    var body: some View {
        VStack{
            HStack{
                Spacer()
                NavigationLink {
                    RatingDisplayAccount(ratings: firestoreConnector.viewratingToDisplay)
                        .navigationBarTitle("Reviews")
                        .navigationBarTitleDisplayMode(.inline)
                        .accentColor(.white)
                    
                } label: {
                    VStack(alignment: .center) {
                        HStack {
                            
                            Image(systemName: "text.bubble")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.04)
                                .foregroundColor(.white)
                            Text("\(firestoreConnector.viewratingToDisplay.prevReview.count)")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Reviews")
                            .font(.custom("Montserrat-SemiBold", size: 10))
                            .underline()
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                }
                Spacer()
                
                NavigationLink {
                    UserFollowingPage(mainuserID: firestoreConnector.viewdataToDisplay.userID, following: false)
                }label: {
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.04)
                            .foregroundColor(.blue)
                        Text("\(firestoreConnector.viewdataToDisplay.followers.count)")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                          
                        
                    }
                    Text("Followers")
                        .font(.custom("Montserrat-SemiBold", size: 10))
                        .underline()
                        .lineLimit(1)
                }
            }
                
                
                Spacer()
                NavigationLink {
                    UserFollowingPage(mainuserID: firestoreConnector.viewdataToDisplay.userID, following: true)
                }label: {
                    VStack(alignment: .center) {
                        HStack {
                            Image(systemName: "person.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.045)
                                .foregroundColor(.white)
                            Text("\(firestoreConnector.viewdataToDisplay.followings.count)")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                        }
                        Text("Following")
                            .font(.custom("Montserrat-SemiBold", size: 10))
                            .underline()
                            .lineLimit(1)
                    }
                }
                Spacer()
                
                
            }
            
            HStack(spacing: 15){
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "bag.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.04)
                            .foregroundColor(.green)
                        Text("\(firestoreConnector.viewdataToDisplay.sales.count)")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                        
                    }
                    Text("Sales")
                        .font(.custom("Montserrat-SemiBold", size: 10))
                        .lineLimit(1)
                }
                
                
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.05)
                            .foregroundColor(.red)
                        Text("\(firestoreConnector.viewdataToDisplay.purchases.count)")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                    }
                    Text("Purchases")
                        .font(.custom("Montserrat-SemiBold", size: 10))
                        .lineLimit(1)
                }
                
                
                Spacer()
                
            } .navigationBarTitle(" ")
                .navigationBarTitleDisplayMode(.inline)
           
            
            
        }.padding(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
    }
}


