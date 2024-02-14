//
//  FeedPage.swift
//  Looper
//
//  Created by Samuel Ridet on 12/12/22.
//

import SwiftUI

struct FeedPage: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @State private var showingPopover = false
    var body: some View {

        GeometryReader{geometry in
            
            if firestoreConnector.feed.count > 0{
                VStack{
                    
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            Spacer(minLength: 15)
                            ForEach(firestoreConnector.feed) {feedElement in
                                
                                if feedElement.postType == "Item"{
                                    Listing(feedData: feedElement)
                                      //  .frame(width: geometry.size.width)
                                        .onTapGesture {
                                            showingPopover = true
                                        }
                                        .onAppear {
                                            if self.shouldLoadMoreData(currentItem: feedElement) {
                                             firestoreConnector.loadMore{
                                                    print("more")
                                                }
                                            }
                                        }
                                }
                                
                                if feedElement.postType == "Post"{
                                    Post(feedData: feedElement)
                                      //  .frame(width: geometry.size.width)
                                        .onTapGesture {
                                            showingPopover = true
                                        }
                                        .onAppear {
                                            if self.shouldLoadMoreData(currentItem: feedElement) {
                                              firestoreConnector.loadMore{
                                                    print("more")
                                                }
                                            }
                                        }
                                }
                                if feedElement.postType == "Bulk"{
                                    BulkListing(feedData: feedElement)
                                       // .frame(width: geometry.size.width)
                                        .onTapGesture {
                                            showingPopover = true
                                        }
                                        .onAppear {
                                           firestoreConnector.loadMore{
                                                print("more")
                                            }
                                        }
                                }
                            }
                            Spacer(minLength: 10)
                        }
                        .popover(isPresented: $showingPopover) {
                            
                        }
                      
                    }.refreshable {
                        firestoreConnector.feedPull{
                        }
                    }
  
                }.onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            }else{
                Text("    No listings posted yet   ")
                
                    .font(.custom("Montserrat-SemiBold", size: 15))
                
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
        }
    }
    private func shouldLoadMoreData(currentItem: feedInfo) -> Bool {
        guard let lastItem = firestoreConnector.feed.last else {
            return false
        }
        
        return lastItem.id == currentItem.id
    }
}



struct FeedPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedPage()
            .environmentObject(FirebaseConnector())
    }
}
