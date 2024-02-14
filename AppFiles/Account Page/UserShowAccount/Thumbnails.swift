    //
    //  Thumbnails.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 10/23/22.
    //

import SwiftUI



struct ListingThumbnailAccountView: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    @State var listingData : feedInfo
    @State var showFullView = false
    @State var typeview : Bool
    
    var body: some View {
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
            .padding(.horizontal, 2).onTapGesture {
                    self.showFullView.toggle()
                }
                .popover(isPresented: $showFullView) {
                    if typeview{
                        ProductView(listingData: $listingData)
                    }else{
                        ProductAccountView(listingData: listingData)
                    }
                }

        
    }
}

struct BulkThumbnailAccountView: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    @State var listingData : feedInfo
    @State var showFullView = false
    @State var typeview : Bool
    
    var body: some View {

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
            .padding(.horizontal, 2).onTapGesture {
                    self.showFullView.toggle()
                }
                .popover(isPresented: $showFullView) {
                    if typeview{
                        BulkProdView(listingData: $listingData)
                    }else{
                        BulkAccountView(listingData: listingData)
                    }
                }
    
        
    }
}

struct PostThumbnailAccountView: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    let width: CGFloat
    let height: CGFloat
    @State var postsData : feedInfo
    
    var localShow = false
    @State var showProduct : Bool = false
    @State var image = "imagePlaceHolder"

    @State var showFullView = false
    @State var typeview : Bool
    var body: some View {
        
        let imageName = postsData.images as? [String] ?? [""]
        


              
            UrlImageView(urlString: imageName[0])
                .scaledToFill()
                .frame(width: width, height: width)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    showFullView.toggle()
                }
    
         
                
                
                
                
                .popover(isPresented: $showFullView) {
                    if typeview{
                        PostView(listingData: $postsData)
                    }else{
                        PostAccountView(listingData: postsData)
                    }
                }
                
              
                
                
            
            
            
        }
        
        
        
    }
            
            

