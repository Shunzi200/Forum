//
//  AllMessages.swift
//  Looper
//
//  Created by Samuel Ridet on 10/18/22.
//

import SwiftUI

struct AllMessages: View {
    @State var offerSelect = false
    @Binding var option : Int
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        
        GeometryReader {geometry in
            VStack{
          
                    CustomSegmentedPickerViewMessages(selection: $option, width: geometry.size.width, height: geometry.size.height)
                    
   
                
                if option == 0{
                    ScrollView {
                    VStack{
                        if (firestoreConnector.chats.count != 0) {
                           
                                
                                ForEach(firestoreConnector.chats){ chat in
                                    VStack {
                                        chatThumbnail(chat: chat, width: geometry.size.width, height: geometry.size.height)
                                            .frame(height: geometry.size.height / 12)
                                    }
                                    Divider()
                                        .padding(.vertical, 4)
                                }.padding(.horizontal)
                        
                            }else{
                                Spacer()
                              
                                  
                                    Text("You have no ongoing conversations.    \n                   Accept offers to \n              message other users.")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                              
                                Spacer()
                            }
                                
                    }
                        }.padding([.top], 5)
                    .onAppear{
                        firestoreConnector.fetchChats()
                        firestoreConnector.retrieveNotifications()
                }
                }else if option == 1{
                    VStack {
                        OffersList(offerSelect: $offerSelect, option: $option)
                            .padding([.top], 5)
                    }
                    
                }
                else if option == 2{
                    VStack {
                        SentOffersList()
                            .padding([.top], 5)
                    }
                    
                }
            }
            
            .navigationBarTitle(" ", displayMode: .inline)
        }
    }
        
}

struct AllMessages_Previews: PreviewProvider {
    @State static var option = 0
    static var previews: some View {
        AllMessages(option: $option)
            .environmentObject(FirebaseConnector())
    }
}



