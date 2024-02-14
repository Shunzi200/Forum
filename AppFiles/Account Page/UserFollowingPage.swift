//
//  FollowingPage.swift
//  Looper
//
//  Created by Samuel Ridet on 2/14/23.
//

import SwiftUI

struct UserFollowingPage: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    var mainuserID : String
    @State var following : Bool
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                if following{
                    if firestoreConnector.viewdataToDisplay.followings.count == 0{
                        Spacer()
                        HStack {
                            Spacer()
                            Text("No followings")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }
                        Spacer()
                    }else{
                        
                            ScrollView(showsIndicators: false) {
                                VStack{
                                    
                                    ForEach(firestoreConnector.viewdataToDisplay.followings, id: \.self){account in
                                        let user = algoliaUser(uid: account, username: "")
                                        AccountResultStruct(user: user, width: geometry.size.width, height: geometry.size.height)
                                        
                                    }
                                }
                            }
                        }
                } else {
                    if firestoreConnector.viewdataToDisplay.followers.count == 0{
                        Spacer()
                        HStack {
                            Spacer()
                            Text("No followers")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }
                        Spacer()
                    }else{
                        ScrollView(showsIndicators: false) {
                            VStack{
                                
                                ForEach(firestoreConnector.viewdataToDisplay.followers, id: \.self){account in
                                    let user = algoliaUser(uid: account, username: "")
                                    AccountResultStruct(user: user, width: geometry.size.width, height: geometry.size.height)
                                    
                                }
                            }
                        }
                    }
                }
           
            }  .onAppear{
                firestoreConnector.fetchViewAccount(userID: mainuserID)
            }.navigationTitle(following ? "Following" : "Followers")
            
        } .background(.black)
    }
}




struct UserFollowingPage_Previews: PreviewProvider {
    static var previews: some View {
        UserFollowingPage(mainuserID: "M17K7nYafvPjwJqDsyEwDAX4UCy1", following: true)
            .environmentObject(FirebaseConnector())
    }
}
