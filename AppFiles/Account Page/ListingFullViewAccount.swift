    //
    //  ListingFullViewAccount.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/27/22.
    //

import SwiftUI

struct ListingFullViewAccount: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Environment(\.presentationMode) var presentation
    

    @State var isEditing = false
    @State var listingData : feedInfo

    @State var username = " "
    @State var itemName = " "
    @State var itemSizeNum = " "
    @State var itemSizeCat = ""
    @State var itemSKU = " "
    @State var itemPrice = " "
    @State var itemCondition = " "
    @State var itemDelivery = " "
    @State var itemShipping = " "
    @State var itemCity = " "
    @State var itemState = " "
    @State var itemZipCode = " "
  
   
   
    
    var body: some View {
        GeometryReader { geometry in
            let imageName : [String] = listingData.images as? [String] ?? [""]
            VStack {
                ScrollView (showsIndicators: false){
                    VStack (alignment: .leading){
                        VStack (spacing: 0){
                            TabView{
                                ForEach(imageName, id: \.self){i in
                                    
                                    UrlImageView(urlString: i)
                                        .scaledToFill()
                                        .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                                        .clipShape(Rectangle())
                                    
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                            .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            
                            Rectangle()
                            
                                .foregroundColor(CustomColor.mainPurple)
                                .frame(height: 4)
                        }
                        
                        VStack(alignment: .leading) {
                            VStack (alignment: .leading){
                                Text("\(itemName)")
                                    .font(.custom("Montserrat-Bold", size: 18))
                                    .lineLimit(2)
                                
                                Text("\(itemSKU)")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                    .lineLimit(1)
                            }.onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            
                            VStack (alignment: .leading, spacing: 10){
                                Text("Item Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                                HStack {
                                    Text("Price")
                                        .font(.custom("Montserrat-Regular", size: 13))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    
                                    HStack {
                                        
                                        TextField("200", text: $itemPrice)
                                            .limitInputLength(value: $itemPrice, length: 5)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                          
                                            .disabled(!isEditing)
                                            .accentColor(.white)
                                            .keyboardType(.decimalPad)
                                          
                                            .multilineTextAlignment(.trailing)
                                        Text("$")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            
                                    }
                                }
                                
                                HStack {
                                    Text("Size")
                                        .font(.custom("Montserrat-Regular", size: 13))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    TextField("9M", text: $itemSizeNum)
                                        .limitInputLength(value: $itemSizeNum, length: 6)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .accentColor(.white)
                                        .multilineTextAlignment(.trailing)
                                        .disabled(!isEditing)
                                        .foregroundColor(isEditing ? .white : .gray)
                                       
                                }
                                
                                HStack {
                                    customDropDownPicker(title: "Condition", selection: $itemCondition, options: ["New", "Used"], disabled: $isEditing)
                                        
                                        .disabled(!isEditing)
                                    
                                }
                                
                                
                            }.padding()
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("Delivery Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                                HStack {
                                    customDropDownPicker(title: "Delivery Method", selection: $itemDelivery, options: ["Shipping", "Local meetup", "Both"], disabled: $isEditing)
                                       
                                        .disabled(!isEditing)
                                    
                                }
                                
                                if itemDelivery == "Shipping" || itemDelivery == "Both"{
                                    HStack {
                                        Text("Shipping")
                                            .font(.custom("Montserrat-Regular", size: 13))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        
                                        TextField("10", text: $itemShipping)
                                            .limitInputLength(value: $itemShipping, length: 5)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .keyboardType(.decimalPad)
                                            .multilineTextAlignment(.trailing)
                                            .disabled(!isEditing)
                                            .foregroundColor(isEditing ? .white : .gray)
                                        
                                        Text("$")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .foregroundColor(isEditing ? .white : .gray)
                                        
                                        
                                    }
                                }
                                
                                if itemDelivery == "Local meetup" || itemDelivery == "Both"{
                                    HStack (spacing: 0){
                                        Text("City")
                                            .font(.custom("Montserrat-Regular", size: 13))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        TextField("Chicago", text: $itemCity)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .limitInputLength(value: $itemCity, length: 25)
                                            .multilineTextAlignment(.trailing)
                                            .accentColor(.white)
                                            .foregroundColor(isEditing ? .white : .gray)
                                            .disabled(!isEditing)
                                    }
                                    
                                    HStack (spacing: 0){
                                        Text("Postal Code")
                                            .foregroundColor(.gray)
                                            .font(.custom("Montserrat-Regular", size: 13))
                                        Spacer()
                                        TextField("60637", text: $itemZipCode)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .limitInputLength(value: $itemZipCode, length: 10)
                                            .multilineTextAlignment(.trailing)
                                            .accentColor(.white)
                                            .foregroundColor(isEditing ? .white : .gray)
                                            .disabled(!isEditing)
  
                                    }
                                    
                                    HStack (spacing: 0){
                                        Text("State")
                                            .font(.custom("Montserrat-Regular", size: 13))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        TextField("IL", text: $itemState)
                                            .limitInputLength(value: $itemState, length: 2)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .multilineTextAlignment(.trailing)
                                            .accentColor(.white)
                                            .foregroundColor(isEditing ? .white : .gray)
                                            .disabled(!isEditing)
                                    }
                                }
                                
                                
                            }.padding()
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                            
                            
                            
                        }.padding(.horizontal, 5)
                    }
                    Spacer(minLength: 7)
                }
                
            }

            
        }

        .navigationBarTitle(" ", displayMode: .inline)

        .navigationBarItems(trailing:
                                
            Button {
            
            if isEditing{
                firestoreConnector.EditListing(postID: listingData.id, username: listingData.username, productName: itemName, productSKU: itemSKU, productSize: itemSizeNum, productCat: itemSizeCat, productPrice: itemPrice, productDelivery: itemDelivery, productShipping: itemShipping, productCity: itemCity, productState: itemState, productCondition: itemCondition, zipcode: itemZipCode)
                self.presentation.wrappedValue.dismiss()
            }else{
                isEditing.toggle()
                
                self.itemName = listingData.productName
                self.itemSizeNum = listingData.productSize
                self.itemSizeCat = ""
                self.itemSKU = listingData.productSKU
                self.itemPrice = listingData.productPrice
                self.itemCondition = listingData.productCondition
                self.itemDelivery = listingData.productDelivery
                self.itemShipping = listingData.shipping
                self.itemCity = listingData.city
                self.itemState = listingData.state
                self.itemZipCode = listingData.zipcode ?? ""
               
            }
            
        } label: {
            Image(systemName: isEditing ? "checkmark" : "pencil")
                .resizable()
                .scaledToFit()
            
                .padding(.trailing)
                .foregroundColor(.white)
        }
                            
                            
        )
        .onAppear{

            self.itemName = listingData.productName
            self.itemSizeNum = listingData.productSize
            self.itemSizeCat = ""
            self.itemSKU = listingData.productSKU
            self.itemPrice = listingData.productPrice
            self.itemCondition = listingData.productCondition
            self.itemDelivery = listingData.productDelivery
            self.itemShipping = listingData.shipping
            self.itemCity = listingData.city
            self.itemState = listingData.state
            self.itemZipCode = listingData.zipcode ?? ""
        }
        
        
    }
    
    
    
}
struct demo3: View {
    @State var listingData = feedInfo(id: "", username: "", productName: "", productSKU: "", productSize: "", productCat: "", productPrice: "", productCondition: "", productDelivery: "", city: "", state: "", shipping: "", time: "", postType: "", atype: "", caption: "", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [[:]], rating: "", Nameimages: [], zipcode: "")
    

    
    var body: some View {
        
        ListingFullViewAccount(listingData: listingData)
    }
}

struct ListingAccountView_Previews: PreviewProvider {
    static var previews: some View {
        demo3()
            .environmentObject(FirebaseConnector())
    }
}




