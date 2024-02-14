//
//  SearchResultsStruct.swift
//  Looper
//
//  Created by Samuel Ridet on 12/13/22.
//

import SwiftUI

struct SearchResultsStruct: View {
    @StateObject var firestoreConnector = FirebaseConnector()
   
    
    @State var prod : JSONItem?
    @State var showingItems = false
    @State var active = false
    
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        
        NavigationLink(destination: FullViewResult(prod: prod), isActive: $active) {
            
            
            Button {
                active.toggle()
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            } label: {
                
                VStack{
                    
                    HStack{
                        UrlImageView(urlString: prod?.thumbnail ?? "" == "https://stockx-assets.imgix.net/media/Product-Placeholder-Default-20210415.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=0" ? "https://www.macmillandictionary.com/external/slideshow/full/White_full.png" : prod?.thumbnail ?? "" )
                            .scaledToFit()
                            .frame(width: width / 4.5)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        VStack(alignment: .leading){
                            
                            Text("\(prod?.shoeName ?? "" )")
                                .font(.custom("Montserrat-Bold", size: 15))
                                .multilineTextAlignment(.leading)
                                .lineLimit(4)
                            Text("\(prod?.styleID ?? "")")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    
                }.padding(.horizontal, 2)
            }

        }
         
        
    }
}

struct SearchOfferListing: View{
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var listing : feedInfo
    @State var showingPopover = false
    
    var w: CGFloat
    var h: CGFloat
    
    
    var body: some View{
        
        
        HStack{
            VStack(alignment: .leading) {
                    HStack{
                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: w * 0.1, height: w * 0.1)
                        
                        
                        VStack(alignment: .leading) {
                            Text("\(listing.username)")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                .font(.custom("Montserrat-Regular", size: 15))
                            
                        }
                        Spacer()
                        Text("\(listing.productSize)\(listing.productCat)")
                            .font(.custom("Montserrat-Bold", size: 15))
                            .padding(.horizontal)
                        Text("$\(listing.productPrice)")
                            .font(.custom("Montserrat-Bold", size: 16))
                        
                        
                    }.padding(.horizontal, 5)

                
            }
            Spacer()
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainPurple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 7, height: w * 0.2)
            
        }
        .cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).padding(.horizontal, 2).foregroundColor(CustomColor.grayBackground))
            .onTapGesture {
                showingPopover.toggle()
            }
            .sheet(isPresented: $showingPopover) {
                ProductView(listingData: $listing)
            }.onAppear{
                firestoreConnector.fetchViewAccount(userID: listing.userID)
            }
            
        
    }
}


struct SearchOfferBulk: View{
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var listing : feedInfo

    @State var showingPopover = false
    
    var w: CGFloat
    var h: CGFloat
    
    
    var body: some View{
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    HStack{
                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: w * 0.1, height: w * 0.1)
                        
                        
                        VStack(alignment: .leading) {
                            Text("\(listing.username)")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                .font(.custom("Montserrat-Regular", size: 15))
                            
                        }
                        Spacer()
                        Text("\(listing.productCat) items")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                        Text("$\(listing.productPrice)")
                            .font(.custom("Montserrat-Bold", size: 16))
                        
                    }
                }.padding(.horizontal, 5)
            }

            Spacer()
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainThird]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 7, height: w * 0.2)
            
        }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).padding(.horizontal, 2).foregroundColor(CustomColor.grayBackground))
      
        .onTapGesture {
            showingPopover.toggle()
        }
        .sheet(isPresented: $showingPopover) {
            BulkProdView(listingData: $listing)
        }.onAppear{
            firestoreConnector.fetchViewAccount(userID: listing.userID)
        }
        
        
    }
}


struct Demo1 : View{
    @State var prod = JSONItem(shoeName: "Jordan 1 High OG Spider-Man Across the Spider-Verse (GS)", brand: "", silhouette: "", styleID: "DO7097-100", colorway: "", thumbnail: "https://images.stockx.com/images/UGG-Classic-Mini-Lace-Up-Weather-Boot-Dune.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1636503608" , releaseDate: "", description: "", urlKey: "")
    
    
    
    @State var listing = feedInfo(id: "ZoLGDkr86AbkOsf5GgruZtdefc23", username: "french_soles", productName: "Jordan 1 Volt", productSKU: "DHJSA-334", productSize:"" , productCat: "9", productPrice: "2350", productCondition: "New", productDelivery: "Both", city: "Chicago", state: "IL", shipping: "15", time: "3458235290375", postType: " ", atype: " ", caption: "Loopin like we like it", likes: [], saves: [], comments: [], images: ["https://images.stockx.com/images/UGG-Classic-Mini-Lace-Up-Weather-Boot-Dune.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1636503608"], userID: " gfh", bulkSize: [["size": "9", "category": "M", "quantity": "2", "price": "200"], ["size": "11", "category": "M", "quantity": "2", "price": "200"]], rating: "", Nameimages: [])
  
    
    var body: some View{
        SearchResultsStruct(prod: prod, width: 428, height: 926)
     //   SearchOfferBulk(listing: listing, w: 428, h: 926)
       
        
    }
}


struct SearchResultsStruct_Previews: PreviewProvider {
    static var previews: some View {
        Demo1()
            .environmentObject(FirebaseConnector())
    }
}
