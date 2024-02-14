//
//  PurchasePage.swift
//  Looper
//
//  Created by Samuel Ridet on 12/30/22.
//

import SwiftUI

struct PurchasePage: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @State var showFilter = false
    
    @State var itemSelect = true
    @State var bulkSelect = true
    @State var newSelect = true
    @State var usedSelect = true
    @State var shipSelect = true
    @State var localSelect = true
    @State var minSelect = ""
    @State var maxSelect = ""
    @State var descending = true
    
    @State var sortText = "Date"
    @State var up = false
    @State var tapCount = 0
    @State var showConfirmation = false
    
    var body: some View {
        GeometryReader{geometry in
            ZStack (alignment: .top){
                if firestoreConnector.filterpurchaseArray.count  == 0 {
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("No recent purchases")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }
                        Spacer()
                    }
                }else{
                    ScrollView(showsIndicators: false){
                        VStack{
                            Spacer(minLength: 45)
                            ForEach(firestoreConnector.filterpurchaseArray){sale in
                                SaleBarThumbnail(width: geometry.size.width, height: geometry.size.height, Sale: sale)
                                    .padding(.horizontal)
                            }
                        }
                        Spacer(minLength: 10)
                    }.refreshable {
                        firestoreConnector.fetchAccount {
                            firestoreConnector.pullPurchases(PurchaseID:  firestoreConnector.dataToDisplay.purchases)
                        }
                    }
                }
                HStack{
                    Button {
                        self.tapCount += 1
                        switch self.tapCount % 4 {
                        case 0:
                            self.sortText = "Date"
                            self.up = false
                            
                            firestoreConnector.filterpurchaseArray = firestoreConnector.filterpurchaseArray.sorted(by: {
                                $0.timestamp > $1.timestamp})
                            
                        case 1:
                            self.sortText = "Date"
                            self.up = true
                            
                            firestoreConnector.filterpurchaseArray = firestoreConnector.filterpurchaseArray.sorted(by: {
                                $0.timestamp < $1.timestamp})
                        case 2:
                            self.sortText = "Price"
                            self.up = false
                            
                            firestoreConnector.filterpurchaseArray = firestoreConnector.filterpurchaseArray.sorted(by: {
                                Double($0.price) ?? 0 < Double($1.price) ?? 0})
                        case 3:
                            self.sortText = "Price"
                            self.up = true
                            firestoreConnector.filterpurchaseArray = firestoreConnector.filterpurchaseArray.sorted(by: {
                                Double($0.price) ?? 0 > Double($1.price) ?? 0})
                        default:
                            self.sortText = "Date"
                            self.up = false
                            
                            firestoreConnector.filterpurchaseArray = firestoreConnector.filterpurchaseArray.sorted(by: {
                                $0.timestamp > $1.timestamp})
                        }
                    } label: {
                        HStack {
                            Image(systemName: up ? "arrow.up" : "arrow.down")
                                .font(.caption)
                                .foregroundColor(.white)
                            Text("\(sortText)")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                .foregroundColor(.white)
                        }
                    }.padding(7)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
                        .padding(.horizontal)
             
                    Button {
                        self.showFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill").foregroundStyle(.black, .white)
                            .font(.title2)
                    }.padding(5)
                    
                    Spacer()
                    NavigationLink {
                        purchaseItemSelection(showConfirmation: $showConfirmation)
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(5)
                    }
                    
                }
            }.opacity(showConfirmation ? 0.6 : 1).overlay{
                if showConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Log Successful", bodytext: "This item was logged successfully in your dashboard.", showConfirmation: $showConfirmation)
                }
            }.onAppear{
       
                tapCount = 0
            }.sheet(isPresented: $showFilter) {
                FilterPage(itemSelect: $itemSelect, bulkSelect: $bulkSelect, newSelect: $newSelect, usedSelect: $usedSelect, shipSelect: $shipSelect, localSelect: $localSelect, minSelect: $minSelect, maxSelect: $maxSelect, descending: $descending)
                    .onDisappear{
                        firestoreConnector.filterSale(Sales: false, itemSelect: itemSelect, bulkSelect: bulkSelect, newSelect: newSelect, usedSelect: usedSelect, shipSelect: shipSelect, localSelect: localSelect, minSelect: minSelect, maxSelect: maxSelect, descending: descending)
                    }
            }
        }
        
    }
}

struct PurchasePage_Previews: PreviewProvider {
    static var previews: some View {
        PurchasePage()
            .environmentObject(FirebaseConnector())
    }
}
