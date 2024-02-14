//
//  FullViewResult.swift
//  Looper
//
//  Created by Samuel Ridet on 1/30/23.
//

import SwiftUI

struct FullViewResult: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    
    
    @State var prod : JSONItem?
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
    
    var body: some View {
        GeometryReader {geometry in
            

                VStack{
                if firestoreConnector.queriedSKU.count == 0{
                    Spacer()
                    HStack {
                        Spacer()
                        Text("No listings have been posted\n        for this product yet.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                        Spacer()
                    }
                    Spacer()
                    
                }else{
                    ScrollView(showsIndicators: false){
                        VStack (spacing: 5){
                            Spacer(minLength: 45)
                            ForEach(firestoreConnector.filterqueriedSKU){item in
                                if item.postType == "Item"{
                              
                                        SearchOfferListing(listing: item, w: geometry.size.width, h: geometry.size.height)
                                        
                                            .padding(.horizontal,10)
                                  
                                    
                                }else if item.postType == "Bulk"{
                                   
                                        SearchOfferBulk(listing: item, w: geometry.size.width, h: geometry.size.height)
                                        
                                            .padding(.horizontal,10)
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                }
                    
                }
                .onAppear{
                    
                    firestoreConnector.queryItem(sku: (prod?.styleID ?? ""))
                    tapCount = 0
      
                    
                }.navigationBarItems(leading: HStack{
                    UrlImageView(urlString: prod?.thumbnail ?? " " )
                        .frame(width: geometry.size.width * 0.12, height: geometry.size.width * 0.12)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    VStack(alignment: .leading){
                        
                        Text(String(prod?.shoeName ?? ""))
                            .font(.custom("Montserrat-Bold", size: 15))
                            .lineLimit(2)
                        Text("\(prod?.styleID ?? "")")
                            .font(.custom("Montserrat-Regular", size: 13))
                            .lineLimit(1)

                    }}
                    .padding(.vertical, 10))
                .sheet(isPresented: $showFilter) {
                    FilterPage(itemSelect: $itemSelect, bulkSelect: $bulkSelect, newSelect: $newSelect, usedSelect: $usedSelect, shipSelect: $shipSelect, localSelect: $localSelect, minSelect: $minSelect, maxSelect: $maxSelect, descending: $descending)
                        .onDisappear{
                            firestoreConnector.filterQuery(itemSelect: itemSelect, bulkSelect: bulkSelect, newSelect: newSelect, usedSelect: usedSelect, shipSelect: shipSelect, localSelect: localSelect, minSelect: minSelect, maxSelect: maxSelect, descending: descending)
                        }
            }
                HStack{
                    Button {
                        self.tapCount += 1
                        switch self.tapCount % 4 {
                        case 0:
                            self.sortText = "Date"
                            self.up = false
                            
                            firestoreConnector.filterqueriedSKU = firestoreConnector.filterqueriedSKU.sorted(by: {
                                $0.time < $1.time})
                            
                        case 1:
                            self.sortText = "Date"
                            self.up = true
                            
                            firestoreConnector.filterqueriedSKU = firestoreConnector.filterqueriedSKU.sorted(by: {
                                $0.time > $1.time})
                        case 2:
                            self.sortText = "Price"
                            self.up = false
                            firestoreConnector.filterqueriedSKU = firestoreConnector.filterqueriedSKU.sorted(by: {
                                Double($0.productPrice) ?? 0 < Double($1.productPrice) ?? 0
                            })
                        case 3:
                            self.sortText = "Price"
                            self.up = true
                            firestoreConnector.filterqueriedSKU = firestoreConnector.filterqueriedSKU.sorted(by: {
                                Double($0.productPrice) ?? 0 > Double($1.productPrice) ?? 0
                            })

                        default:
                            self.sortText = "Date"
                            self.up = false
                            
                            firestoreConnector.filterqueriedSKU = firestoreConnector.filterqueriedSKU.sorted(by: {
                                $0.time < $1.time})
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
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.mainBlack))
                        .padding(.horizontal)
                    Spacer()
                    Button {
                        self.showFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill").foregroundStyle(.black, .white)
                            .font(.title2)
                    }.padding(5)
                    
                }
            
        }
    }
}


struct FullViewResultDemo : View{
    @State var prod = JSONItem(shoeName: "Jordan 1 High OG Spider-Man Across the Spider-Verse (GS)", brand: "Jordan", silhouette: "", styleID: "DO7097-100", colorway: "White", thumbnail: "https://images.stockx.com/images/UGG-Classic-Mini-Lace-Up-Weather-Boot-Dune.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1636503608", releaseDate: "", description: "", urlKey: "")

    
    var body: some View{
        NavigationView {
            FullViewResult(prod: prod)
        }
    }
}

struct FullViewResult_Previews: PreviewProvider {
    static var previews: some View {
        FullViewResultDemo()
            .environmentObject(FirebaseConnector())
    }
}

