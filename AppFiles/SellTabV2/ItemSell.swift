//
//  ItemSell.swift
//  Looper
//
//  Created by Samuel Ridet on 2/9/23.
//

import SwiftUI
import InstantSearchSwiftUI

struct ItemSell: View {
    @Binding var images : [UIImage]
    @Binding var sku : String
    @Binding var name : String
    @Binding var query : String
    @Binding var defaultPicture : String
    @State var price = ""
    @State var size = ""
    @State var cat = ""
    @State var condition = "New"
    @State var delivery = "Shipping"
    @State var shippingPrice = ""
    @State var city = ""
    @State var state = ""
    @State var bulk = false
    @State var zipcode = ""
    
    @Environment(\.presentationMode) var presentation
    @State private var shouldScrollToBottom = false
    @ObservedObject var hitsController : HitsObservableController<JSONItem>
    @Binding var showConfirmation : Bool
    
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                ScrollView (showsIndicators: false){
                    VStack (alignment: .leading){
                        VStack (spacing: 0){
                            TabView{
                                if !defaultPicture.isEmpty{
                                    UrlImageView(urlString: defaultPicture)
                                        .scaledToFill()
                                        .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                                        .clipShape(Rectangle())
                                }
                                ForEach(images, id: \.self){i in
                                    Image(uiImage: i)
                                        .resizable()
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
                                Text("\(name)")
                                    .font(.custom("Montserrat-Bold", size: 18))
                                    .lineLimit(2)
                                    .padding(.horizontal, 10)
                                    .textSelection(.enabled)
                                
                                Text("\(sku)")
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)
                                    .textSelection(.enabled)
                                
                            }.onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("Item Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                                HStack {
                                    Text("Price")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                   
                                    TextField("200", text: $price)
                                        .limitInputLength(value: $price, length: 5)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                        .keyboardType(.decimalPad)

                                        Text("$")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                    
                                    
                                }
                                
                                HStack {
                                    Text("Size")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("9M", text: $size)
                                        .limitInputLength(value: $size, length: 6)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                        .multilineTextAlignment(.trailing)
                                        .frame(width: geometry.size.width * 0.15)
                                    
                                }    .padding(.trailing)
                                
                                HStack {
                                    customDropDownPicker(title: "Condition", selection: $condition, options: ["New", "Used"])
                                }
                                
                          
                            }.padding(.vertical, 10)
                                .padding(.horizontal).background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("Delivery Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                         
                                    HStack {
                                        customDropDownPicker(title: "Delivery Method", selection: $delivery, options: ["Shipping", "Local meetup", "Both"])
                                        
                                    }
                            
                                
                                if delivery == "Shipping" || delivery == "Both"{
                                    HStack {
                                        Text("Shipping")
                                            .foregroundColor(.gray)
                                            .font(.custom("Montserrat-Regular", size: 13))
                                        Spacer()
                                        
                                        TextField("10", text: $shippingPrice)
                                            .limitInputLength(value: $shippingPrice, length: 5)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                        
                                            .foregroundColor(.white)
                                            .accentColor(.white)
                                            .keyboardType(.decimalPad)
                                            .multilineTextAlignment(.trailing)
                                        
                                        Text("$")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                        
                                        
                                    }.padding(.trailing)
                                }
                                
                                if delivery == "Local meetup" || delivery == "Both"{
                                    HStack (spacing: 0){
                                        Text("City")
                                            .foregroundColor(.gray)
                                            .font(.custom("Montserrat-Regular", size: 13))
                                        Spacer()
                                        TextField("Chicago", text: $city)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .limitInputLength(value: $city, length: 25)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.white)
                                            .accentColor(.white)
                                        

                                    }.padding(.trailing)
                                    HStack (spacing: 0){
                                        Text("Postal Code")
                                            .foregroundColor(.gray)
                                            .font(.custom("Montserrat-Regular", size: 13))
                                        Spacer()
                                        TextField("60637", text: $zipcode)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .limitInputLength(value: $zipcode, length: 10)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.white)
                                            .accentColor(.white)

                                    }.padding(.trailing)
                                    
                                    HStack (spacing: 0){
                                        Text("State")
                                            .foregroundColor(.gray)
                                            .font(.custom("Montserrat-Regular", size: 13))
                                        Spacer()
                                        TextField("IL", text: $state)
                                            .limitInputLength(value: $state, length: 2)
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.white)
                                            .accentColor(.white)
                                    }.padding(.trailing)
                             
                                }
                                
                                
                            }.padding(.vertical, 10)
                                .padding(.horizontal).background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                                
                            
                            
                        }.padding(.horizontal, 5)
                    }
               
                 
                    
                    Spacer(minLength: 10)
                }

            }.navigationBarItems(trailing:
                                    Button {
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
                firestoreConnector.UploadListing(username: firestoreConnector.dataToDisplay.username, productName: name, productSKU: sku, productSize: size, productCat: cat, productPrice: price, productDelivery: delivery, productShipping: shippingPrice, productCity: city, productState: state, productCondition: condition, images: images, productType: "Item", rating: "0", defaultPicture: defaultPicture, zipcode: zipcode)
                
                self.name = ""
                self.query = ""
                self.hitsController.hits = []
                size = ""
                cat = ""
                self.sku = ""
                price = ""
                condition = "New"
                delivery = "Shipping"
                shippingPrice = ""
                city = ""
                state = ""
                self.images = []
                self.defaultPicture = ""
                
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

                    Text("List")
                        .font(.custom("Montserrat-SemiBold", size: 12))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 15)     .foregroundColor((price.isEmpty || size.isEmpty || delivery == "Shipping" ? shippingPrice.isEmpty : false) || (delivery == "Local meetup" ? state.isEmpty || city.isEmpty : false) || (delivery == "Both" ? state.isEmpty || city.isEmpty || shippingPrice.isEmpty : false) ? .gray : .white))
                 
      
            }
                .disabled(self.price.isEmpty || self.size.isEmpty)
                .disabled((delivery == "Shipping" ? shippingPrice.isEmpty : false) || (delivery == "Local meetup" ? state.isEmpty || city.isEmpty : false) || (delivery == "Both" ? state.isEmpty || city.isEmpty || shippingPrice.isEmpty : false))
                    
     
            )
            
        }
    }
}


struct ItemSell_Previews: PreviewProvider {
    @State static var t = "Jordan"
    @State static var def = "https://images.stockx.com/images/Air-Jordan-1-High-OG-Spider-Man-Across-the-Spider-Verse.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1679431354"
    @State static var im = [UIImage(named: "DunkPanda4") ?? UIImage(),UIImage(named: "DunkPanda5") ?? UIImage(),UIImage(named: "DunklPanda3") ?? UIImage()]
    @State static var show = false
    static var previews: some View {
        NavigationView{
            ItemSell(images: $im,sku: $t, name: $t, query: $t, defaultPicture: $def, hitsController: HitsObservableController<JSONItem>(), showConfirmation: $show)
                .environmentObject(FirebaseConnector())
        }
    }
}




