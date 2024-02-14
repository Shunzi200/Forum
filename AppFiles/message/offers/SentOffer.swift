//
//  SentOffer.swift
//  Looper
//
//  Created by Samuel Ridet on 4/1/23.
//

import SwiftUI

struct SentOffer: View {
    @State var Off : offer
    @StateObject var firestoreConnector = FirebaseConnector()
    @Environment(\.presentationMode) var presentationMode
    
    var width: CGFloat
    var height: CGFloat
    @State var showAccount = false
    @State var days = 0
    
    var body: some View {
        
        VStack {
            HStack{
                UrlImageView(urlString: firestoreConnector.currentPost.images.first as? String ?? " ")
                    .scaledToFill()
                    .frame(width: width * 0.17, height: width * 0.17)
                    .clipShape(Rectangle())
                
                VStack (alignment: .leading){
                    Text("\(firestoreConnector.currentPost.productName)")
                        .font(.custom("Montserrat-Bold", size: 15))
                        .lineLimit(1)
                    Text("\(firestoreConnector.currentPost.username)")
                        .font(.custom("Montserrat-SemiBold", size: 12))
                        .lineLimit(1)
                }.padding(.horizontal, 5)
                
                VStack {
                    Text("$\(Off.offerPrice)")
                        .font(.custom("Montserrat-Bold", size: 16))
                        .padding(.horizontal, 10)
                    Text("\(days)d")
                        .font(.custom("Montserrat-SemiBold", size: 13))
                        .lineLimit(1)
                    
                }
                Spacer()
                
                if Off.status == "Declined"{
                    Image(systemName: "x.circle")
                        .padding(.trailing, 20)
                        .font(.callout)
                        .foregroundColor(.red)
                }else if Off.status == "Accepted"{
                    Image(systemName: "checkmark")
                        .padding(.trailing, 20)
                        .font(.callout)
                        .foregroundColor(.green)
                }else{
                    Image(systemName: "clock.badge.questionmark")
                        .padding(.trailing, 20)
                        .font(.callout)
                }
                
            }.onTapGesture {
                self.showAccount.toggle()
            }.sheet(isPresented: $showAccount) {
                ProductView(listingData: $firestoreConnector.currentPost)
            }
        }.cornerRadius(10).padding(.horizontal, 2).onAppear{
            firestoreConnector.PullPost(postID: Off.listingID)
            
            let timestamp = Off.date
            let date = Date(timeIntervalSince1970: Double(timestamp) ?? 0.0)
            let calendar = Calendar.current
            let days = calendar.dateComponents([.day], from: date, to: Date())
            if let dayCount = days.day {
       
                self.days = dayCount
            }
            
        }
    }
}

struct SentOffer_Previews: PreviewProvider {
    static var previews: some View {
       
        SentOffer(Off: offer(id: "fsfsfs", ownerID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", offerPrice: "400", listingID: "0C97732D-111E-49BD-A0A2-0D5DE0A5D2B5", date: "1677647002.933857", status: "Pending"), width: 428, height: 926)
    }
}
