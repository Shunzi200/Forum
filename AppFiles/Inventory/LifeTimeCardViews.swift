//
//  LifeTimeCardViews.swift
//  Looper
//
//  Created by Samuel Ridet on 12/28/22.
//

import SwiftUI

struct UserCardView: View {
    @State var userID : String
    @State var showAccount = false
    @State var showPurchase = false
    @State var showSale = false
    var width : CGFloat
    var height : CGFloat
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var Sale : SaleStruct
    @State var days = 0
    var body: some View {
        VStack {
        
            HStack{
                UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic )
                    .scaledToFill()
                    .frame(width: width * 0.12, height: width * 0.12)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    .onTapGesture {
                        self.showAccount.toggle()
                    }
                VStack(alignment: .leading){
                    Text("\(firestoreConnector.viewdataToDisplay.username)")
                        .font(.custom("Montserrat-SemiBold", size: 14))
                        .lineLimit(1)
                    Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                        .font(.custom("Montserrat-Regular", size: 13))
                }
                    .onTapGesture {
                        self.showAccount.toggle()
                    }
                
               
         
                Spacer()
                Text("\(days)d")
                    .font(.custom("Montserrat-Bold", size: 13))
                Spacer()
                if Sale.type == "Purchase"{
                    Image(systemName: "cart.fill")
                        .foregroundColor(CustomColor.mainPurple)
                        .font(.title2)
                        .onTapGesture {
                            self.showPurchase.toggle()
                        }
                }else{
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                        .onTapGesture {
                            self.showSale.toggle()
                        }
                }
                
            }.sheet(isPresented: $showAccount) {
                ViewUserAccount(userID: userID)
            }.sheet(isPresented: $showSale) {
                SaleDetail(Sale: Sale)
            }.sheet(isPresented: $showPurchase) {
                PurchaseDetail(Sale: Sale)
            }
            
            
        }.onAppear{
            firestoreConnector.fetchViewAccount(userID: userID)
        
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

struct RecentSale : View{

    @State var showDetail = false
    var width : CGFloat
    var height : CGFloat
    @State var Sale : SaleStruct
    @State var days = 0
    var body: some View{
            VStack{
                VStack (spacing: 0 ) {
                    UrlImageView(urlString: Sale.image )
                    .scaledToFill()
                    .frame(width: width / 2.5, height: width / 3)
                    .clipShape(Rectangle())
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Sale.size == "" ? CustomColor.mainThird : CustomColor.mainPurple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 4)
                }
   
                VStack {
                    Text("\(Sale.name)")
                        .font(.custom("Montserrat-Bold", size: 15))
                        .lineLimit(2)
                    HStack {
                        Text("$\(Sale.price),")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                            .lineLimit(1)
                        Text("\(days)d ago")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                            .lineLimit(1)
                    }
                }.padding(.bottom, 5)
                    .padding(.horizontal, 5)
                    
               
         
                
            }.cornerRadius(15).background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            
            .onTapGesture {
                self.showDetail.toggle()
            }.sheet(isPresented: $showDetail) {
                SaleDetail(Sale: Sale)
            }
            
            
       .onAppear{

            
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

struct UserCardViewDemo: View {
    @State var userID = "M17K7nYafvPjwJqDsyEwDAX4UCy1"
    var body: some View {
        UserCardView(userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", width: 428, height: 926, Sale: SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.24.2022", deliveryMethod: "ship", image: "https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/sales%2F0BC54282-8612-422C-82A3-8978D5901DB0.jpg?alt=media&token=288ba9b2-8b5e-4fde-b49f-31e95d8f7db4", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "purchase", otherUserID: "fsdfsdlkjfs", condition: "New", timestamp: "fdghd", listingID: ""))
        //RecentSale(width: 428, height: 926, Sale: SaleStruct(id: "", address: "Address", boughtPrice: "200", buyer: "shunzi", category: "M", date: "12.24.2022", deliveryMethod: "ship", image: "https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/sales%2F0BC54282-8612-422C-82A3-8978D5901DB0.jpg?alt=media&token=288ba9b2-8b5e-4fde-b49f-31e95d8f7db4", payment: "zelle", price: "400", name: "Jordan 1 Retro", size: "9", sizeList: [[:]], sku: "DHGE-502", tracking: "DSHKJHIOWN78883", type: "purchase", otherUserID: "fsdfsdlkjfs"))
    }
}

struct LifeTimeCardViews_Previews: PreviewProvider {
    static var previews: some View {
        UserCardViewDemo()
            .environmentObject(FirebaseConnector())
    }
}
