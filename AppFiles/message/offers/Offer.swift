//
//  Offer.swift
//  Looper
//
//  Created by Samuel Ridet on 12/19/22.
//

import SwiftUI

struct Offer: View {
    @State var Off : offer
    @StateObject var firestoreConnector = FirebaseConnector()
    @Environment(\.presentationMode) var presentationMode
   
    var width: CGFloat
    var height: CGFloat
    @State var showAccount = false
    @Binding var offerMainAr : [OList]
    @Binding var offerAr : [offer]
    @Binding var offerSelect : Bool

    var listingName : String
    @Binding var option : Int
    var body: some View {
        
        VStack {
           
            HStack{
                UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                    .scaledToFill()
                    .frame(width: width * 0.15, height: width * 0.15)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                
                VStack (alignment: .leading){
                    Text("\(firestoreConnector.viewdataToDisplay.username)")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .lineLimit(1)
                    Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                        .font(.custom("Montserrat-Regular", size: 15))
                }.padding(.horizontal, 5)
                Spacer()
                Text("$\(Off.offerPrice)")
                    .font(.custom("Montserrat-Bold", size: 19))
                    .padding(.horizontal, 10)
                Spacer()
                
                
                    Button {
                        self.offerSelect = false
                        firestoreConnector.createChat(user: firestoreConnector.viewdataToDisplay.userID, listingID: Off.listingID, userChats: firestoreConnector.viewdataToDisplay.chats, ownerChats: firestoreConnector.dataToDisplay.chats, offerPrice: Off.offerPrice)
                        
                        let result = firestoreConnector.declineOffer(offerMainAr: self.offerMainAr, listingID: Off.listingID, offerID: Off.id, listingName: listingName, deleting: true)
                        
                        self.offerAr = result.0
                       self.offerMainAr = result.1
                        self.option = 0

                    } label: {
                        
                        Image(systemName: "ellipsis.message.fill")
                                .resizable()
                                .foregroundColor(.white)
                            .frame(width: width * 0.05, height: width * 0.05)
                
                        
                    }
                    .padding(.horizontal, 5)
               
                
                Button {
               
                    
                    let result = firestoreConnector.declineOffer(offerMainAr: self.offerMainAr, listingID: Off.listingID, offerID: Off.id, listingName: listingName, deleting: false)
                    
                    self.offerAr = result.0
                    self.offerMainAr = result.1
                    
                    
        
                    
                } label: {
                    Text("X")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 5)

            }.onTapGesture {
                self.showAccount.toggle()
            }.sheet(isPresented: $showAccount) {
                ViewUserAccount(userID: Off.userID)
            }
        }.padding(.horizontal, 2).onAppear{
            firestoreConnector.fetchViewAccount(userID: Off.userID)
            firestoreConnector.fetchAccount(){
                
            }
        }
    }
    
}

struct demi: View{
    @State var Off  = offer(id: "fsfsfs", ownerID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", offerPrice: "400", listingID: "dgfdgd", date: " ", status: "Pending")
    @State var offMainAr = [OList(id: "", offers: [])]
    @State var offAr = [offer(id: "fsfsfs", ownerID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", offerPrice: "400", listingID: "dgfdgd", date: "", status: "Pending")]
    @State var offerSelect = true
    @State var option = 0
    var body: some View{
        Offer(Off: Off, width: 428, height: 926, offerMainAr: $offMainAr, offerAr: $offAr, offerSelect: $offerSelect, listingName: "", option: $option)
    }
}
struct Offer_Previews: PreviewProvider {
    static var previews: some View {
        demi()
    }
}
