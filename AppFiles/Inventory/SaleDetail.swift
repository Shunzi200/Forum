//
//  SaleDetail.swift
//  Looper
//
//  Created by Samuel Ridet on 12/30/22.
//

import SwiftUI

struct SaleDetail: View {
    @State var Sale : SaleStruct
    @State var editing = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    
    var body: some View {
        GeometryReader {geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment:.leading){
                    VStack(spacing: 0){
                        ZStack(alignment: Alignment(horizontal: .trailing,
                                                    vertical: .top)) {
                            UrlImageView(urlString: Sale.image)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                                .clipShape(Rectangle())
                            
                            Button {
                                firestoreConnector.updateSale(Sale: self.Sale)
                                firestoreConnector.fetchAccount {
                                    
                                    firestoreConnector.pullSales(SaleID: firestoreConnector.dataToDisplay.sales)
                                    firestoreConnector.pullPurchases(PurchaseID: firestoreConnector.dataToDisplay.purchases)
                                    
                                    
                                    
                                }
                                
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.black,.white)
                                    .padding()
                            }
                            
                            
                        }
                        Rectangle()
                        
                            .foregroundColor(Sale.size == "" ? CustomColor.mainThird : CustomColor.mainPurple)
                            .frame(height: 4)
                    }.onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    VStack (alignment: .leading){
                        
                        if (Sale.size == ""){
                            Text("\(Sale.type) - \(Sale.name)")
                                .font(.custom("Montserrat-Bold", size: 20))
                                .lineLimit(2)
                        }else{
                            Text("\(Sale.type) - \(Sale.name) - Bulk")
                                .font(.custom("Montserrat-Bold", size: 20))
                                .lineLimit(1)
                        }
                        
                           
                        Text("\(Sale.sku)")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .lineLimit(1)
                        
                        HStack {
                            VStack(alignment: .leading){
                                Text("Price Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    
                                    .underline()
                               
                                
                                HStack{
                                    
                                    VStack(alignment: .leading){
                                        
                                        HStack (spacing: 0){
                                            Text("$")
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                            TextField("", text: $Sale.boughtPrice)
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                //.multilineTextAlignment(.center)
                                               // .frame(width: geometry.size.width / 5)
                                                .foregroundColor(.white)
                                                .keyboardType(.decimalPad)
                                            
                        
                                        }
                                        Text("Bought Price")
                                            .font(.custom("Montserrat-Regular", size: 11))
                                    }
                            
                                    VStack(alignment: .leading){
                                 
                                        HStack (spacing: 0){
                                            Text("$")
                                                .foregroundColor(CustomColor.mainBlue)
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                            
                                            TextField("", text: $Sale.price)
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                //.multilineTextAlignment(.center)
                                                // .frame(width: geometry.size.width / 5)
                                                .foregroundColor(CustomColor.mainBlue)
                                                .keyboardType(.decimalPad)
                                            
                                            
                                        }
                                             
                                                
                                        
                                        Text("Sold Price")
                                            .font(.custom("Montserrat-Regular", size: 11))
                                            .foregroundColor(CustomColor.mainBlue)
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        
                                        Text("$\((Int(Sale.price) ?? 0) - (Int(Sale.boughtPrice) ?? 0))")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                            .foregroundColor(.green)
                                        Text("Profit")
                                            .font(.custom("Montserrat-Regular", size: 11))
                                            .foregroundColor(.green)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground)).onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        
                        HStack {
                            VStack(alignment:.leading, spacing: 10){
                             
                                Text("Sale Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                          
                                HStack {
                            
                                    Text("Sale Date")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    
                                    Spacer()
                                    TextField("", text: $Sale.date)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
    
                                }
                                HStack {
                                    Text("Buyer Name")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.buyer)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    Text("Payment Method")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.payment)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    customDropDownPicker(title: "Delivery Method", selection: $Sale.deliveryMethod, options: ["Shipping", "Local meetup", "Both"])
                                    
                                }
                                
                                HStack {
                                    Text("Tracking")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.tracking)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                    Button {
                                        UIPasteboard.general.string = "\(Sale.tracking)"
                                    } label: {
                                        Image(systemName: "list.clipboard")
                                            .foregroundColor(.white)
                                            
                                    }
                                }
                                HStack(alignment: .top) {
                                    Text("Address")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.address)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                    Button {
                                        UIPasteboard.general.string = "\(Sale.address)"
                                    } label: {
                                        Image(systemName: "list.clipboard")
                                            .foregroundColor(.white)
                                         
                                    }
                                }
                               
                            }
                            Spacer()
                        }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground)).onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        
                        HStack{
                            VStack(alignment:.leading, spacing: 10){
                                
                                Text("Item Details")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .underline()
                                
                                HStack {
                                    Text("Product Name")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.name)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    Text("Product SKU")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-Regular", size: 13))
                                    Spacer()
                                    TextField("", text: $Sale.sku)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    customDropDownPicker(title: "Product Condition", selection: $Sale.condition, options: ["New", "Used"])
                                    
                                }
                                
                                
                                
                                if Sale.size == ""{
                                    HStack (alignment: .top){
                                        Text("Size List")
                                            .font(.custom("Montserrat-Regular", size: 13))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        
                                        VStack{
                                            ForEach(Sale.sizeList, id: \.self){item in
                                                
                                                Text("\(item["size"] ?? "")\(item["category"]  ?? "") x \(item["quantity"]  ?? "")")
                                                    .font(.custom("Montserrat-SemiBold", size: 15))
                            
                                                    .foregroundColor(.white)
                                                  
                                                
                                                
                                            }
                                        }
                                    
                                    }
                                }else{
                                    HStack {
                                        Text("Product Size")
                                            .font(.custom("Montserrat-Regular", size: 13))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("\(Sale.size)\(Sale.category)")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                    }
                                }
                        
                                
                                
                            }
                        }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground)).onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }.padding(5)
                    Spacer()
                    
                    
                }.cornerRadius(15)
            }
        }
    }
}


struct SaleDetailDemo: View {
    @State var Sale = SaleStruct(id: "", address: "320 W Oakdale Ave", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.31.2022", deliveryMethod: "ship", image: "dsfkfsfd", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "", sizeList: [["size": "9", "category": "M", "quantity": "2", "price": "200"], ["size": "11", "category": "M", "quantity": "2", "price": "200"]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "Sale", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: "")
    var body: some View {
        SaleDetail(Sale: Sale)
    }
}
struct SaleDetail_Previews: PreviewProvider {
    static var previews: some View {
        SaleDetailDemo()
            .environmentObject(FirebaseConnector())
    }
}
