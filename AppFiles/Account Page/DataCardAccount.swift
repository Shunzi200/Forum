//
//  DataCardAccount.swift
//  Looper
//
//  Created by Samuel Ridet on 1/19/23.
//

import SwiftUI

struct DataCardAccount: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var width : CGFloat
    var height : CGFloat
    var body: some View {
        VStack{
            HStack{
                Spacer()
                NavigationLink {
                RatingDisplayAccount(ratings: firestoreConnector.ratingToDisplay)
                        .navigationTitle("Reviews")
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
                            Text("\(firestoreConnector.ratingToDisplay.prevReview.count)")
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
                    UserFollowingPage(mainuserID: firestoreConnector.dataToDisplay.userID, following: false)
                }label: {
                    VStack(alignment: .center) {
                        HStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.04)
                                .foregroundColor(.blue)
                            Text("\(firestoreConnector.dataToDisplay.followers.count)")
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
                    UserFollowingPage(mainuserID: firestoreConnector.dataToDisplay.userID, following: true)
                }label: {
                    VStack(alignment: .center) {
                        HStack {
                            Image(systemName: "person.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.045)
                                .foregroundColor(.white)
                            Text("\(firestoreConnector.dataToDisplay.followings.count)")
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
                            Text("\(firestoreConnector.dataToDisplay.sales.count)")
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
                        Text("\(firestoreConnector.dataToDisplay.purchases.count)")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                    }
                    Text("Purchases")
                        .font(.custom("Montserrat-SemiBold", size: 10))
                        .lineLimit(1)
                }
                
                
                Spacer()
        
            }
        
            
        }.padding(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
    }
}


struct DataCardAccountDemo: View {
    var body: some View {
        DataCardAccount(width: 428, height: 926)
    }
}

struct DataCardAccountDemo_Previews: PreviewProvider {
    static var previews: some View {
        DataCardAccountDemo()
            .environmentObject(FirebaseConnector())
    }
}
