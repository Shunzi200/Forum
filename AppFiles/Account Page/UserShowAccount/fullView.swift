    //
    //  fullView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 10/23/22.
    //

import SwiftUI
    //
    //  ProductView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/15/22.
    //

import SwiftUI
import CoreLocation
import MapKit

struct ProductAccountView: View {
    
    @State var listingData : feedInfo
    @State var liked = false
    @State var saved = false
    
    @StateObject var firestoreConnector = FirebaseConnector()
        // let images = "placeHolder"
    
    @State var showAccount = false
    @Environment(\.presentationMode) var presentationMode
    @State var showConfirmation = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0451, longitude: -87.6877),
        span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    )
    
    @State var annotations : [Place] = []
    
    var body: some View {
        let currUserID = firestoreConnector.dataToDisplay.userID
        let username = listingData.username
        let city = listingData.city
        let state = listingData.state
        let productDelivery = listingData.productDelivery
        let location =  "\(city), \(state)"
        let shipping = "$\(listingData.shipping)"
        let itemName =  listingData.productName
        let itemSKU =  listingData.productSKU
        let itemPrice =  "$\(listingData.productPrice)"
      
        
            // let imageplace : UIImage = UIImage(named: "imagePlaceHolder")!
            // let arrayplace : [UIImage] = [imageplace]
        let imageName : [String] = listingData.images as? [String] ?? [""]
 
        GeometryReader { geometry in
            ZStack (alignment: .topTrailing){
                ScrollView(showsIndicators: false){
                    VStack {
                        VStack(spacing: 0) {
                            TabView {
                                ForEach(imageName, id: \.self){im in
                                    
                                    UrlImageView(urlString: im)
                                    
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                }
                            }
                            .opacity(listingData.sold ?? false ? 0.5 : 1)
                            .overlay(content: {
                                if let sold = listingData.sold {
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
                        }
                        
                        
                        .onAppear{
                            
                            firestoreConnector.fetchAccount {
                                if firestoreConnector.dataToDisplay.liked.contains(listingData.id){
                                    self.liked = true
                                    print("liked")
                                }
                                
                                if firestoreConnector.dataToDisplay.saved.contains(listingData.id){
                                    self.saved = true
                                    print("saved")
                                }
                            }
                            
                            firestoreConnector.fetchViewAccount(userID: listingData.userID)
                            
                            let geocoder = CLGeocoder()
                            geocoder.geocodeAddressString(listingData.zipcode ?? "") { (placemarks, error) in
                                if error == nil {
                                    if let placemark = placemarks?[0] {
                                        let location = placemark.location
                                        let coordinate = location?.coordinate
                                        
                                        let structt = Place( coordinate: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0))
                                        
                                        if structt.coordinate.latitude != 0 && structt.coordinate.longitude != 0 {
                                            self.annotations.append(structt)
                                            self.region = MKCoordinateRegion(
                                                center: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0),
                                                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                                        }
                                        
                                        
                                    }
                                } else {
                                    print("Geocoding failed: \(error!)")
                                }
                            }
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text(itemName)
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                Text(itemSKU)
                                    .font(.custom("Montserrat-Regular", size: 15))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                HStack (alignment: .top){
                                    
                                   
                                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 40, height: 40)
                                        VStack(alignment: .leading) {
                                            
                                            Text("\(username)")
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                .foregroundColor(.white)
                                            
                                            Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                                .foregroundColor(.white)
                                                .font(.custom("Montserrat-Regular", size: 15))
                                        
                                    }
                                    //.padding(.horizontal, 5)
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text(itemPrice)
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-Bold", size: 20))
                                            .lineLimit(1)
                                        HStack{
                                            Text("\(listingData.productSize)\(listingData.productCat)")
                                                .font(.custom("Montserrat-SemiBold", size: 12))
                                            Text("(\(listingData.productCondition))")
                                                .font(.custom("Montserrat-SemiBoldItalic", size: 12))
                                                .foregroundColor(.white)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                
                                if (productDelivery == "Both"){
                                    Text("\(location),  \(shipping) Shipping")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }else if (productDelivery == "Shipping"){
                                    Text("\(shipping) Shipping")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }else if (productDelivery == "Local meetup"){
                                    Text("\(location)")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                HStack {
                                    
                                    VStack {
                                        Button {
                                            if liked{
                                                print("Unliking")
                                                firestoreConnector.UnlikePost(postData: listingData)
                                                listingData.likes.removeAll { $0 == currUserID }
                                            }else{
                                                print("Liking")
                                                firestoreConnector.LikePost(postData: listingData)
                                                 listingData.likes.append(currUserID)
                                            }
                                            self.liked.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: liked ? "heart.fill" : "heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.065)
                                                .foregroundColor(liked ? .red : .white)
                                            
                                        }
                                        
                                        Text("\(listingData.likes.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Button {
                                            if saved{
                                                print("Unsaving")
                                                firestoreConnector.UnsavePost(postData: listingData)
                                                listingData.saves.removeAll { $0 == currUserID }
                                            }else{
                                                print("Saving")
                                                firestoreConnector.SavePost(postData: listingData)
                                                listingData.saves.append(currUserID)
                                            }
                                            self.saved.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: saved ? "bookmark.fill" : "bookmark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.045)
                                                .foregroundColor(.white)
                                            
                                        }
                                        Text("\( listingData.saves.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                        
                                    }
                                    Spacer()
                                    
                                    Offerbutton(listing: listingData, showConfirmation: $showConfirmation)
                                        .frame(width: geometry.size.width * 0.5)
                                    
                                    
                                    
                                    
                                }.padding(.horizontal, 10)

                                
                                
                                
                                
                                
                                
                            }
                            .layoutPriority(100)
                            
                            Spacer()
                        }
                        .padding([.bottom, .leading, .trailing])
                        if !self.annotations.isEmpty{
                            
                            
                            Map(coordinateRegion: $region, annotationItems: annotations) {annotation in
                                
                                MapAnnotation(coordinate: annotation.coordinate) {
                                    Circle()
                                        .fill(.blue)
                                        .opacity(0.7)
                                        .frame(width: 70, height: 70)
                                }
                                
                            }
                            .frame(width: geometry.size.width * 0.9, height: 200)
                            .cornerRadius(15)
                            
                            
                        }
                        Spacer()
                        
                        
                    }
                    .cornerRadius(10)
                   
                    
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundColor(.black)
                }.padding(5)
            }.opacity(showConfirmation ? 0.6: 1).overlay{  if showConfirmation{
                confirmationPopover(width: geometry.size.width, title: "Offer Successful", bodytext: "Your offer was sent successfully.", showConfirmation: $showConfirmation)
                
            }}
        }    .background(.black)
        
    }
    
}

struct PostAccountView: View {
        @State var listingData : feedInfo
        @State var liked = false
        @State var saved = false
        
        @State var saves = 0
        @State var likes = 0
        
        @State var showAccount = false
    @StateObject var firestoreConnector = FirebaseConnector()
    @Environment(\.presentationMode) var presentationMode
        var body: some View {
            let currUserID = firestoreConnector.dataToDisplay.userID
            let username = listingData.username
            let caption = listingData.caption
           

           
            let imageName : [String] = listingData.images as? [String] ?? [""]
            
            
            GeometryReader { geometry in
                ZStack (alignment: .topTrailing) {
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
                            
                            Rectangle()
                            
                                .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainBlue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 4)
                        }
                        .onAppear{
                            
                            firestoreConnector.fetchAccount {
                                if firestoreConnector.dataToDisplay.liked.contains(listingData.id){
                                    self.liked = true
                                    print("liked")
                                }
                                
                                if firestoreConnector.dataToDisplay.saved.contains(listingData.id){
                                    self.saved = true
                                    print("saved")
                                }
                            }
                            
                            firestoreConnector.fetchViewAccount(userID: listingData.userID)
                            
                   
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                 
                                        
                                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 40, height: 40)
                                        VStack(alignment: .leading) {
                                            
                                            Text("\(username)")
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                .foregroundColor(.white)
                                            
                                            Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                                .foregroundColor(.white)
                                                .font(.custom("Montserrat-Regular", size: 15))
                                        
                                    }
                                    //.padding(.horizontal, 5)
                                    
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Button {
                                            if liked{
                                                print("Unliking")
                                                firestoreConnector.UnlikePost(postData: listingData)
                                                listingData.likes.removeAll { $0 == currUserID }
                                            }else{
                                                print("Liking")
                                                firestoreConnector.LikePost(postData: listingData)
                                                listingData.likes.append(currUserID)
                                            }
                                            self.liked.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: liked ? "heart.fill" : "heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.065)
                                                .foregroundColor(liked ? .red : .white)
                                            
                                        }
                                        
                                        Text("\(listingData.likes.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Button {
                                            if saved{
                                                print("Unsaving")
                                                firestoreConnector.UnsavePost(postData: listingData)
                                                listingData.saves.removeAll { $0 == currUserID }
                                            }else{
                                                print("Saving")
                                                firestoreConnector.SavePost(postData: listingData)
                                                listingData.saves.append(currUserID)
                                            }
                                            self.saved.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: saved ? "bookmark.fill" : "bookmark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.045)
                                                .foregroundColor(.white)
                                            
                                        }
                                        Text("\( listingData.saves.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                        
                                    }
                                    
                                    
                                }
                                
                                Text("\"\(caption)\"")
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-SemiBoldItalic", size: 16))
                                
                                
                                
                            }
                            .layoutPriority(100)
                            
                            Spacer()
                        }
                        .padding([.bottom, .leading, .trailing])
                        Spacer()
                        
                        
                    }
                    .cornerRadius(10)
                    
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                            .foregroundColor(.black)
                    }.padding(5)
                }
            }   .background(.black)
            
            
        }
        
    }

struct BulkAccountView: View {
    
    
    @State var listingData : feedInfo
    @State var liked = false
    @State var saved = false
    @StateObject var firestoreConnector = FirebaseConnector()
        // let images = "placeHolder"
    @Environment(\.presentationMode) var presentationMode
    
    @State var showConfirmation = false
    @State var showAccount = false
    
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0451, longitude: -87.6877),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )
    
    @State var annotations : [Place] = []
    
    var body: some View {
        let currUserID = firestoreConnector.dataToDisplay.userID
        let username = listingData.username
        let city = listingData.city
        let state = listingData.state
        let productDelivery = listingData.productDelivery
        let location =  "\(city), \(state)"
        let shipping = "$\(listingData.shipping)"
        let itemName =  listingData.productName
        let itemSKU =  listingData.productSKU
        let itemPrice =  "$\(listingData.productPrice)"
      
        let pricePer = String(format: "%.0f", ceil((Float(listingData.productPrice) ?? 1)/(Float(listingData.productCat) ?? 1)))
        let imageName : [String] = listingData.images as? [String] ?? [""]
            // let imageplace : UIImage = UIImage(named: "imagePlaceHolder")!
            // let arrayplace : [UIImage] = [imageplace]
     
       
        
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                ScrollView (showsIndicators: false){
                    VStack {
                        VStack(spacing: 0) {
                            TabView {
                                ForEach(imageName, id: \.self){im in
                                    
                                    UrlImageView(urlString: im)
                                    
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                }
                            }
                            .opacity(listingData.sold ?? false ? 0.5 : 1)
                            .overlay(content: {
                                if let sold = listingData.sold {
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
                            
                                .fill(LinearGradient(gradient: Gradient(colors: [CustomColor.mainThird]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 4)
                        }
                        
                        
                        .onAppear{
                            
                            firestoreConnector.fetchAccount {
                                if firestoreConnector.dataToDisplay.liked.contains(listingData.id){
                                    self.liked = true
                                    print("liked")
                                }
                                
                                if firestoreConnector.dataToDisplay.saved.contains(listingData.id){
                                    self.saved = true
                                    print("saved")
                                }
                            }
                            firestoreConnector.fetchViewAccount(userID: listingData.userID)
                            
                            listingData.bulkSize = listingData.bulkSize.sorted {
                                guard let s1 = $0["size"], let s2 = $1["size"] else {
                                    return false
                                    
                                }
                                if s1 == s2 {
                                    guard let g1 = $0["size"], let g2 = $1["size"] else {
                                        return false
                                    }
                                    return g1 < g2
                                }
                                return s1 < s2
                            }
                            
                            
                            let geocoder = CLGeocoder()
                            geocoder.geocodeAddressString(listingData.zipcode ?? "") { (placemarks, error) in
                                if error == nil {
                                    if let placemark = placemarks?[0] {
                                        let location = placemark.location
                                        let coordinate = location?.coordinate
                                        
                                        let structt = Place( coordinate: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0))
                                        
                                        if structt.coordinate.latitude != 0 && structt.coordinate.longitude != 0 {
                                            self.annotations.append(structt)
                                            self.region = MKCoordinateRegion(
                                                center: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0),
                                                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                                        }
                                        
                                        
                                    }
                                } else {
                                    print("Geocoding failed: \(error!)")
                                }
                            }
                            
         
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("\(itemName) - Bulk")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                HStack {
                                    Text(itemSKU)
                                        .font(.custom("Montserrat-Regular", size: 15))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    Spacer()
                                    
                                    Text("(\(listingData.productCondition))")
                                        .font(.custom("Montserrat-SemiBoldItalic", size: 15))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    
                                    Text("\(listingData.productCat) items")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                                HStack (alignment: .top){
                                    
                                    
                                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 40, height: 40)
                                        VStack(alignment: .leading) {
                                            
                                            Text("\(username)")
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                .foregroundColor(.white)
                                            
                                            Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                                .foregroundColor(.white)
                                                .font(.custom("Montserrat-Regular", size: 15))
                                        
                                    }
                                    //.padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 3) {
                                        Text(itemPrice)
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-Bold", size: 20))
                                            .lineLimit(1)
                                        Text("$\(pricePer) per")
                                            .font(.custom("Montserrat-Regular", size: 12))
                                    }
                                }
                                
                                if (productDelivery == "Both"){
                                    Text("\(location),  \(shipping) Shipping")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }else if (productDelivery == "Shipping"){
                                    Text("\(shipping) Shipping")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }else if (productDelivery == "Local meetup"){
                                    Text("\(location)")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                HStack {
                                    
                                    VStack {
                                        Button {
                                            if liked{
                                                print("Unliking")
                                                firestoreConnector.UnlikePost(postData: listingData)
                                                listingData.likes.removeAll { $0 == currUserID }
                                            }else{
                                                print("Liking")
                                                firestoreConnector.LikePost(postData: listingData)
                                                listingData.likes.append(currUserID)
                                            }
                                            self.liked.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: liked ? "heart.fill" : "heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.065)
                                                .foregroundColor(liked ? .red : .white)
                                            
                                        }
                                        
                                        Text("\(listingData.likes.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Button {
                                            if saved{
                                                print("Unsaving")
                                                firestoreConnector.UnsavePost(postData: listingData)
                                                listingData.saves.removeAll { $0 == currUserID }
                                            }else{
                                                print("Saving")
                                                firestoreConnector.SavePost(postData: listingData)
                                                listingData.saves.append(currUserID)
                                            }
                                            self.saved.toggle()
                                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                                            impactMed.impactOccurred()
                                            
                                        } label: {
                                            Image(systemName: saved ? "bookmark.fill" : "bookmark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.045)
                                                .foregroundColor(.white)
                                            
                                        }
                                        Text("\( listingData.saves.count)")
                                            .foregroundColor(.white)
                                            .font(.custom("Montserrat-SemiBold", size: 12))
                                        
                                    }
                                    Spacer()
                                    
                                    Offerbutton(listing: listingData, showConfirmation: $showConfirmation)
                                        .frame(width: geometry.size.width * 0.5)
                                        .padding(.bottom, 15)
                                    
                                    
                                    
                                    
                                }.padding(.horizontal, 10)
                                
                                VStack{
                                    HStack {
                                        Text("Size List")
                                            .font(.custom("Montserrat-Bold", size: 17))
                                        Spacer()
                                    }
                                    ForEach(listingData.bulkSize, id: \.self){item in
                                        Divider()
                                        HStack {
                                            Text("\(item["size"] ?? "")\(item["category"] ?? "") x \(item["quantity"] ?? "") - \(item["price"] ?? "")$")
                                                .font(.custom("Montserrat-SemiBold", size: 17))
                                                .foregroundColor(.white)
                                                .padding(.vertical, 5)
                                            
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }.padding().background(RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(CustomColor.grayBackground))
                            }
                            .layoutPriority(100)
                            
                            Spacer()
                        }
                        .padding([.bottom, .leading, .trailing])
                        if !self.annotations.isEmpty{
                            
                            
                            Map(coordinateRegion: $region, annotationItems: annotations) {annotation in
                                
                                MapAnnotation(coordinate: annotation.coordinate) {
                                    Circle()
                                        .fill(.blue)
                                        .opacity(0.7)
                                        .frame(width: 70, height: 70)
                                }
                                
                            }
                            .frame(width: geometry.size.width * 0.9, height: 200)
                            .cornerRadius(15)
                            
                            
                        }
                        Spacer()
                        
                        
                    }
                    
                    .cornerRadius(10)
                    
                    
                }        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundColor(.black)
                }.padding(5)
            }.opacity(showConfirmation ? 0.6: 1).overlay{  if showConfirmation{
                confirmationPopover(width: geometry.size.width, title: "Offer Successful", bodytext: "Your offer was sent successfully.", showConfirmation: $showConfirmation)
                
            }}
            
        }   .background(.black)
        
    }
    
}

