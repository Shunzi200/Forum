//
//  SavedPosts.swift
//  Looper
//
//  Created by Samuel Ridet on 12/10/22.
//

import SwiftUI

struct SavedPosts: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var GridOptions = Array(repeating: GridItem(.flexible()), count: 2)
   
    @State var isEditing = false
    @State var showingPopover = false
    @State var Listings : Int = 0
    @State var numListings = 0
    @State var numPosts = 0
    
    @State var totalListings : [feedInfo] = []
    @State var totalPosts : [feedInfo] = []
    var body: some View {
        
        GeometryReader {geometry in
            VStack{
                let savedPosts = firestoreConnector.savedPosts

                

                
                
                CustomSegmentedPickerView(selection: $Listings, width: geometry.size.width * 0.98, height: geometry.size.height)
                
                
                if Listings == 0{
                    
                    if totalListings.count == 0 {
                        Spacer()
                        Text("No items saved")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                        Spacer()
                    }
                    else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(totalListings, id: \.id) {i in
                                    
                                    let currentListing = i
                                    
                                    
                                    if currentListing.postType == "Item"{
                                        ListingThumbnailAccountView(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, typeview: true)
                                        
                                            .frame(width:geometry.size.width * 0.95)
                                    } else if currentListing.postType == "Bulk"{
                                        BulkThumbnailAccountView(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, typeview: true)
                                            .frame(width:geometry.size.width * 0.95)
                                        
                                    }
                                }
                                
                                Spacer(minLength: 10)
                            }
                            
                        }
                    }
                    
                }else{
                    if totalPosts.count == 0 {
                        Spacer()
                        Text("No posts saved")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                        Spacer()
                    }
                    else {
                    ScrollView {
                        LazyVGrid(columns: GridOptions, spacing: 15) {
                            ForEach(totalPosts, id: \.id) {i in
                                
                                let currentListing = i
                                
                           
                                
                                if currentListing.postType == "Post"{
                                    PostThumbnailAccountView(width: geometry.size.width / 2.1, height: geometry.size.height / 4.1, postsData: currentListing, typeview: true)
                                        .frame(width:geometry.size.width / 2.1, height: geometry.size.height / 4.1 )
                                }
                                
                                
                            }
                            
                        }
                        }
                    }

                    
                    
                    
                    
                }
                
                   
                
            }.onAppear{
    
                
                for i in 0..<firestoreConnector.savedPosts.count {
                    if firestoreConnector.savedPosts[i].postType != "Post" {
                        totalListings.append(firestoreConnector.savedPosts[i])
                    }else{
                        totalPosts.append(firestoreConnector.savedPosts[i])
                    }
                }
                
               
            }
            .navigationBarTitle("Saved Posts")
        }
    }
}

struct SavedPosts_Previews: PreviewProvider {
    static var previews: some View {
        SavedPosts()
            .environmentObject(FirebaseConnector())
    }
}


