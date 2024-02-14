//
//  AccountResultStruct.swift
//  Looper
//
//  Created by Samuel Ridet on 1/9/23.
//

import SwiftUI

struct AccountResultStruct: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    @State var user : algoliaUser?
    @State var showingUser = false
    
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        VStack{
            HStack{
                UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                    .scaledToFill()
                    .frame(width: width * 0.15, height: width * 0.15)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    
                    Text("\(firestoreConnector.viewdataToDisplay.username)")
                        
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .bold()
                        .lineLimit(1)
                    Text("\(String(format: "%.1f", firestoreConnector.ratingToDisplay.rating))★")
                        .font(.custom("Montserrat-Regular", size: 15))
 
                }.padding(.horizontal, 5)
                
                Spacer()
       
                
                
            }.padding(5).onTapGesture {
                self.showingUser.toggle()
            }.onAppear{
                firestoreConnector.fetchViewAccount(userID: user?.uid ?? " ")
                firestoreConnector.fetchRating(userID: user?.uid ?? " ")
            }.sheet(isPresented: $showingUser) {
                ViewUserAccount(userID: user?.uid ?? " ")
            }
            
  
        }.fixedSize(horizontal: false, vertical: true)
    }
}

struct AccountResultStructDemo : View{
    @State var user = algoliaUser(uid: "M17K7nYafvPjwJqDsyEwDAX4UCy1", username: "french_soles")
    
    
    
    var body: some View{
        AccountResultStruct(user: user, width: 428, height: 926)
 
    }
}

struct AccountResultStruct_Previews: PreviewProvider {
    static var previews: some View {
        AccountResultStructDemo()
            .environmentObject(FirebaseConnector())
    }
}
