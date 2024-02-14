    //
    //  Posts.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/15/22.
    //

import SwiftUI

struct Listing: View {
    
    @State var feedData : feedInfo
    @State var showDetail = false
    @StateObject var firestoreConnector = FirebaseConnector()
    
    var body: some View {
        let username = feedData.username

        let itemName =  feedData.productName
        let itemPrice =  "$\(feedData.productPrice)"
        let imageName : [String] = feedData.images as? [String] ?? [""]
        
        ZStack{
            VStack {
              
                VStack(spacing: 0) {
                    TabView {
                                ForEach(imageName, id: \.self){im in
                             
                                    UrlImageView(urlString: im)
                                    
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        
                                }
                    }.opacity(feedData.sold ?? false ? 0.5 : 1)
                        .overlay(content: {
                        if let sold = feedData.sold {
                            if sold{
                                Text("SOLD")
                                    .font(.custom("Montserrat-Bold", size: 30))
                                    .foregroundColor(.red)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 45)
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
                                
                                .aspectRatio(CGSize(width: 7, height: 5), contentMode: .fit)
                                .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    Rectangle()
                    
                        .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainPurple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 4)
                }.onAppear{
                    firestoreConnector.fetchViewAccount(userID: feedData.userID)
                }

                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                                Text(itemName)
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                            HStack (alignment: .top){
                                    UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
                                
                                    
                                VStack(alignment: .leading) {
                                        Text("\(username)")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                        Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                            .font(.custom("Montserrat-Regular", size: 15))

                                    }
                                    .padding(.horizontal, 5)
                                    Spacer()
                                VStack(alignment: .trailing) {
                                    Text(itemPrice)
                                        .foregroundColor(.white)
                                        .font(.custom("Montserrat-Bold", size: 20))
                                        .lineLimit(1)
                                    HStack {
                                        Text("\(feedData.productSize)\(feedData.productCat)")
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                        Text("(\(feedData.productCondition))")
                                            .font(.custom("Montserrat-SemiBoldItalic", size: 12))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        
                                    }
                                }
                                }
                               
                                
                               
                            }
                            .layoutPriority(100)
                            
                            Spacer()
                        }
                        
                    .padding([.bottom, .leading, .trailing])
                }
                }
                .cornerRadius(10)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(CustomColor.grayBackground))
                .padding([.top, .horizontal])
                .onTapGesture {
                    self.showDetail.toggle()
                    
                    
                }
            
                .sheet(isPresented: $showDetail) {
                    
                    ProductView(listingData: $feedData)
                }
                


        }
    }
    
    struct Post: View {
        @State var feedData : feedInfo
        @State var showDetail = false
        @State var liked = false
        @State var saved = false

        @StateObject var firestoreConnector = FirebaseConnector()
        
        @State var currentPost = feedInfo(id: "dgfsdgs", username: "", productName: " 1 Volt", productSKU: "-", productSize: "", productCat: "", productPrice: "", productCondition: "", productDelivery: "", city: "", state: "", shipping: "", time: "", postType: " ", atype: " ", caption: "", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [[:]], rating: "", Nameimages: [])
        
        var body: some View {
            let userID = firestoreConnector.dataToDisplay.userID
            let username = feedData.username
            let caption = feedData.caption
            let imageName : [String] = feedData.images as? [String] ?? [""]
            
            VStack {
                VStack(spacing: 0) {
                    TabView {
                        ForEach(imageName, id: \.self){im in
                            
                            UrlImageView(urlString: im)
                         
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    
                    .aspectRatio(CGSize(width: 7, height: 5), contentMode: .fit)
                    .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onAppear{
                    
                    firestoreConnector.fetchAccount {
                        if firestoreConnector.dataToDisplay.liked.contains(feedData.id){
                            self.liked = true
                            print("liked")
                        }
                        
                        if firestoreConnector.dataToDisplay.saved.contains(feedData.id){
                            self.saved = true
                            print("saved")
                        }
                    }
           
                
                    
                firestoreConnector.fetchViewAccount(userID: feedData.userID)
           
                 
                }
                    
                    Rectangle()
                    
                        .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainBlue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 4)
                }
      
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\"\(caption)\"")
                            .foregroundColor(.white)
                            .font(.custom("Montserrat-SemiBoldItalic", size: 15))
                            .lineLimit(3)
                        HStack {
                            UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading) {
                                Text("\(username)")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                    .font(.custom("Montserrat-Regular", size: 15))
                                
                            }
                            .padding(.horizontal, 5)
                            
                            
                                Spacer()
                            VStack {
                                Button {
                                    if feedData.likes.contains(userID){
                                        print("Unliking")
                                        firestoreConnector.UnlikePost(postData: feedData)
                                        feedData.likes.removeAll { $0 == userID }
                                    }else{
                                        print("Liking")
                                        firestoreConnector.LikePost(postData: feedData)
                                        feedData.likes.append(userID)
                                    }
                                    self.liked.toggle()
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                        
                                    } label: {
                                        Image(systemName: feedData.likes.contains(userID) ? "heart.fill" : "heart")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                            .foregroundColor(feedData.likes.contains(userID) ? .red : .white)
                                            
                                }
                                    
                                Text("\(feedData.likes.count)")
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                
                                
                            }.padding(.horizontal, 5)

                                
    
                            
                        }
                      

                    }
                    .layoutPriority(100)
                    
             
                }
                
                .padding([.bottom, .leading, .trailing])
            }
            .cornerRadius(10)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(CustomColor.grayBackground))
            .padding([.top, .horizontal])
            .onTapGesture {
                self.showDetail.toggle()
            }
            .sheet(isPresented: $showDetail) {
                PostView(listingData: $feedData)
            }
            

        }
    }
struct BulkListing: View {
    
    @State var feedData : feedInfo
    @State var showDetail = false
    
    @StateObject var firestoreConnector = FirebaseConnector()
    var body: some View {
        let username = feedData.username

       
  
        let itemName =  feedData.productName


        let itemPrice =  "$\(feedData.productPrice)"
        let imageName : [String] = feedData.images as? [String] ?? [""]
        
        ZStack{
            VStack {
                VStack(spacing: 0) {
                    TabView {
                        ForEach(imageName, id: \.self){im in
                            
                            UrlImageView(urlString: im)
                            
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    .opacity(feedData.sold ?? false ? 0.5 : 1)
                    .overlay(content: {
                        if let sold = feedData.sold {
                            if sold{
                                Text("SOLD")
                                    .font(.custom("Montserrat-Bold", size: 30))
                                    .foregroundColor(.red)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 45)
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
                    .aspectRatio(CGSize(width: 7, height: 5), contentMode: .fit)
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .onAppear{
                        firestoreConnector.fetchViewAccount(userID: feedData.userID)
                    }
                    
                    Rectangle()
                    
                        .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainThird]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 4)
                }
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(itemName) - Bulk")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                            .lineLimit(2)
                            
                    
                        HStack (alignment: .top){
                            UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            
                            
                            VStack(alignment: .leading) {
                                Text("\(username)")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                    .font(.custom("Montserrat-Regular", size: 15))
                                
                            }
                            .padding(.horizontal, 5)
                            Spacer()
                            VStack (alignment: .trailing) {
                                Text(itemPrice)
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-Bold", size: 20))
                                .lineLimit(1)
                                HStack {
                                    
                                    Text("(\(feedData.productCondition))")
                                        .font(.custom("Montserrat-SemiBoldItalic", size: 12))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    Text("\(feedData.productCat) items")
                                        .font(.custom("Montserrat-SemiBold", size: 12))
                                }
                            }
                        }
                        
                    }
                    .layoutPriority(100)
                    
            
                }
                
                .padding([.bottom, .leading, .trailing])
            }
            .cornerRadius(10)
            .background(
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(CustomColor.grayBackground))
            .padding([.top, .horizontal])
            .onTapGesture {
                self.showDetail.toggle()
                
                
            }
            
            .sheet(isPresented: $showDetail) {
                
                BulkProdView(listingData: $feedData)
            }
            
        }

    }
}
    struct demo8: View {
        @State var feedData = feedInfo(id: "fdsfs", username: "french_soles", productName: "Jordan 1 Retro High OG A Ma Maniére", productSKU: "HDsja", productSize: "7", productCat: "M", productPrice: "300", productCondition: "New", productDelivery: "Ship", city: "Chicago", state: "IL", shipping: "10", time: "242435", postType: "Item", atype: "", caption: "We looped this shit like it was Mickey Ds", likes: [], saves: [], comments: [], images: ["https://firebasestorage.googleapis.com:443/v0/b/forum-development-28d7a.appspot.com/o/images%2F0-5C5334AF-15BA-4039-B906-C572E86C3BA8.jpg?alt=media&token=8850bca2-3425-4d17-b595-07488635dd9f"], userID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", bulkSize: [[:]], rating: "4.0", Nameimages: ["0-B15A7ED0-BBDA-497B-9F55-36C112BC1255.jpg"], sold: true)
        
        
        var body: some View {
            
            ScrollView {
                VStack {
                   // Post(feedData: feedData)
                  //  BulkListing(feedData: feedData)
                    Listing(feedData: feedData)
                   
                }
            }
            
        }
    }
    struct Posts_Previews: PreviewProvider {
       static var previews: some View {
            demo8()
                .environmentObject(FirebaseConnector())
            
        }
    }
