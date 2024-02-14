    //
    //  Account.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/14/22.
    //

import SwiftUI



struct ViewUserAccount: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var authModel: AuthViewModel
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var following = false
    @State var Listings : Int = 0
    @State var isEditing = false
    @State var userID : String

    
    var GridOptions = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        
        
        GeometryReader {geometry in
            NavigationView {
                VStack{
                
                    
                    HStack(spacing: 20) {
                        Text("Account")
                            .foregroundColor(.white)
                            .font(.custom("Montserrat-Bold", size: 20))
                        Spacer()
                        if firestoreConnector.viewdataToDisplay.socialMedia["instagram"] ?? "" != ""{
                            Button {
                                if UIApplication.shared.canOpenURL(URL(string: "instagram://user?username=\(firestoreConnector.viewdataToDisplay.socialMedia["instagram"] ?? "")")!) {
                                        // Open the Instagram app on the account
                                    UIApplication.shared.open(URL(string: "instagram://user?username=\(firestoreConnector.viewdataToDisplay.socialMedia["instagram"] ?? "")")!, options: [:], completionHandler: nil)
                                } else {
                                        // If the Instagram app is not installed, open the account in the browser
                                    UIApplication.shared.open(URL(string: "https://www.instagram.com/\(firestoreConnector.viewdataToDisplay.socialMedia["instagram"] ?? "")")!, options: [:], completionHandler: nil)
                                }
                            } label: {
                                Image("igIcon")
                                    .resizable()
                                    .frame(width: geometry.size.width / 15, height: geometry.size.width / 15)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        
                        Button {
                            if following{
                                
                                firestoreConnector.Unfollow(Otheruser: firestoreConnector.viewdataToDisplay)
                                
                            }else{
                                
                                firestoreConnector.Follow(Otheruser: firestoreConnector.viewdataToDisplay)
                                
                            }
                            self.following.toggle()
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                        } label: {
                            Image(systemName: following ? "person.badge.minus.fill" : "person.badge.plus.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 15)
                                .foregroundColor(.white)
                        }
                        
                        
                        .onAppear{
                            
                            if firestoreConnector.dataToDisplay.followings.contains(firestoreConnector.viewdataToDisplay.id){
                                self.following = true
                                print("already followed")
                            }
                            
                            
                        }
                   
                        
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "x.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 15)
                                .foregroundColor(.white)
                        }
                        
                    }     .padding(.horizontal)
                        .padding([.top], 10)
                    ScrollView (showsIndicators: false) {
                        VStack {
                            HStack (spacing: 15){
                                
                                UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                                    .scaledToFill()
                                    .frame(width: geometry.size.width / 7, height: geometry.size.width / 7)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading){
                                    
                                    Text("\(firestoreConnector.viewdataToDisplay.username)")
                                        .font(.custom("Montserrat-Bold", size: 18))
                                    
                                    Text("\(String(format: "%.1f", firestoreConnector.viewratingToDisplay.rating))★")
                                        .font(.custom("Montserrat-SemiBold", size: 14))
                                    
                                }
                                Spacer()
                            }.padding(.horizontal)
                            
                            
                            DataCardViewAccount(firestoreConnector: firestoreConnector, width: geometry.size.width, height: geometry.size.height)
                                .frame(width: geometry.size.width * 0.96)
                                .padding(.vertical, 5)
                            
                            CustomSegmentedPickerView(selection: $Listings, width: geometry.size.width * 0.98, height: geometry.size.height)
                                //.layoutPriority(100)
                                .zIndex(100)
                            
                            
                            if Listings  == 1{
                                
                                if (firestoreConnector.viewposts.count == 0 ){
                                    Spacer()
                                    Text("No active posts")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .padding(.vertical, 10)
                                    Spacer()
                                }else{
                                    LazyVGrid(columns: GridOptions, spacing: 5){
                                        ForEach(firestoreConnector.viewposts) {currentPost in
                                            
                                            PostThumbnailAccountView(width: geometry.size.width / 2.1, height: geometry.size.height / 4.1, postsData: currentPost, typeview: false)
                                                .frame(width:geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                                            
                                        }
                                    }
                                }
                            }else{
                                
                                VStack(spacing: 10){
                                    if (firestoreConnector.viewlistings.count == 0 ){
                                        Spacer()
                                        Text("No items listed")
                                            .font(.custom("Montserrat-SemiBold", size: 15))
                                        Spacer()
                                    }else{
                                        ForEach(firestoreConnector.viewlistings) {currentListing in
                                            
                                            if currentListing.postType == "Item"{
                                                ListingThumbnailAccountView(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, typeview: false)
                                                
                                                    .frame(width:geometry.size.width * 0.95)
                                            } else if currentListing.postType == "Bulk"{
                                                BulkThumbnailAccountView(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, typeview: false)
                                                    .frame(width:geometry.size.width * 0.95)
                                                
                                            }
                                            
                                            
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }.animation(.default, value: Listings)
                    }.background(.black)
                    .onAppear{
                        firestoreConnector.fetchAccount {
                            if firestoreConnector.dataToDisplay.followings.contains(userID){
                                self.following = true
                                print("liked")
                            }

                        }
     
                        firestoreConnector.fetchViewAccount(userID: userID)
                        print("Appear")
                        
                    }
                    
                    
                }.background(.black)
            } .background(.black)
                .accentColor(.white)

           
     

                
              

        }
        .navigationBarTitle(" ")
        .navigationBarTitleDisplayMode(.inline)
        
        .padding(.vertical, 5)
        .background(.black)
  
        
    }
}


struct ViewUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        ViewUserAccount(userID: "dsfdsfs")
            .environmentObject(FirebaseConnector())
    }
}
