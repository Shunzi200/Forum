//
//  LogChatBuyer.swift
//  Looper
//
//  Created by Samuel Ridet on 12/26/22.
//

import SwiftUI

struct LogChatBuyer: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Environment(\.presentationMode) var presentation
    
    @State var  images = ["imagePlaceHolder"]
    @State var isEditing = true
    @State var listingData : feedInfo
    @State var chat : Chat
    @State var offerPrice : String
    @State var userProfile : accountProfile
    @State var username = " "
    @State var itemName = " "
    @State var itemSizeNum = " "
    @State var itemSizeCat = " "
    @State var itemSKU = " "
    @State var itemPrice = " "
    @State var itemCondition = " "
    @State var itemDelivery = " "
    @State var itemShipping = " "
    @State var itemCity = " "
    @State var itemState = " "
    @State var sizeList : [[String:String]] = [[:]]
    @State var date = ""
    @State var boughtPrice = ""
    @State var paymentMethod = ""
    @State var deliveryMethod = "Ship"
    @State var address = ""
    @State var tracking = ""
    @State var buyerName = ""
    @State var holder = ""
    @State var condition = ""
    
    @Binding var showConfirmation : Bool
    @Binding var exitNext : Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView (showsIndicators: false){
                VStack(alignment: .leading) {
                    
                    
                    VStack (spacing: 0){
                        UrlImageView(urlString: listingData.images.first as? String ?? "")
                        
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                            .clipShape(Rectangle())
                        
                        Rectangle()
                        
                            .foregroundColor(listingData.postType != "Item" ? CustomColor.mainThird : CustomColor.mainPurple)
                            .frame(height: 4)
                    }
                    
                    
                    if (listingData.postType == "Item"){
                        Text("\(listingData.productName)")
                            .font(.custom("Montserrat-Bold", size: 18))
                            .lineLimit(2)
                            .padding(.horizontal,5)
                    }else{
                        Text("\(listingData.productName) - Bulk")
                            .font(.custom("Montserrat-Bold", size: 18))
                            .lineLimit(2)
                            .padding(.horizontal,5)
                    }
                    
                    Text("\(listingData.productSKU)")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .padding(.horizontal,5)
                    
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text("Sale Details")
                            .font(.custom("Montserrat-Bold", size: 15))
                            .underline()
                        HStack {
                            Text("Bought Price")
                                .font(.custom("Montserrat-Regular", size: 13))
                                .foregroundColor(.gray)
                            Spacer()
                            
                            HStack {
                                
                                TextField("200", text: $itemPrice)
                                    .limitInputLength(value: $offerPrice, length: 5)
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                
                                    .accentColor(.white)
                                    .keyboardType(.decimalPad)
                                
                                    .multilineTextAlignment(.trailing)
                                Text("$")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                
                            }
                            
                        }
                        
                        
                        if listingData.postType == "Item"{
                            HStack {
                                Text("Size")
                                    .foregroundColor(.gray)
                                    .font(.custom("Montserrat-Regular", size: 13))
                                Spacer()
                                TextField("", text: $listingData.productSize)
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        
                        HStack {
                            customDropDownPicker(title: "Condition", selection: $itemCondition, options: ["New", "Used"])
                            
                        }
                        
                        
                        HStack {
                            
                            Text("Sale Date")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-Regular", size: 13))
                            
                            Spacer()
                            TextField("", text: $date)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .multilineTextAlignment(.trailing)
                            
                        }
                        HStack {
                            Text("Seller Name")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-Regular", size: 13))
                            Spacer()
                            TextField("John", text: $buyerName)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                    
                    VStack(alignment:.leading, spacing: 10){
                        Text("Delivery Details")
                            .font(.custom("Montserrat-Bold", size: 15))
                            .underline()
                        
                        HStack {
                            customDropDownPicker(title: "Delivery Method", selection: $itemDelivery, options: ["Shipping", "Local meetup", "Both"])
                            
                        }
                        HStack {
                            Text("Address")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-Regular", size: 13))
                            Spacer()
                            TextField("123 North Avenue Street", text: $address)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Tracking")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-Regular", size: 13))
                            Spacer()
                            TextField("1Z654H23A459", text: $tracking)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Payment Method")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-Regular", size: 13))
                            Spacer()
                            TextField("Venmo", text: $paymentMethod)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                    
                    if (listingData.postType != "Item"){
                        VStack(alignment: .leading, spacing: 2){
                            HStack{
                                Text("Size List")
                                    .foregroundColor(.white)
                                    .underline()
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                Spacer()
                            }
                            
                            
                            ForEach(0 ..< sizeList.count, id: \.self) { index in
                                let item = sizeList[index]
                                HStack {
                                    Text("\(item["size"] ?? "") x \(item["quantity"] ?? "")")
                                        .font(.custom("Montserrat-SemiBold", size: 13))
                                    Spacer()
                                    
                                    
                                }
                                
                                
                            }
                            
                        } .padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                    }
                    
                }
                Spacer(minLength: 10)
            }
            
            
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
      
        
        .navigationBarTitle("Log Purchase", displayMode: .inline)
        
        .navigationBarItems(trailing:
                                
            Button {
            let impactMed = UIImpactFeedbackGenerator(style: .light)
            impactMed.impactOccurred()
            firestoreConnector.logSale(type: "Purchase", prodName: itemName, sku: itemSKU, size: itemSizeNum, sizeList: sizeList, price: itemPrice, buyer: buyerName, date: date, boughtPrice: "", payment: paymentMethod, deliveryMethod: deliveryMethod, address: address, tracking: tracking, image: listingData.images.first as? String ?? "", productCat: itemSizeCat, otherUser: userProfile.id, condition: condition, delete: false, listingID: listingData.id)
            self.presentation.wrappedValue.dismiss()
            self.exitNext.toggle()
            withAnimation{
                showConfirmation = true
            }
            self.presentation.wrappedValue.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation{
                    showConfirmation = false
                }
                
            }
        } label: {
            Text("Log")
                .font(.custom("Montserrat-SemiBold", size: 12))
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
        }
                            
                            
        )
        .onAppear{
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy"
            let today = dateFormatter.string(from: date)
            
            self.itemName = listingData.productName
            self.itemSizeNum = listingData.productSize
            self.itemSizeCat = listingData.productCat
            self.sizeList = listingData.bulkSize
            self.itemSKU = listingData.productSKU
            self.itemPrice = listingData.productPrice
            self.itemCondition = listingData.productCondition
            self.itemDelivery = listingData.productDelivery
            self.itemShipping = listingData.shipping
            self.itemCity = listingData.city
            self.itemState = listingData.state
            self.buyerName = userProfile.username
            self.itemPrice = offerPrice
            self.date = today
            self.condition = listingData.productCondition
            
            
        }
        
        
    }
    
}
struct LogChatBuyerDemo: View {
    @State var account = accountProfile(id: "", username: "french_soles", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: [])
    @State var chat = Chat(id: "", members: ["M17K7nYafvPjwJqDsyEwDAX4UCy1", "iPq88RlqSegBTbgEaiu4p8cEW4x1"], lastMessage: "Hello", listingID: "", offerPrice: "300", date: "12423432423", opened: false, lastSender: "")
    @State var listing = feedInfo(id: "dgfsdgs", username: "french_soles", productName: "Jordan 1 Volt", productSKU: "DHJSA-334", productSize:"" , productCat: "9", productPrice: "230", productCondition: "New", productDelivery: "Local", city: "Chicago", state: "IL", shipping: "15", time: "3458235290375", postType: " ", atype: " ", caption: "Loopin like we like it", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [["size": "9", "category": "M", "quantity": "2", "price": "200"], ["size": "11", "category": "M", "quantity": "2", "price": "200"]], rating: "", Nameimages: [])
    
    
    @State var show = false
    var body: some View {
        
        LogChatBuyer(listingData: listing, chat: chat, offerPrice: "300", userProfile: account, showConfirmation: $show, exitNext: $show)
    }
}
struct LogChatBuyer_Previews: PreviewProvider {
    static var previews: some View {
        LogChatBuyerDemo()
    }
}
