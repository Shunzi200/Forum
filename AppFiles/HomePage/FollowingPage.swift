//
//  FollowingPage.swift
//  Looper
//
//  Created by Samuel Ridet on 12/12/22.
//

import SwiftUI

struct FollowingPage: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @State private var showingPopover = false
    var body: some View {
        let allData = firestoreConnector.feed.sorted(by: {
            $0.time > $1.time})
        GeometryReader{geometry in
 
            
            VStack{
                if firestoreConnector.followingsCopy.count > 0{
                    VStack{
                        
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Spacer(minLength: 15)
                                ForEach(allData) {feedElement in
                                    if firestoreConnector.followingsCopy.contains(  feedElement.userID){
                                        
                                        
                                        if feedElement.postType == "Item"{
                                            Listing(feedData: feedElement)
                                                .frame(width: geometry.size.width)
                                                .onTapGesture {
                                                    showingPopover = true
                                                }
                                        }
                                        
                                        if feedElement.postType == "Post"{
                                            
                                            Post(feedData: feedElement)
                                                .frame(width: geometry.size.width)
                                                .onTapGesture {
                                                    showingPopover = true
                                                }
                                        }
                                        
                                        
                                        
                                        if feedElement.postType == "Bulk"{
                                            BulkListing(feedData: feedElement)
                                                .frame(width: geometry.size.width)
                                                .onTapGesture {
                                                    showingPopover = true
                                                }
                                        }
                                    }
                                }
                                Spacer(minLength: 10)
                            }
                            .popover(isPresented: $showingPopover) {
                                
                            }
                            
                        }.refreshable {
                            firestoreConnector.fetchAccount {
                                firestoreConnector.followingsCopy = firestoreConnector.dataToDisplay.followings
                                firestoreConnector.feedPull{
                                }
                            }
                            
                        }
                        
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }else{
                    
                    Text("No posts from your followings")
                    
                        .font(.custom("Montserrat-SemiBold", size: 15))
                    
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    
                    
                }
            }.onAppear{
                
                firestoreConnector.fetchAccount {
                    firestoreConnector.followingsCopy = firestoreConnector.dataToDisplay.followings
                    firestoreConnector.feedPull{
                    }
                }
            }
              
                
                
                
            }
            
        }
    }
        


struct FollowingPage_Previews: PreviewProvider {
    static var previews: some View {
        FollowingPage()
            .environmentObject(FirebaseConnector())
    }
}
