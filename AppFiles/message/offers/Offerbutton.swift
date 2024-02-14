//
//  Offerbutton.swift
//  Looper
//
//  Created by Samuel Ridet on 12/17/22.
//

import SwiftUI

struct Offerbutton: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var listing : feedInfo
    @State var text = ""
    @State var alreadySent = false
    var characterLimit = 7
    var textFieldHeight = 50.0
    var placeHolderText = "Send Offer"
    @State var pressed = false
    @Binding var showConfirmation : Bool
  
    
    
    var body: some View {
        ZStack (alignment: .bottom) {
            ZStack(alignment: .leading) {
                
                    HStack {
                        HStack {
                           Text("$")
                                .font(.custom("Montserrat-SemiBold", size: 20))
                            TextField("100", text: $text)
                                .limitInputLength(value: $text, length: characterLimit)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .font(.custom("Montserrat-SemiBold", size: 20))
                                .keyboardType(.decimalPad)
                         
                            Spacer()
                      
                        }
                        .padding()
                   
                        
                        Button(action: {
                            firestoreConnector.sendOffer(offer: text, ownerID: listing.userID, listingID: listing.id, ownerUsername: listing.username, listingName: listing.productName) { success in
                                if success {
                                    withAnimation{
                                        showConfirmation = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            showConfirmation = false
                                        }
                                        
                                    }
                                } else {
                                    self.alreadySent = true
                                }
                                //pressed = true
                            }
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            
                            self.text = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                        }, label: {
                            Image(systemName: "paperplane.fill")
                                .font(.title3)
                                .foregroundColor(text.count == 0 ? .gray : .white)
                        }).disabled(text.count == 0)
                            .padding(.trailing, 10)

                       
                        
                    }
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                .accentColor(Color.secondary)
                    
                    
              
     
                Text(placeHolderText)
                    .font(.custom("Montserrat-SemiBold", size: 15))
                    .foregroundColor(.white)
                    .background(.black)
                    .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
                
            }
            if alreadySent {
                Text("Already sent an offer")
                    .font(.custom("Montserrat-SemiBold", size: 12))
                    .foregroundColor(.red)
                    .offset(y: 12)
            }else{
                if pressed{
                    Text("Offer sent")
                        .font(.custom("Montserrat-SemiBold", size: 12))
                        .offset(y: 12)
                }
                
            }
        }
    }
}

struct Offerbutton_Previews: PreviewProvider {
    @State static var showConfirmation = false
    static var previews: some View {
        Offerbutton(listing: feedInfo(id: "fdsfs", username: "french_soles", productName: "Jordan 1 Retro High OG A Ma Maniére", productSKU: "HDsja", productSize: "7", productCat: "M", productPrice: "300", productCondition: "New", productDelivery: "Ship", city: "Chicago", state: "IL", shipping: "10", time: "242435", postType: "Item", atype: "", caption: "We looped this shit like it was Mickey Ds", likes: [], saves: [], comments: [], images: ["https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/images%2F0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg?alt=media&token=60f14e83-3c9a-46bd-b281-8f32b698c903"], userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", bulkSize: [[:]], rating: "4.0", Nameimages: ["0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg"]), showConfirmation: $showConfirmation)
    }
}

