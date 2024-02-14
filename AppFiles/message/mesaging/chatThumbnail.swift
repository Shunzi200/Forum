//
//  chatThumbnail.swift
//  Looper
//
//  Created by Samuel Ridet on 12/22/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct chatThumbnail: View {
    @State var chat : Chat
    @StateObject var firestoreConnector = FirebaseConnector()
    @EnvironmentObject var mainfirestore : FirebaseConnector
    @State var otherMember : String?
    var width: CGFloat
    var height: CGFloat
    @State var userID = ""
    var body: some View {
        
        NavigationLink(destination: ChatView(chatID: chat.id)) {
            HStack {
           
                    UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic)
                        .scaledToFill()
                        .frame(width: width / 7.5, height: width / 7.5)
                        .clipShape(Circle())
                        .padding(5)
                    
                    VStack(alignment: .leading) {
                        Text("\(firestoreConnector.viewdataToDisplay.username)")
                            .font(.custom("Montserrat-Bold", size: 13))
                            .lineLimit(1)
                       
                        Text("\(chat.lastMessage)")
                            .lineLimit(1)
                            .font((userID != chat.lastSender && chat.opened == false) ? .custom("Montserrat-SemiBold", size: 12) : .custom("Montserrat-Regular", size: 12) )
                            .foregroundColor(firestoreConnector.notificationsData.chats.contains(chat.id) ? .white : .gray)
                    }
                    Spacer()
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(firestoreConnector.notificationsData.chats.contains(chat.id) ? CustomColor.mainPurple : .black)
                    Spacer()
                    Text("$\(chat.offerPrice)")
                        .font(.custom("Montserrat-Bold", size: 16))
                
                    UrlImageView(urlString: firestoreConnector.currentPost.images.first as? String ?? "")
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 7.5, height: width / 7.5)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(5)
            }
     

            .onAppear {
                
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                self.userID = userID

                for member in chat.members {
                    if member != userID {
                        self.otherMember = member
                        break
                    }
                }
                
                if let otherMember = self.otherMember {
                    firestoreConnector.fetchViewAccount(userID: otherMember)
                        // fetch data for otherMember from Firebase
                }
                firestoreConnector.PullPost(postID: chat.listingID)
                
                firestoreConnector.retrieveNotifications()
                
                
                
                
        }
        }
    }
}

struct demoChatThumbnail: View{
    @State var chat = Chat(id: "", members: ["M17K7nYafvPjwJqDsyEwDAX4UCy1", "iPq88RlqSegBTbgEaiu4p8cEW4x1"], lastMessage: "Hello", listingID: "", offerPrice: "300", date: "12423432423", opened: false, lastSender: "")

    var body: some View{
        chatThumbnail(chat: chat, width: 428, height: 926)
    }
}
struct chatThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        demoChatThumbnail()
            .environmentObject(FirebaseConnector())
        
    }
}
