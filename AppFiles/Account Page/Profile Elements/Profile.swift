//
//  Profile.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct Profile: View {
    @State var showSocial =  false
    @State var showPayment = false
    @State var showAddress = false
    @StateObject var firestoreConnector = FirebaseConnector()
    @EnvironmentObject private var authModel: AuthViewModel
    @EnvironmentObject var mainfirestoreConnector : FirebaseConnector
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var phoneNum = ""
    @State var instagram = ""
    @State var twitter = ""
    @State var snap = ""
    
    @State var zelle = ""
    @State var venmo = ""
    @State var cashapp = ""
    @State var paypal = ""
    
    @State var address = ""
    @State var address2 = ""
    @State var state = ""
    @State var zipcode = ""
    @State var country = ""
    @State var city = ""
    
    @State var showConfirm1 = false
    @State var showConfirm2 = false
    @State var deleting = false
    
    var body: some View {

        GeometryReader {geometry in
            VStack{
                ScrollView(showsIndicators: false){
                    VStack{
                        
                        
                        
                        VStack {
                            HStack{
                                Text("Social Media Handles         ")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                Spacer()
                                
                                Image(systemName: showSocial ?  "arrow.up.circle" : "arrow.down.circle")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                            } .onTapGesture {
                                self.showSocial.toggle()
                            }
                            
                            if showSocial{
                                SocialMediaHandles(width: geometry.size.width, height: geometry.size.height, phoneNum: $phoneNum, instagram: $instagram, twitter: $twitter, snap: $snap)
                                
                                
                            }
                            Divider()
                        }.padding([.bottom],5)
                        
                        
                        VStack {
                            HStack{
                                Text("Payment Methods                ")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                Spacer()
                                
                                Image(systemName: showPayment ?  "arrow.up.circle" : "arrow.down.circle")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                            } .onTapGesture {
                                self.showPayment.toggle()
                            }
                            
                            if showPayment{
                                PaymentMethods(width: geometry.size.width, height: geometry.size.height, zelle: $zelle, venmo: $venmo, cashapp: $cashapp, paypal: $paypal)
                                    //.frame(height: geometry.size.width / 1.75)
                                
                            }
                            Divider()
                        }.padding([.bottom],5)
                        
                        VStack {
                            HStack{
                                Text("Address                              ")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                Spacer()
                                
                                Image(systemName: showAddress ?  "arrow.up.circle" : "arrow.down.circle")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                            } .onTapGesture {
                                self.showAddress.toggle()
                            }
                            
                            if showAddress{
                                Address(width: geometry.size.width, height: geometry.size.height, address: $address, address2: $address2, state: $state, zipcode: $zipcode, country: $country, city: $city)
                                    //.frame(height: geometry.size.width / 1.5)
                                
                                
                            }
                            Divider()
                        }.padding([.bottom],5)
                        
                    }
                    VStack{
                        VStack {
                            NavigationLink(destination: FAQ()) {
                                HStack {
                                    Image(systemName: "questionmark.app.fill")
                                        .foregroundColor(.white)
                                        .font(.body)
                                    Text("FAQ")
                                        .font(.custom("Montserrat-SemiBold", size: 16))
                                        .foregroundColor(.white)
                                        .padding([.bottom],5)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                        .font(.body)
                                }.padding([.bottom],5)
                            }
                           
                        }
                   
                        Divider()
                        NavigationLink(destination: Rules()) {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.white)
                                    .font(.body)
                                Text("Rules")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .padding([.bottom],5)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.body)
                            }.padding([.bottom],5)
                        }
                        
                        Divider()
                        VStack {
                            NavigationLink(destination: PrivacyPolicy()) {
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.white)
                                        .font(.body)
                                    Text("Privacy Policy")
                                        .font(.custom("Montserrat-SemiBold", size: 16))
                                        .foregroundColor(.white)
                                        .padding([.bottom],5)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                        .font(.body)
                                }.padding([.bottom],5)
                            }
                        }
                    }
                        VStack{
                        
                        Divider()
                        Button {
                            authModel.signOut()
                            mainfirestoreConnector.listings = []
                            mainfirestoreConnector.posts = []
                            //self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "person.fill.xmark")
                                    .font(.body)
                                    .foregroundColor(.white)
                                Text("Sign Out")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .padding([.leading],5)
                                Spacer()
                            }
                        }.padding([.bottom],5)
                        Divider()
                        Button {
                            self.showConfirm1.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "trash.fill")
                                    .font(.body)
                                    .foregroundColor(.red)
                                Text("Delete Account")
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .foregroundColor(.red)
                                    .padding([.leading],5)
                                Spacer()
                            }
                        }.padding([.bottom],5)
                        
                    }.confirmationDialog("Delete?", isPresented: $showConfirm1){
                        
                        Button("Permanently Delete", role: .destructive){
                            self.showConfirm2.toggle()
                        }
                    } message: {
                        Text("Are you sure you want to permanently delete this account? This action cannot be undone and all your data will be deleted.")
                    }.confirmationDialog("Delete?", isPresented: $showConfirm2){
                        
                        Button("Confirm Deleting Account", role: .destructive){
                            self.deleting = true
                            mainfirestoreConnector.listings = []
                            mainfirestoreConnector.posts = []
                            authModel.deleteCurrentUser()
                          //  self.presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        Text("This action is permanent and your account cannot be recovered.")
                    }
                    
             
                    Divider()
                    
                    Text("Follow us")
                        .font(.custom("Montserrat-SemiBold", size: 16))
                    HStack{
                        Button {
                            if UIApplication.shared.canOpenURL(URL(string: "instagram://user?username=forumappmarket")!) {
                                    // Open the Instagram app on the account
                                UIApplication.shared.open(URL(string: "instagram://user?username=forumappmarket")!, options: [:], completionHandler: nil)
                            } else {
                                    // If the Instagram app is not installed, open the account in the browser
                                UIApplication.shared.open(URL(string: "https://www.instagram.com/forumappmarket")!, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Image("igIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                                .cornerRadius(10)
                        }

                        Button {
                                // Check if the Twitter app is installed on the device
                            if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
                                    // Open the Twitter app on the account
                                UIApplication.shared.open(URL(string: "twitter://user?screen_name=ForumAppMarket")!, options: [:], completionHandler: nil)
                            } else {
                                    // If the Twitter app is not installed, open the account in the browser
                                UIApplication.shared.open(URL(string: "https://twitter.com/ForumAppMarket")!, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Image("twitterIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                                .cornerRadius(10)
                        }
                        Button {
                            if let discordURL = URL(string: "discord://") {
                                if UIApplication.shared.canOpenURL(discordURL) {
                                        // Open the Discord app
                                    UIApplication.shared.open(URL(string: "discord://invite/u6zQY9Ep")!, options: [:], completionHandler: nil)
                                } else {
                                        // If the Discord app is not installed, open in the browser
                                    UIApplication.shared.open(URL(string: "https://discord.gg/u6zQY9Ep")!, options: [:], completionHandler: nil)
                                }
                            }

                        } label: {
                            Image("discord")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                                .cornerRadius(10)
                        }
                       
                     
                     
                    }
                }
            }
            
                .onAppear{
                    firestoreConnector.fetchAccount {
                        self.phoneNum = firestoreConnector.dataToDisplay.socialMedia["phoneNum"] ?? ""
                        self.instagram = firestoreConnector.dataToDisplay.socialMedia["instagram"] ?? ""
                        self.twitter = firestoreConnector.dataToDisplay.socialMedia["twitter"] ?? ""
                        self.snap = firestoreConnector.dataToDisplay.socialMedia["snap"] ?? ""
                        
                        self.zelle = firestoreConnector.dataToDisplay.payment["zelle"] ?? ""
                        self.venmo = firestoreConnector.dataToDisplay.payment["venmo"] ?? ""
                        self.cashapp = firestoreConnector.dataToDisplay.payment["cashapp"] ?? ""
                        self.paypal = firestoreConnector.dataToDisplay.payment["paypal"] ?? ""
                        
                        self.address = firestoreConnector.dataToDisplay.address["address"] ?? ""
                        self.address2 = firestoreConnector.dataToDisplay.address["address2"] ?? ""
                        self.state = firestoreConnector.dataToDisplay.address["state"] ?? ""
                        self.zipcode = firestoreConnector.dataToDisplay.address["zipcode"] ?? ""
                        self.country = firestoreConnector.dataToDisplay.address["country"] ?? ""
                        self.city = firestoreConnector.dataToDisplay.address["city"] ?? ""
                    }
          
            }.onDisappear{
                firestoreConnector.updateProfileData(userID: firestoreConnector.dataToDisplay.id, phoneNum: self.phoneNum, instagram: self.instagram, twitter: self.twitter, snap: self.snap, zelle: self.zelle, venmo: self.venmo, cashapp: self.cashapp, paypal: self.paypal, address: self.address, address2: self.address2, state: self.state, zipcode: self.zipcode, country: self.country, city: self.city, deleting: deleting)
            }
                
            .padding()
                .navigationTitle("Account Settings")
                .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(FirebaseConnector())
    }
}
