//
//  itemSelectionBar.swift
//  Looper
//
//  Created by Samuel Ridet on 4/12/23.
//

import SwiftUI

struct itemSelectionBarListing: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    let listingData : feedInfo
    @Binding var showConfirmation : Bool
    @Binding var exitNext : Bool
    @State var sale : Bool
    
    var body: some View {
        NavigationLink {
            if !sale{
                LogChatSeller(listingData: listingData, chat: Chat(id: "", members: [], lastMessage: "", listingID: listingData.id, offerPrice: "", date: "", opened: false, lastSender: ""), offerPrice: "", userProfile: accountProfile(id: "", username: "", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: []), showConfirmation: $showConfirmation, exitNext: $exitNext)
            }else{
                LogChatBuyer(listingData: listingData, chat: Chat(id: "", members: [], lastMessage: "", listingID: listingData.id, offerPrice: "", date: "", opened: false, lastSender: ""), offerPrice: "", userProfile: accountProfile(id: "", username: "", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: []), showConfirmation: $showConfirmation, exitNext: $exitNext)
            }
           
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        HStack{
                            HStack (spacing: 0){
                                
                                UrlImageView(urlString: listingData.images[0] as? String ?? "")
                                    .scaledToFill()
                                    .frame(width: width * 0.2, height: width * 0.2)
                                    .clipShape(Rectangle())
                                
                                
                            }
                            VStack (alignment: .leading){
                                Text("\(listingData.productName)")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .lineLimit(2)
                                Text("\(listingData.productSKU)")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                            }
                            Spacer()
                            Text("\(listingData.productSize)\(listingData.productCat)")
                                .font(.custom("Montserrat-Bold", size: 15))
                                .padding(.horizontal)
                            Text("$\(listingData.productPrice)")
                                .font(.custom("Montserrat-Bold", size: 16))
                            
                            
                        }
                        
                    }
                    
                }
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainPurple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 7, height: width * 0.2)
                
            }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
                .padding(.horizontal, 2)
            
        }
        
    }
}

struct itemSelectionBarBulk: View{
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    let listingData : feedInfo
    @Binding var showConfirmation : Bool
    @Binding var exitNext : Bool
    @State var sale : Bool
    var body: some View {
        
        NavigationLink {
            if !sale{
                LogChatSeller(listingData: listingData, chat: Chat(id: "", members: [], lastMessage: "", listingID: listingData.id, offerPrice: "", date: "", opened: false, lastSender: ""), offerPrice: "", userProfile: accountProfile(id: "", username: "", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: []), showConfirmation: $showConfirmation, exitNext: $exitNext)
            }else{
                LogChatBuyer(listingData: listingData, chat: Chat(id: "", members: [], lastMessage: "", listingID: listingData.id, offerPrice: "", date: "", opened: false, lastSender: ""), offerPrice: "", userProfile: accountProfile(id: "", username: "", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: []), showConfirmation: $showConfirmation, exitNext: $exitNext)
            }
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        HStack{
                            HStack (spacing: 0){
                                
                                UrlImageView(urlString: listingData.images[0] as? String ?? "")
                                    .scaledToFill()
                                    .frame(width: width * 0.2, height: width * 0.2)
                                    .clipShape(Rectangle())
                                
                                
                            }
                            VStack (alignment: .leading){
                                Text("\(listingData.productName)")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .lineLimit(2)
                                Text("\(listingData.productSKU)")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                            }
                            Spacer()
                            Text("\(listingData.productCat) items")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            Text("$\(listingData.productPrice)")
                                .font(.custom("Montserrat-Bold", size: 16))
                            
                            
                        }
                        
                    }
                    
                }
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainThird]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 7, height: width * 0.2)
                
            }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
               .padding(.horizontal, 2)
        }
        
    }
}


