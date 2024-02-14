//
//  ChatView.swift
//  Looper
//
//  Created by Samuel Ridet on 12/21/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatView: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    @EnvironmentObject var mainfirestore : FirebaseConnector

    @State var showAccount = false
    @State var showListing = false
    @State var messageText = ""
    @State var userID = ""
    @State var showSocial = false
    @State var showPayments = false
    @State var showAddress = false
    @State var showLog = false
    @State var showRate = false
    @State var priceLog = ""
    @State var showConfirmation = false
    @State var showFailConfirmation = false
    @State var showFailConfirmation2 = false
    @State var exitNext = false

    @State var chatID : String
    
    
    var body: some View {
       
        GeometryReader{geometry in
         
            ZStack {
                
                VStack{
                    
                    Rectangle()
                        .edgesIgnoringSafeArea(.top)
                        .frame(width: geometry.size.width, height: geometry.size.height/1500)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .padding([.top,.bottom], 5)
                    ScrollViewReader { scrollProxy in
                        ScrollView(showsIndicators: false){
                            VStack {
                                Text("Welcome!\n \nPlease be mindful of completing personal due diligence to verify the legitimacy of buyers or sellers.\n\nIf you are not familiar with this process, Forum highly recommends conducting in-person meetups only. \n\nForum does not oversee the transaction process and cannot be held accountable for associated liability.")
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                   // .multilineTextAlignment(.center)
                                    .padding(15)
                                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
                                ForEach(firestoreConnector.chatMessages){message in
                                    if message.sender == userID{
                                        
                                        if message.messageType == "social"{
                                            ChatBubble(position: .right, color: CustomColor.grayBackground) {
                                                SocialMediaCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }    .id(message.id)
                                            
                                        }else if message.messageType == "payment"{
                                            ChatBubble(position: .right, color: CustomColor.grayBackground) {
                                                PaymentCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }
                                            .id(message.id)
                                        }else if message.messageType == "address"{
                                            ChatBubble(position: .right, color: CustomColor.grayBackground) {
                                                AddressCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }    .id(message.id)
                                            
                                        }else if message.messageType == "saleLog"{
                                            ChatBubble(position: .right, color: CustomColor.grayBackground) {
                                                LogCard(chatData: message, listing:  firestoreConnector.currentPost, chat: firestoreConnector.chatNotif, userProfile:  firestoreConnector.viewdataToDisplay, width: geometry.size.width, height: geometry.size.height, userID: userID, showConfirmation: $showConfirmation)
                                                
                                            }    .id(message.id)
                                        }else if message.messageType == "rateCard"{
                                            ChatBubble(position: .right, color: CustomColor.grayBackground) {
                                                RateCard(firestoreConnector: firestoreConnector,userProfile: firestoreConnector.dataToDisplay, chatDetails: firestoreConnector.chatNotif,  width: geometry.size.width, height: geometry.size.height, showPublish: false)
                                                
                                            }    .id(message.id)
                                        }
                                        
                                        
                                        else{
                                            ChatBubble(position: .right, color: CustomColor.mainPurple) {
                                                Text("\(message.message)")
                                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                                    .textSelection(.enabled)
                                            }
                                            .id(message.id)
                                        }
                                        
                                        
                                        
                                    }else{
                                        
                                        if message.messageType == "social"{
                                            ChatBubble(position: .left, color: CustomColor.grayBackground) {
                                                SocialMediaCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }    .id(message.id)
                                        }else if message.messageType == "payment"{
                                            ChatBubble(position: .left, color: CustomColor.grayBackground) {
                                                PaymentCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }
                                            .id(message.id)
                                        }else if message.messageType == "address"{
                                            ChatBubble(position: .left, color: CustomColor.grayBackground) {
                                                AddressCard(chatData: message, width: geometry.size.width, height: geometry.size.height)
                                            }    .id(message.id)
                                            
                                        }else if message.messageType == "saleLog"{
                                            ChatBubble(position: .left, color: CustomColor.grayBackground) {
                                                LogCard(chatData: message, listing: firestoreConnector.currentPost, chat: firestoreConnector.chatNotif, userProfile:  firestoreConnector.viewdataToDisplay, width: geometry.size.width, height: geometry.size.height, userID: userID, showConfirmation: $showConfirmation)
                                                
                                            }    .id(message.id)
                                            
                                            
                                        }else if message.messageType == "rateCard"{
                                            ChatBubble(position: .left, color: CustomColor.grayBackground) {
                                                RateCard(firestoreConnector: firestoreConnector, userProfile:  firestoreConnector.viewdataToDisplay, chatDetails: firestoreConnector.chatNotif, width: geometry.size.width, height: geometry.size.height, showPublish: true)
                                                
                                            }    .id(message.id)
                                        }else{
                                            ChatBubble(position: .left, color: .gray) {
                                                Text("\(message.message)")
                                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                                    .textSelection(.enabled)
                                            }
                                            .id(message.id)
                                        }
                                        
                                    }
                                    
                                    
                                }
                                Spacer(minLength: 5)
                            }.opacity(showSocial || showPayments || showAddress || showLog || showRate ? 0.6 : 1)
                                .opacity(showConfirmation || showFailConfirmation ? 0.6: 1)
                                .transition(.opacity)
                        }.onAppear{
                            scrollProxy.scrollTo(firestoreConnector.chatMessages.last?.id)
                        }.onChange(of: firestoreConnector.chatMessages.last) { msg in
                                //withAnimation {
                            scrollProxy.scrollTo(firestoreConnector.chatMessages.last?.id)
                                //}
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 1) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    
                                    Button {
                                        self.showRate.toggle()
                                    } label: {
                                        
                                        RateCard_thumbnail()
                                    }
                                    Button {
                                        self.showSocial.toggle()
                                    } label: {
                                        SocialMediaCard_thumbnail()
                                    }
                                    Button {
                                        self.showPayments.toggle()
                                    } label: {
                                        
                                        PaymentCard_thumbnail()
                                        
                                    }
                                    Button {
                                        self.showAddress.toggle()
                                    } label: {
                                        
                                        AddressCard_thumbnail()
                                    }
                                    
                                    
                                }.padding([.leading,.trailing])
                                
                            }
                            ZStack(alignment: .trailing) {
                                MessageField(text: $messageText, minHeight: 30)
                                    .frame(width: geometry.size.width * 0.95)
                                    .onChange(of: messageText) { _ in
                                            // Update scroll position when messageText changes (e.g. when keyboard is shown)
                                        scrollProxy.scrollTo(firestoreConnector.chatMessages.last?.id)
                                    }
                                
                                
                                Button {
                                    firestoreConnector.uploadMessageNoti(text: self.messageText, chatID: firestoreConnector.chatNotif.id, type: "message", data: [:], otherUser:  firestoreConnector.viewdataToDisplay)
                                        //firestoreConnector.uploadMessage(text: self.messageText, chatID: chatDetails.id, type: "message", data: [:])
                                    self.messageText = ""
                                } label: {
                                    Image(systemName: "paperplane.fill")
                                        .font(.title2)
                                        .foregroundColor(messageText == "" ? .gray :.white)
                                    
                                }.disabled(messageText == "")
                                    .padding([.trailing], 5)
                                
                            }
                        }.padding([.top], 2)
                    }
                    
                    
                }.sheet(isPresented: $showAccount, content: {
                    ViewUserAccount(userID:  firestoreConnector.viewdataToDisplay.userID)
                }).sheet(isPresented: $showListing, content: {
                    if  firestoreConnector.currentPost.postType == "Bulk"{
                        BulkAccountView(listingData:  firestoreConnector.currentPost)
                    }else{
                        ProductAccountView(listingData:  firestoreConnector.currentPost)
                        
                    }
                    
                }) .navigationBarItems(leading: HStack {
                        UrlImageView(urlString:  firestoreConnector.viewdataToDisplay.profilePic)
                            .scaledToFill()
                            .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                            .clipShape(Circle())
                          
                        
                        Text("\( firestoreConnector.viewdataToDisplay.username)")
                            .bold()
                            .font(.custom("Montserrat-Bold", size: 15))
                            .lineLimit(1)
                        Spacer()
                  
                       
                    }.onTapGesture {
                        self.showAccount.toggle()
                    } ,trailing:
                        HStack{
                    if userID ==  firestoreConnector.currentPost.userID {
                        NavigationLink(destination: LogChatSeller(listingData:  firestoreConnector.currentPost, chat: firestoreConnector.chatNotif, offerPrice: "", userProfile: firestoreConnector.viewdataToDisplay, showConfirmation: $showConfirmation, exitNext: $exitNext), isActive: $showLog) {
                            Button {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                if  firestoreConnector.currentPost.id == " "{
                                    showLog = false
                                    showFailConfirmation2.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            showFailConfirmation2 = false
                                        }
                                        
                                    }
                                }
                                else if firestoreConnector.dataToDisplay.logs.contains( firestoreConnector.currentPost.id){
                                    showLog = false
                                    showFailConfirmation.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            showFailConfirmation = false
                                        }
                                        
                                    }
                                }else{
                                    
                                    showLog = true
                                    
                                    
                                }
                            } label: {
                                Text("Log")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 15)
                                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(showFailConfirmation ? CustomColor.grayBackground : CustomColor.mainPurple))
                            }

                           
                        }
                        
                        
                    }else{
                        NavigationLink(destination: LogChatBuyer(listingData:  firestoreConnector.currentPost, chat: firestoreConnector.chatNotif, offerPrice: "", userProfile:  firestoreConnector.viewdataToDisplay, showConfirmation: $showConfirmation, exitNext: $exitNext), isActive: $showLog) {
                            
                            
                            Button {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                if  firestoreConnector.currentPost.id == " "{
                                    showLog = false
                                    showFailConfirmation2.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            showFailConfirmation2 = false
                                        }
                                        
                                    }
                                }
                                else if firestoreConnector.dataToDisplay.logs.contains( firestoreConnector.currentPost.id){
                                    showLog = false
                                    showFailConfirmation.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            showFailConfirmation = false
                                        }

                                    }
                                }else{
                              
                                        showLog = true
                                   
                          
                                }
                            } label: {
                                Text("Log")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 15)
                                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor( CustomColor.mainPurple))
                            }
                            
                            
                        }
                    }


                            UrlImageView(urlString:  firestoreConnector.currentPost.images.first as? String ?? "")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(5)
                                .onTapGesture {
                                        // if (listing.images.first as? String ?? "" != ""){
                                    self.showListing.toggle()
                                        // }
                                    
                                }
                        
                        
                        
                            }
                    )
               
                    .onAppear{
                        
                        firestoreConnector.fetchChatNotif(chatID: chatID) { chat in
                            if chat == chat{
                                guard let userID = Auth.auth().currentUser?.uid else { return }
                                
                                self.userID = userID
                                
                                for member in firestoreConnector.chatNotif.members {
                                    if member != userID {
                                        firestoreConnector.fetchViewAccount(userID: member)
                                    }
                                }
                                firestoreConnector.PullPost(postID: firestoreConnector.chatNotif.listingID)
                                
                                firestoreConnector.fetchAccount {
                                    
                                }
                                
                                firestoreConnector.monitorMessages(messageID: firestoreConnector.chatNotif.id )
                                
                                firestoreConnector.openedMessage(chatID: firestoreConnector.chatNotif.id)
                            }
                        }
                   
                        
                    
                    }.onDisappear{
                        firestoreConnector.openedMessage(chatID: firestoreConnector.chatNotif.id)
                    }
            
                
                if showSocial {
    
                    SocialCardPreview(socialMedia: firestoreConnector.dataToDisplay.socialMedia, showSocial: $showSocial, width: geometry.size.width, height: geometry.size.height, chatID: firestoreConnector.chatNotif.id, userProfile:  firestoreConnector.viewdataToDisplay)
                            .frame(width: geometry.size.width * 0.8)
                    
                  
                  
                    
                    
                }
                else if showPayments {
            
                    PaymentCardPreview(payments: firestoreConnector.dataToDisplay.payment, showPayments: $showPayments, width: geometry.size.width, height: geometry.size.height, chatID: firestoreConnector.chatNotif.id, userProfile:  firestoreConnector.viewdataToDisplay)
                            .frame(width: geometry.size.width * 0.8)
                        
                
                   
                    
                    
                }
                else if showAddress {
            
                        AddressCardPreview(address: firestoreConnector.dataToDisplay.address, showAddress: $showAddress, chatID: firestoreConnector.chatNotif.id, width: geometry.size.width, height: geometry.size.height, userProfile:  firestoreConnector.viewdataToDisplay)
                            .frame(width: geometry.size.width * 0.85)
                      
       
                   
                    
                    
                }
           
                
                else if showRate {
                    
                ReviewCardPreview(showRating: $showRate, chatID: firestoreConnector.chatNotif.id, width: geometry.size.width, height: geometry.size.height, userProfile:  firestoreConnector.viewdataToDisplay)
                        .frame(width: geometry.size.width * 0.7)
                    
                    
                    
                    
                    
                }
                if showConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Log Successful", bodytext: "This item was logged successfully in your dashboard.", showConfirmation: $showConfirmation)
                    
                }
                
                if showFailConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Item already Logged", bodytext: "This item is already logged. You can edit it in your dashboard.", showConfirmation: $showFailConfirmation)
                }
                
                if showFailConfirmation2{
                    confirmationPopover(width: geometry.size.width, title: "Item does not exist", bodytext: "This item has been deleted.", showConfirmation: $showFailConfirmation)
                }
                
               
         
            }
  
        }.navigationBarTitle(" ")
            .navigationBarTitleDisplayMode(.inline)
       
       
    }
    
    
        
}

struct ChatViewDemo: View{
    @State var account = accountProfile(id: "", username: "", email: "", sales: [], rating: "", purchases: [], listing: [], post: [], reviews: "", liked: [], saved: [], profilePic: "", userID: "", followers: [], followings: [], NameImages: "", chats: [], socialMedia: [:], payment: [:], address: [:], logs: [])
    @State var chat = Chat(id: "", members: ["M17K7nYafvPjwJqDsyEwDAX4UCy1", "iPq88RlqSegBTbgEaiu4p8cEW4x1"], lastMessage: "Hello", listingID: "", offerPrice: "300", date: "12423432423", opened: false, lastSender: "")
    @State var listing = feedInfo(id: "dgfsdgs", username: "french_soles", productName: "Jordan 1 Volt", productSKU: "DHJSA-334", productSize:"" , productCat: "9", productPrice: "230", productCondition: "New", productDelivery: "Local", city: "Chicago", state: "IL", shipping: "15", time: "3458235290375", postType: " ", atype: " ", caption: "Loopin like we like it", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [["size": "9", "category": "M", "quantity": "2", "price": "200"], ["size": "11", "category": "M", "quantity": "2", "price": "200"]], rating: "", Nameimages: [])
    
    var body: some View{
        NavigationView {
            ChatView(chatID: "dfds")
        }
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatViewDemo()
            .environmentObject(FirebaseConnector())
    }
}
