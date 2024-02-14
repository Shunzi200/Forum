//
//  LogCard.swift
//  Looper
//
//  Created by Samuel Ridet on 12/24/22.
//

import SwiftUI

struct LogCard: View {
    @State var chatData : chatMessage
    var listing : feedInfo
    @State var chat : Chat
    @State var userProfile : accountProfile
    var width : CGFloat
    var height : CGFloat
    @State var userID : String
    @Binding var showConfirmation : Bool
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack {
                VStack (alignment: .leading,spacing: 10) {
                    Text("Sale Price")
                        .foregroundColor(.white)
                        .underline()
                        .font(.custom("Montserrat-Bold", size: 14))

                    Text("$\(chatData.data["Sale Price"] ?? "")")
                        .font(.custom("Montserrat-SemiBold", size: 14))
                }

                
                UrlImageView(urlString: listing.images.first as? String ?? "")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width / 6.5, height: width / 6.5)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(5)
         
            }
        

            
            NavigationLink {
                if userID == listing.userID{
                    LogChatSeller(listingData: listing, chat: chat, offerPrice: chatData.data["Sale Price"] ?? "", userProfile: userProfile, showConfirmation: $showConfirmation, exitNext: $showConfirmation)
                }else{
                    LogChatBuyer(listingData: listing, chat: chat, offerPrice: chatData.data["Sale Price"] ?? "", userProfile: userProfile, showConfirmation: $showConfirmation, exitNext: $showConfirmation)
                }
                
            } label: {
                
                HStack {
                    Text("Log Sale")
                        .font(.custom("Montserrat-Bold", size: 13))
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(CustomColor.mainPurple).frame(width: width * 0.4))
                    
                }
            }
            
            


    

         
        }.padding(5)
        
        
    }
}



struct LogCardDemo: View {
    @State var chatData = chatMessage(id: "", sender: "", date: "", messageType: "", message: "", data: ["Sale Price": "518", "venmo": "samRidet", "cashapp": "god12", "paypal": "shunzi.fpv@gmail.com"])
    
    @State var feedData = feedInfo(id: "fdsfs", username: "french_soles", productName: "Jordan 1 Retro High OG A Ma Maniére", productSKU: "HDsja", productSize: "7", productCat: "M", productPrice: "300", productCondition: "New", productDelivery: "Ship", city: "Chicago", state: "IL", shipping: "10", time: "242435", postType: "Item", atype: "", caption: "We looped this shit like it was Mickey Ds", likes: [], saves: [], comments: [], images: ["https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/images%2F0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg?alt=media&token=60f14e83-3c9a-46bd-b281-8f32b698c903"], userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", bulkSize: [[:]], rating: "4.0", Nameimages: ["0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg"])
    
    @State var chat = Chat(id: "", members: [], lastMessage: "", listingID: "", offerPrice: "300", date: "2313", opened: false, lastSender: "")
    
    @State var account = accountProfile(id: "M17K7nYafvPjwJqDsyEwDAX4UCy1", username: "french_soles", email: "gfdd", sales: [], rating: " ", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: " ", userID: " ", followers: [], followings: [], NameImages: " ", chats: [], socialMedia: ["":""], payment: ["":""], address: ["":""], logs: [])
    
    @State var show = false
    var body: some View {
        LogCard(chatData: chatData, listing: feedData, chat: chat, userProfile: account, width: 428, height: 926, userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", showConfirmation: $show)
    }
}

struct LogCard_Previews: PreviewProvider {
    static var previews: some View {
        LogCardDemo()
    }
}


