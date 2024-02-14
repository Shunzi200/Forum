//
//  ThumbnailBar.swift
//  Looper
//
//  Created by Samuel Ridet on 1/20/23.
//

import SwiftUI

struct ThumbnailBarListing: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    let listingData : feedInfo
    @Binding var isEditing: Bool
    @State var isDeleting = false
    
    var body: some View {
        NavigationLink {
            ListingFullViewAccount(listingData: listingData)
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        HStack{
                            HStack (spacing: 0){
                                
                                UrlImageView(urlString: listingData.images[0] as? String ?? "")
                                    .scaledToFill()
                                   
                                    .frame(width: width * 0.2, height: width * 0.2)
                                    .clipShape(Rectangle())
                                    .opacity(listingData.sold ?? false ? 0.5 : 1)
                                    .overlay(content: {
                                        if let sold = listingData.sold {
                                            if sold{
                                                Text("SOLD")
                                                    .font(.custom("Montserrat-Bold", size: 10))
                                                    .foregroundColor(.red)
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 15)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.red, lineWidth: 5)
                                                    )
                                                    .clipShape(
                                                        
                                                        RoundedRectangle(cornerRadius: 10)
                                                    )
                                                
                                                
                                            }
                                        }
                                    })
                                
                                
                            }
                            VStack (alignment: .leading){
                                Text("\(listingData.productName)")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                Text("\(listingData.productSKU)")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                            }
                            Spacer()
                            Text("\(listingData.productSize)\(listingData.productCat)")
                                .font(.custom("Montserrat-Bold", size: 15))
                                .padding(.horizontal)
                            Text("$\(listingData.productPrice)")
                                .font(.custom("Montserrat-Bold", size: 16))
                            
                            
                        }
                        
                    }
                    
                }
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainPurple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 7, height: width * 0.2)
                
            }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
                .overlay(alignment: .topTrailing){
                    if isEditing{
                        Button {
                            isDeleting = true
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                        } label: {
                            Image(systemName: "xmark.square.fill")
                                .font(Font.title3)
                                .foregroundStyle(.white,.red)
                            
                            
                        }.offset(x: 5, y: -5)
                        
                    }
                }.padding(.horizontal, 2).confirmationDialog("Delete?", isPresented: $isDeleting){
                    
                    Button("Delete", role: .destructive){
                        
                        
                        if let index:Int = self.firestoreConnector.listings.firstIndex(where: {$0.id == listingData.id }) {
                            self.firestoreConnector.listings.remove(at: index)
                        }
                        
                        firestoreConnector.deleteDoc(collection: "Posts", doc: listingData.id, images: listingData.Nameimages)
                        
                        
                    }
                } message: {
                    Text("Are you sure you want to delete this post/listing?")
                }
        }

    
    }
}



struct ThumbnailBarBulk: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    let listingData : feedInfo
    @Binding var isEditing: Bool
    @State var isDeleting = false
    
    var body: some View {
        
        NavigationLink {
            BulkFullViewAccount(listingData: listingData)
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        HStack{
                            HStack (spacing: 0){
                                
                                UrlImageView(urlString: listingData.images[0] as? String ?? "")
                                    .scaledToFill()
                                    .frame(width: width * 0.2, height: width * 0.2)
                                    .clipShape(Rectangle())
                                    .opacity(listingData.sold ?? false ? 0.5 : 1)
                                    .overlay(content: {
                                        if let sold = listingData.sold {
                                            if sold{
                                                Text("SOLD")
                                                    .font(.custom("Montserrat-Bold", size: 10))
                                                    .foregroundColor(.red)
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 15)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.red, lineWidth: 5)
                                                    )
                                                    .clipShape(
                                                        
                                                        RoundedRectangle(cornerRadius: 10)
                                                    )
                                                
                                                
                                            }
                                        }
                                    })
                                
                                
                            }
                            VStack (alignment: .leading){
                                Text("\(listingData.productName)")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                
                                Text("\(listingData.productSKU)")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                            }
                            Spacer()
                            Text("\(listingData.productCat) items")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                        
                            Text("$\(listingData.productPrice)")
                                .font(.custom("Montserrat-Bold", size: 16))
                            
                            
                        }
                        
                    }
                    
                }
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainThird]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 7, height: width * 0.2)
                
            }.cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
                .overlay(alignment: .topTrailing){
                    if isEditing{
                        Button {
                            isDeleting = true
                            
                        } label: {
                            Image(systemName: "xmark.square.fill")
                                .font(Font.title3)
                                .foregroundStyle(.white,.red)
                            
                            
                        }.offset(x: 5, y: -5)
                        
                    }
                }.padding(.horizontal, 2).confirmationDialog("Delete?", isPresented: $isDeleting){
                    
                    Button("Delete", role: .destructive){
                        
                        
                        if let index:Int = self.firestoreConnector.listings.firstIndex(where: {$0.id == listingData.id }) {
                            self.firestoreConnector.listings.remove(at: index)
                        }
                        
                        firestoreConnector.deleteDoc(collection: "Posts", doc: listingData.id, images: listingData.Nameimages)
                        
                        
                    }
                } message: {
                    Text("Are you sure you want to delete this post/listing?")
                }
        }
      
    }
}

struct ThumbnailBarListingDemo : View{
    @State var listingData = feedInfo(id: "fdsfs", username: "french_soles", productName: "Jordan 1 High OG Spider-Man Across the Spider-Verse (GS)", productSKU: "DD1391-100", productSize: "7", productCat: "6", productPrice: "300", productCondition: "New", productDelivery: "Ship", city: "Chicago", state: "IL", shipping: "10", time: "242435", postType: "Item", atype: "", caption: "We looped this shit like it was Mickey Ds", likes: [], saves: [], comments: [], images: ["https://firebasestorage.googleapis.com:443/v0/b/forum-development-28d7a.appspot.com/o/images%2F0-5C5334AF-15BA-4039-B906-C572E86C3BA8.jpg?alt=media&token=8850bca2-3425-4d17-b595-07488635dd9f"], userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", bulkSize: [[:]], rating: "4.0", Nameimages: ["0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg"], sold: true)
    
    @State var isEditing = false
    var body: some View {
        VStack {
            ThumbnailBarListing(width: 426, height: 928, listingData: listingData, isEditing: $isEditing)
        }
    }
}

struct ThumbnailBar_Previews: PreviewProvider {
   static var previews: some View {
       ThumbnailBarListingDemo()
          .environmentObject(FirebaseConnector())
 }
}



