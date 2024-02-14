    //
    //  ProductView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/15/22.
    //

import SwiftUI

struct ProductPreview: View {
    
    @State var listingData : feedInfo
    @State var liked = false
    @State var saved = false
        // let images = "placeHolder"
    
    
    var body: some View {
        
        let username = listingData.username
        let city = listingData.city
        let state = listingData.state
        let productDelivery = listingData.productDelivery
        let location =  "\(city), \(state)"
        let shipping = "$\(listingData.shipping)"
        let itemName =  listingData.productName
        let itemSize = "\(listingData.productSize)\(listingData.productCat)"
        let itemSKU =  listingData.productSKU
        let itemPrice =  "$\(listingData.productPrice)"
        let imageplace : UIImage = UIImage(named: "imagePlaceHolder")!
        let arrayplace : [UIImage] = [imageplace]
        let images : [UIImage] = listingData.images as? [UIImage] ?? arrayplace
        GeometryReader { geometry in
            VStack {
                TabView {
                    ForEach (images, id: \.self) {image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }
                .aspectRatio(CGSize(width: 2, height: 1.7), contentMode: .fit)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(itemName)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .lineLimit(3)
                        HStack {
                            Text(itemSKU+",")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(itemSize)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text(itemPrice)
                                .font(.title)
                                .bold()
                        }
                        
                        if (productDelivery == "Both"){
                            Text("\(username.uppercased()),  \(location.uppercased()),  \(shipping) SHIPPING")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding([.bottom])
                        }else if (productDelivery == "Ship"){
                            Text("\(username.uppercased()), \(shipping) SHIPPING")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding([.bottom])
                        }else if (productDelivery == "Local"){
                            Text("\(username.uppercased()),  \(location.uppercased())")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding([.bottom])
                        }
                        
                        HStack {
                            
                            Button {
                                self.liked.toggle()
                            } label: {
                                Image(systemName: liked ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.08)
                                    .foregroundColor(.white)
                                    .padding([.leading], 20)
                            }
                            
                            
                            Spacer()
                            
                            Button {
                                self.saved.toggle()
                            } label: {
                                Image(systemName: saved ? "bookmark.fill" : "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.06)
                                    .foregroundColor(.white)
                                
                            }
                            Spacer()
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "message")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.07)
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                    Text("Message")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.title3)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.white)
                                )
                                .padding([.leading],20)
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding([.bottom, .leading, .trailing])
                Spacer()
                
                
            }
            .cornerRadius(10)
        }
        
        
    }
    
}

struct PostPreview: View {
    @State var listingData : feedInfo
    @State var liked = false
    @State var saved = false
    
    @State var saves = 0
    @State var likes = 0
    
    
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    
    var body: some View {
        let accountData = firestoreConnector.dataToDisplay
        let username = listingData.username
        let caption = listingData.caption
        let rating = accountData.rating
        let imageplace : UIImage = UIImage(named: "imagePlaceHolder")!
        let arrayplace : [UIImage] = [imageplace]
        let images : [UIImage] = listingData.images as? [UIImage] ?? arrayplace
        
        
        GeometryReader { geometry in
            VStack {
                TabView {
                    ForEach (images, id: \.self) {image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }
                .aspectRatio(CGSize(width: 2, height: 1.7), contentMode: .fit)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(username), ")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(rating)
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                            Spacer()
                            
                        }
                        .padding([.top], 5)
                        
                        Text("\(caption) ")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding([.bottom, .top], 3)
                        
                        
                        HStack {
                            
                            Button {
                                
                                self.liked.toggle()
                                /*
                                 if liked == false{
                                 self.likes = self.likes - 1
                                 print("removing like")
                                 firestoreConnector.EditSaveLike(postID: listingData.id, field: "likes", value: self.likes)
                                 }else if liked == true{
                                 print("print adding like")
                                 self.likes = self.likes + 1
                                 firestoreConnector.EditSaveLike(postID: listingData.id, field: "likes", value: self.likes)
                                 }
                                 */
                                
                            } label: {
                                VStack(alignment: .center){
                                    Image(systemName: liked ? "heart.fill" : "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.08)
                                        .foregroundColor(.white)
                                    
                                    Text("\(self.likes)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }        .padding([.leading], 20)
                            }
                            
                            
                            Spacer()
                            
                            Button {
                                self.saved.toggle()
                                /*
                                 
                                 
                                 if saved == false{
                                 self.saves = self.saves - 1
                                 
                                 firestoreConnector.EditSaveLike(postID: listingData.id, field: "saves", value: self.saves)
                                 }else if saved == true{
                                 
                                 self.saves = self.saves + 1
                                 
                                 firestoreConnector.EditSaveLike(postID: listingData.id, field: "saves", value: self.saves)
                                 }
                                 */
                            } label: {
                                VStack(alignment: .center){
                                    Image(systemName: saved ? "bookmark.fill" : "bookmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.06)
                                        .foregroundColor(.white)
                                    Text("\(self.saves)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    
                                }
                                
                            }
                            
                            Spacer()
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "message")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.07)
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                    Text("Message")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.title3)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.white)
                                )
                                .padding([.leading],20)
                            }
                            
                            
                            
                            
                        }
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding([.bottom, .leading, .trailing])
                Spacer()
                
                
            }
            .cornerRadius(10)
        }
        
        
    }
    
}
struct demo213: View {
    var username: String = "French"
    @State var listingInfo = feedInfo(id: "dgfsdgs", username: "french_soles", productName: "Jordan 1 Volt", productSKU: "DHJSA-334", productSize: "9", productCat: "M", productPrice: "230", productCondition: "New", productDelivery: "Both", city: "Chicago", state: "IL", shipping: "15", time: "3458235290375", postType: " ", atype: " ", caption: "Loopin like we like it", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [[:]], rating: "", Nameimages: [])
    var body: some View {
        PostView(listingData: $listingInfo)
            .environmentObject(FirebaseConnector())
    }
}
struct ProductPreview_Previews: PreviewProvider {
    static var previews: some View {
        demo213()
            .environmentObject(FirebaseConnector())
    }
}
