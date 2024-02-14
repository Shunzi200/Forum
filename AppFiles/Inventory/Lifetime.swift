//
//  Lifetime.swift
//  Looper
//
//  Created by Samuel Ridet on 12/28/22.
//

import SwiftUI

struct Lifetime: View {
    @State var all : [SaleStruct] = []
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        GeometryReader{geometry in
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    HStack {
                        Spacer()
                        OverAllStats()
                            .frame(width: geometry.size.width * 0.9)
                        Spacer()
                    }
                    Text("Recent Sales")
                        .font(.custom("Montserrat-Bold", size: 16))
                        .padding(.horizontal)
                    if firestoreConnector.salesArray.count > 0{
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(firestoreConnector.salesArray){Rsale in
                                    RecentSale(width: geometry.size.width, height: geometry.size.height, Sale: Rsale)
                                        .frame(width: geometry.size.width / 2.5)
                                }
                            }
                        }.padding(.horizontal)
                        .padding(.vertical, 5)
                    }else{
                        HStack{
                            Spacer()
                            Text("No recent sales")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }.frame(height: geometry.size.height * 0.15)
                        
                    }
                    Text("Recent Users")
                        .font(.custom("Montserrat-Bold", size: 16))
                        .padding(.horizontal)
                    if firestoreConnector.allSalePurchase.count > 0{
                      
                        
                 
                        VStack{
                        
                            
                            ForEach(firestoreConnector.allSalePurchase){s in
                                
                                if s.otherUserID != ""{
                                    UserCardView(userID: s.otherUserID, width: geometry.size.width, height: geometry.size.height, Sale: s)
                                }
                              
                                
                            }
                            
                        }  .padding(.horizontal)
                            .padding(.vertical, 5)
                    }else{
                        HStack{
                            Spacer()
                            Text("No recent users")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }.frame(height: geometry.size.height * 0.15)
                    }
                    
                }
            }.refreshable {
                firestoreConnector.fetchAccount {
                    
                    firestoreConnector.pullSales(SaleID: firestoreConnector.dataToDisplay.sales)
                    firestoreConnector.pullPurchases(PurchaseID: firestoreConnector.dataToDisplay.purchases)
                    
                }
            }.onAppear{
                
                firestoreConnector.fetchAccount {
                    
                    firestoreConnector.pullSales(SaleID: firestoreConnector.dataToDisplay.sales)
                    firestoreConnector.pullPurchases(PurchaseID: firestoreConnector.dataToDisplay.purchases)
                
                }
                
            }
            
        }
    }
}

struct LifetimeDemo: View {
    @State var saleArray = [SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.31.2022", deliveryMethod: "ship", image: "dsfkfsfd", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "Sale", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: ""), SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.31.2022", deliveryMethod: "ship", image: "dsfkfsfd", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "Sale", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: "")]
    var body: some View {
        Lifetime()
    }
}
struct Lifetime_Previews: PreviewProvider {
    static var previews: some View {
        LifetimeDemo()
            .environmentObject(FirebaseConnector())
    }
}
