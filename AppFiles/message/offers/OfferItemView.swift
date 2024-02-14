//
//  OfferItemView.swift
//  Looper
//
//  Created by Samuel Ridet on 12/18/22.
//

import SwiftUI

struct OfferItemView: View {
    @State var listingId: String
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var offerAr : [offer]
    @State var c = CustomColor.orange
    var width: CGFloat
    var height: CGFloat
    @Binding var offerMainAr : [OList]
    
    @Binding var offerSelect : Bool
    @State var showingOffers = false
    
    @State var showFullView = false
    @Binding var option : Int
    var body: some View {
  
        VStack {
            HStack {
                HStack{
                    UrlImageView(urlString: firestoreConnector.currentPost.images.first as? String ?? "")
                        .scaledToFill()
                        .frame(width: width * 0.2, height: width * 0.2)
                        .clipShape(Rectangle())
                        .onTapGesture {
                            self.showFullView.toggle()
                        }
                    
                    VStack (alignment: .leading){
                        Text("\(firestoreConnector.currentPost.productName)")
                            .font(.custom("Montserrat-Bold", size: 15))
                            .lineLimit(2)
                        if firestoreConnector.currentPost.postType == "Item"{
                            Text("\(firestoreConnector.currentPost.productSize)\(firestoreConnector.currentPost.productCat)")
                                .font(.custom("Montserrat-Bold", size: 12))
                        }else{
                            Text("\(firestoreConnector.currentPost.productCat) items")
                                .font(.custom("Montserrat-Bold", size: 12))
                            
                        }
                        
                        Text("\(firestoreConnector.currentPost.productSKU)")
                            .font(.custom("Montserrat-Regular", size: 12))
                        
                         
                        
                    }
                    
                    
                    Text("$\(firestoreConnector.currentPost.productPrice)")
                        .font(.custom("Montserrat-Bold", size: 16))
                        .padding(.horizontal, 5)
                    Spacer()
                    Button {
                        self.showingOffers.toggle()
                    } label: {
                        Image(systemName: showingOffers ? "arrow.up" : "arrow.down")
                            .resizable()
                            .foregroundColor(.white)
                        
                            .frame(width: width * 0.04, height: width * 0.04)
                            .padding()
                    }
                    
                }
                Spacer()
                Rectangle()
                    .fill(firestoreConnector.currentPost.postType == "Item" ? CustomColor.mainPurple : CustomColor.mainThird)
                    .frame(width: 7, height: width * 0.2)
                
                
            }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10)
                                          
            .foregroundColor(CustomColor.grayBackground))
            
                .onAppear{
                firestoreConnector.PullPost(postID: listingId)
                }
                
                .sheet(isPresented: $showFullView) {
                    if firestoreConnector.currentPost.postType == "Item"{
                        ProductAccountView(listingData: firestoreConnector.currentPost)
                    }else{
                        BulkAccountView(listingData: firestoreConnector.currentPost)
                    }
            }
            
            
            if showingOffers{
                VStack(spacing: 5){
                    ForEach(offerAr){off in
                        Offer(Off: off, width: width,height: height, offerMainAr: $offerMainAr, offerAr: $offerAr, offerSelect: $offerSelect, listingName: firestoreConnector.currentPost.productName, option: $option)
            
                        
                        
                    }
                }
            }
            
            
        }
        
    }
}


struct dem: View{
    @State var listingId = "19554142-4345-4379-A477-35081A390475"
    @State var Off  = offer(id: "fsfsfs", ownerID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", offerPrice: "400", listingID: "sdfsfds", date: "sdgffd", status: "Pending")
    @State var offMainAr = [OList(id: "", offers: [])]
    @State var offerSelect = true
    @State var option = 0
    var body: some View{
        OfferItemView(listingId: listingId, offerAr: [Off], width: 428, height: 926, offerMainAr: $offMainAr, offerSelect: $offerSelect, option: $option)
        
    }
}
struct OfferItemView_Previews: PreviewProvider {
    static var previews: some View {
        dem()
            .environmentObject(FirebaseConnector())
    }
}
