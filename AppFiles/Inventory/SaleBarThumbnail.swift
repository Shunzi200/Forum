//
//  SaleBarThumbnail.swift
//  Looper
//
//  Created by Samuel Ridet on 12/30/22.
//

import SwiftUI

struct SaleBarThumbnail: View {
   
    @State var showSale = false
    var width : CGFloat
    var height : CGFloat
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var Sale : SaleStruct
    @State var days = 0
    var body: some View {
        VStack {
          
            HStack{
                UrlImageView(urlString: Sale.image)
                    .scaledToFill()
                    .frame(width: width * 0.2, height: width * 0.2)
                    .clipShape(Rectangle())
                   
                   
                VStack(alignment: .leading){
                    Text("\(Sale.name)")
                        .font(.custom("Montserrat-Bold", size: 15))
                        .lineLimit(2)
                    
                    if Sale.size != ""{
                        Text("\(Sale.size)\(Sale.category)")
                        .font(.custom("Montserrat-Regular", size: 12))
                    }else{
                        Text("\(Sale.category) items")
                            .font(.custom("Montserrat-Regular", size: 12))
                    }
                    
                }
                  
                
                
                
                Spacer()
                Text("\(days)d")
                    .font(.custom("Montserrat-Bold", size: 14))
                Spacer()
                Text("$\(Sale.price)")
                    .font(.custom("Montserrat-Bold", size: 16))
                
                Spacer()
                Rectangle()
                    .foregroundColor(Sale.size == "" ? CustomColor.mainThird : CustomColor.mainPurple)
                    .frame(width: 7, height: width * 0.2)
              
                
            }    .cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground)).onTapGesture {
                self.showSale.toggle()
                
            }.sheet(isPresented: $showSale) {
                if Sale.type == "Purchase"{
                    PurchaseDetail(Sale: Sale)
                }else{
                    SaleDetail(Sale: Sale)
                }
               
            }
            
            
        }     .padding(.horizontal, 2).onAppear{
            
            let givenDateString = Sale.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy"
            
            let givenDate = dateFormatter.date(from: givenDateString)!
            let today = Date()
            
            let calendar = Calendar.current
            let days = calendar.dateComponents([.day], from: givenDate, to: today)
            
            if let days = days.day {
                self.days = days
            }
            
        }
    }
}

struct SaleBarThumbnailDemo : View{
    var body: some View{
        SaleBarThumbnail(width: 428, height: 926, Sale: SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.24.2022", deliveryMethod: "ship", image: "https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/sales%2F0BC54282-8612-422C-82A3-8978D5901DB0.jpg?alt=media&token=288ba9b2-8b5e-4fde-b49f-31e95d8f7db4", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "purchase", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: ""))
    }
}
struct SaleBarThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        SaleBarThumbnailDemo()
    }
}
