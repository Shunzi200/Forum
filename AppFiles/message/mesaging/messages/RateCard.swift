//
//  RateCard.swift
//  Looper
//
//  Created by Samuel Ridet on 1/7/23.
//

import SwiftUI


struct RateCard: View {
    @StateObject var firestoreConnector : FirebaseConnector
    @State var userProfile : accountProfile
    @State var chatDetails : Chat
    var width : CGFloat
    var height : CGFloat
    @State var rating : Double = 0
    @State var review = ""
    @State var showPublish : Bool
    var body: some View {
        if showPublish{
        VStack(alignment: .center, spacing: 5){
            
            HStack{
                UrlImageView(urlString: showPublish ? userProfile.profilePic : firestoreConnector.dataToDisplay.profilePic)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width * 0.1, height: width * 0.1)
                    .clipShape(Circle())
                    .padding(5)
                
                Text("\(userProfile.username)")
                    .font(.custom("Montserrat-SemiBold", size: 16))
                    .lineLimit(1)
                Spacer()
            }
  
  
            HStack {
        
                Spacer()
                ForEach(1...5, id: \.self) { number in
                    Button(action: {
                        self.rating = Double(number)
                    }) {
                        if number > Int(self.rating) {
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                                .font(.title3)
                        } else {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.title3)
                        }
                    }
                }
                Spacer()
             
            }
            ReviewField(text: $review, minHeight: 30)
                //.padding(5)
                .frame(width: width * 0.6)
                .disabled(!showPublish)
            
            
                HStack {
                    Spacer()
                    Button {
                        
                         firestoreConnector.uploadRating(userID: userProfile.id, rating: rating, comment: review, chatID: chatDetails.id)
                    
                        self.rating = 0
                        self.review = ""
                        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                    } label: {
                        if firestoreConnector.reviewExists{
                            ZStack(alignment: .center){
                                Capsule()
                                    .foregroundColor(.red)
                                    .frame(width: width*0.45, height: width * 0.08)
                                Text("Already reviewed")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .foregroundColor(.white)
                            }.disabled(firestoreConnector.reviewExists)
                        }else{
                            ZStack(alignment: .center){
                                Capsule()
                                    .foregroundColor(rating == 0 || review.isEmpty ?  .gray : CustomColor.mainPurple)
                                    .frame(width: width*0.45, height: width * 0.08)
                                Text("Leave a review")
                                
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .disabled(rating == 0 || review.isEmpty)
                    
                    Spacer()
                }
            }.frame(width: width * 0.65)

            
        
        }else{
            Text("Sent review request")
                .font(.custom("Montserrat-Bold", size: 13))
                .foregroundColor(.white)
        }
            
        
        
    }
}


struct RateCardDemo: View {
    @State var chatData = chatMessage(id: "", sender: "", date: "", messageType: "", message: "", data: ["zelle": "2245184878", "venmo": "samRidet", "cashapp": "god12", "paypal": "shunzi.fpv@gmail.com"])
    @State var account = accountProfile(id: "", username: "french_soles", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: [])
    @State var chat = Chat(id: "", members: ["M17K7nYafvPjwJqDsyEwDAX4UCy1", "iPq88RlqSegBTbgEaiu4p8cEW4x1"], lastMessage: "Hello", listingID: "", offerPrice: "300", date: "12423432423", opened: false, lastSender: "")
    @State var listing = feedInfo(id: "dgfsdgs", username: "french_soles", productName: "Jordan 1 Volt", productSKU: "DHJSA-334", productSize:"" , productCat: "9", productPrice: "230", productCondition: "New", productDelivery: "Local", city: "Chicago", state: "IL", shipping: "15", time: "3458235290375", postType: " ", atype: " ", caption: "Loopin like we like it", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [["size": "9", "category": "M", "quantity": "2", "price": "200"], ["size": "11", "category": "M", "quantity": "2", "price": "200"]], rating: "", Nameimages: [])
    var body: some View {
       // Text("hellow")
        RateCard(firestoreConnector: FirebaseConnector(), userProfile: account, chatDetails: chat, width: 428, height: 926, showPublish: true)
    }
}

struct RateCard_Previews: PreviewProvider {
    static var previews: some View {
        RateCardDemo()
    }
}
