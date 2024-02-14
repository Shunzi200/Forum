//
//  OverAll stats.swift
//  Looper
//
//  Created by Samuel Ridet on 12/28/22.
//

import SwiftUI

struct OverAllStats: View {

    @State var totalProfit = 0
    @State var totalSales = 0
    @State var totalPurchases = 0
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
             
                HStack{
                        Image(systemName: "bag.fill")
                        .foregroundColor(CustomColor.mainThird)
                        
                        VStack(alignment: .leading){
                            Text("$\(firestoreConnector.profit)")
                                .font(.custom("Montserrat-Bold", size: 17))
                            Text("Total Profits")
                                .font(.custom("Montserrat-Regular", size: 12))
                            
                        }
                }.padding([.trailing])

                Spacer()
                HStack{
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    VStack(alignment: .leading){
                        Text("$\(firestoreConnector.saleVolume)")
                            .font(.custom("Montserrat-Bold", size: 17))
                        Text("Total Sales")
                            .font(.custom("Montserrat-Regular", size: 12))
                        
                    }
                }
          
                
 
                
                
            }.padding([.bottom], 5)
            HStack {
                HStack{
                    Image(systemName: "cart.fill")
                        .foregroundColor(CustomColor.mainPurple)

                    
                    VStack(alignment: .leading){
                        Text("$\(firestoreConnector.purchaseVolume)")
                            .font(.custom("Montserrat-Bold", size: 17))
                        Text("Total Purchases")
                            .font(.custom("Montserrat-Regular", size: 12))
                        
                    }
                }
                
                Spacer()
                HStack{
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.green)
                        .font(.body)
                    
                    VStack(alignment: .leading){
                        Text("\(firestoreConnector.salesArray.count + firestoreConnector.purchaseArray.count )")
                            .font(.custom("Montserrat-Bold", size: 17))
                        Text("Total Deals")
                            .font(.custom("Montserrat-Regular", size: 12))
                        
                    }
                }
            }
        }
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)    .foregroundColor(CustomColor.grayBackground))
            .onAppear{
                
               //  firestoreConnector.fetchAccount {
                
                  //  firestoreConnector.pullSales(SaleID: firestoreConnector.dataToDisplay.sales)
                  //  firestoreConnector.pullPurchases(PurchaseID: firestoreConnector.dataToDisplay.purchases)
    
                  //   }
             
         
            }
    }
}


struct OverAllStatsDemo: View {
    @State var saleArray = [SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.31.2022", deliveryMethod: "ship", image: "dsfkfsfd", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "Sale", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: ""), SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.31.2022", deliveryMethod: "ship", image: "dsfkfsfd", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "Sale", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: "")]
    var body: some View {
        OverAllStats()
    }
}
struct OverAllStats_Previews: PreviewProvider {
    static var previews: some View {
        OverAllStatsDemo()
            .environmentObject(FirebaseConnector())
    }
}
