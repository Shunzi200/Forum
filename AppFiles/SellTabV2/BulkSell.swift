//
//  BulkSell.swift
//  Looper
//
//  Created by Samuel Ridet on 2/12/23.
//

import SwiftUI
import InstantSearchSwiftUI


struct BulkSell: View {
    @Binding var images : [UIImage]
    @Binding var sku : String
    @Binding var name : String
    @Binding var query : String
    @Binding var defaultPicture : String
    @ObservedObject var hitsController : HitsObservableController<JSONItem>
    @State var price = "0"
    @State var size = ""
    @State var cat = "M"
    @State var condition = "New"
    @State var delivery = "Shipping"
    @State var shippingPrice = ""
    @State var city = ""
    @State var state = ""
    @State var zipcode = ""
    @State var sizeList : [[String : String]] = []
    @Binding var showConfirmation : Bool
    
    
    
    @Environment(\.presentationMode) var presentation
    @State private var shouldScrollToBottom = false
    
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
                            
                                .foregroundColor(CustomColor.mainThird)
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
                                        .font(.custom("Montserrat-Regular", size: 13))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("\(price) $")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                    
                                    
                                }
                                
                                
                                
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
                                        
                                        
                                    }
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
                                        
                                           
                                        
                                        
                                    }
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
                                        
                                        
                                    }
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
                                    }
                                }
                                }.padding(.vertical, 10)
                                .padding(.horizontal).background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                            
                            bulkSizeList(sizeList: $sizeList, productPrice: $price, productCat: $cat, width: geometry.size.width)
                            
                            
                            
                        }.padding(.horizontal, 5)
                    }
                    Spacer(minLength: 20)
                }
                
                
    
                
               
            }.navigationBarItems(trailing:
                                    Button {
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
                firestoreConnector.UploadBulk(username: firestoreConnector.dataToDisplay.username, productName: name, productSKU: sku, productSize: sizeList, productCat: cat, productPrice: price, productDelivery: delivery, productShipping: shippingPrice, productCity: city, productState: state, productCondition: condition, images: images, productType: "Bulk", rating: "0", defaultPicture: defaultPicture, zipcode: zipcode)
                
                
                
                self.name = ""
                self.query = ""
                hitsController.hits = []
                size = ""
                cat = "M"
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
                    .background(RoundedRectangle(cornerRadius: 15)     .foregroundColor((sizeList.isEmpty || delivery == "Shipping" ? shippingPrice.isEmpty : false) || (delivery == "Local meetup" ? state.isEmpty || city.isEmpty : false) || (delivery == "Both" ? state.isEmpty || city.isEmpty || shippingPrice.isEmpty : false) ? .gray : .white))
                
                
            }
                .disabled(self.price.isEmpty || self.sizeList.isEmpty)
                .disabled((delivery == "Shipping" ? shippingPrice.isEmpty : false) || (delivery == "Local meetup" ? state.isEmpty || city.isEmpty : false) || (delivery == "Both" ? state.isEmpty || city.isEmpty || shippingPrice.isEmpty : false))
            )
        }
    }
    
    
}


struct bulkSizeList : View{
    @Binding var sizeList : [[String : String]]
    @Binding var productPrice : String
    @Binding var productCat : String
    
    @State var total = 0.0
    @State var totalQ = 0.0
    
    @State var size = ""
    
    @State var category = "M"
    
    @State var quantity = ""
    @State var price = ""
    
    var width : CGFloat
    
    @State var holder = ""
    
    @FocusState private var isFocusedOnFirstTextField: Bool
    @FocusState private var isFocusedOnSecondTextField: Bool
    @FocusState private var isFocusedOnThirdTextField: Bool
    
    var body: some View{
        
        VStack {
            VStack {
                
                HStack {
                    VStack(alignment: .leading){
                        Text("Size")
                            .font(.custom("Montserrat-Bold", size: 13))
                        HStack {
                            TextField("9M", text: $size)
                                .font(.custom("Montserrat-SemiBold", size: 14))
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .frame(width: width * 0.13)
                                .limitInputLength(value: $size, length: 6)
                                //.focused($isFocusedOnFirstTextField)
                                //.submitLabel(.next)
                                .onSubmit {
                                //    isFocusedOnSecondTextField = true
                                }
                        }
                        
                    }

                    VStack(alignment: .leading){
                        Text(" ")
                            .font(.custom("Montserrat-Bold", size: 13))
                        
                        TextField("x", text: $holder)
                            .font(.custom("Montserrat-SemiBold", size: 16))
                            .disabled(true)
                            .frame(width: width * 0.1)
                            .limitInputLength(value: $quantity, length: 3)
                    }


                    VStack(alignment: .leading){
                        Text("Quantity")
                            .font(.custom("Montserrat-Bold", size: 13))
                        
                        TextField("5", text: $quantity)
                            .font(.custom("Montserrat-SemiBold", size: 14))
                            .frame(width: width * 0.1)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .keyboardType(.numberPad)
                            .limitInputLength(value: $quantity, length: 3)
                            .focused($isFocusedOnSecondTextField)
                            //.submitLabel(.next)
                            .onSubmit {
                             //   isFocusedOnThirdTextField = true
                            }
                    }
                 
                    Spacer()
                    
                    VStack{
                        Text("Price per")
                            .font(.custom("Montserrat-Bold", size: 13))
                        HStack {
                            
                            TextField("200", text: $price)
                                .font(.custom("Montserrat-SemiBold", size: 14))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .keyboardType(.decimalPad)
                                .frame(width: width * 0.15)
                                .limitInputLength(value: $price, length: 6)
                                .focused($isFocusedOnThirdTextField)
                         
                              

                            Text("$")
                                .font(.custom("Montserrat-SemiBold", size: 14))
                        }
                    }
                    
                    Button {
                        self.sizeList.append(["size" : size, "category" : "", "quantity": quantity, "price": price])
                        self.total = 0
                        self.totalQ = 0
                        for e in sizeList{
                            self.total += Double(e["price"]!)! * Double(e["quantity"]!)!
                            self.totalQ += Double(e["quantity"]!)!
                            self.productPrice = String(self.total)
                            self.productCat = String(Int(self.totalQ))
                        }
                        
                        self.sizeList = sizeList.sorted {
                            guard let s1 = $0["size"], let s2 = $1["size"] else {
                                return false
                                
                            }
                            if s1 == s2 {
                                guard let g1 = $0["size"], let g2 = $1["size"] else {
                                    return false
                                }
                                return g1 < g2
                            }
                            return s1 < s2
                        }
                        self.size = ""
                        self.quantity = ""
                        self.price = ""
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(size.isEmpty || quantity.isEmpty || price.isEmpty ? .gray : .white)
                    }
                    
                    .disabled(size.isEmpty || quantity.isEmpty || price.isEmpty)
                }.padding(.leading, 10)
                
                
                
                
                
            }.padding(.vertical, 10)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            
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
                        Text("\(item["size"] ?? "") x \(item["quantity"] ?? "") - \(item["price"] ?? "")$")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                        Spacer()
                        Button {
                    
                            
                            sizeList.remove(at: index)
                            self.total = 0
                            self.totalQ = 0
                            for e in sizeList{
                                self.total += Double(e["price"]!)! * Double(e["quantity"]!)!
                                self.totalQ += Double(e["quantity"]!)!
                            }
                            self.productPrice = String(self.total)
                            self.productCat = String(Int(self.totalQ))

                            
                            self.sizeList = sizeList.sorted {
                                guard let s1 = $0["size"], let s2 = $1["size"] else {
                                    return false
                                    
                                }
                                if s1 == s2 {
                                    guard let g1 = $0["size"], let g2 = $1["size"] else {
                                        return false
                                    }
                                    return g1 < g2
                                }
                                return s1 < s2
                            }
                            
                            
                        } label: {
                            Text("x")
                                .foregroundColor(.red)
                                .bold()
                        }

                    }
                            
                            
                    }
                


            } .padding(.vertical, 10)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(CustomColor.grayBackground))
               
        }
    }

   

}


struct BulkSell_Previews: PreviewProvider {
    @State static var t = "Jordan"
    @State static var im = [UIImage(named: "DunkPanda4") ?? UIImage(),UIImage(named: "DunkPanda5") ?? UIImage(),UIImage(named: "DunklPanda3") ?? UIImage()]
    @State static var con = false
    @State static var sizeList : [[String: String]] = []
    @State static var def = "https://images.stockx.com/images/Air-Jordan-1-High-OG-Spider-Man-Across-the-Spider-Verse.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1679431354"
    static var previews: some View {
        NavigationView {
            BulkSell(images: $im, sku: $t, name: $t, query: $t, defaultPicture: $def, hitsController: HitsObservableController(), showConfirmation: $con)
        }
        //bulkSizeList(sizeList: $sizeList, productPrice: $t, productCat: $t, width: 428)

         
    }
}

