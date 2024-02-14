//
//  CardPreviews.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct SocialCardPreview: View {
    
    @State var socialMedia : [String: String]
    @Binding var showSocial : Bool
    var width : CGFloat
    var height : CGFloat
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var chatID : String
    var userProfile : accountProfile
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.white)
                Text("\(socialMedia["phoneNum"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                  
           
                Spacer()
                Button {
                    self.showSocial.toggle()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundColor(.white)
                  
                }
                .offset(x: 10, y: -10)
       
            }
            .padding(5)
            HStack {
                Image("igIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(socialMedia["instagram"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
           
            
                Spacer()
              
                
            }
            .padding(5)
            HStack {
                Image("twitterIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(socialMedia["twitter"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
               
                  
                Spacer()
              
            }
            .padding(5)
            HStack {
                Image("snapchatIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(socialMedia["snap"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))

                    
                Spacer()
               
            }
            .padding(5)
            HStack {
                Text("You can edit this information in your account settings.")
                    .foregroundColor(.white)
                .font(.custom("Montserrat-Regular", size: 10))
                Spacer()
                Button {
                    firestoreConnector.uploadMessageNoti(text: "Contact Information Received ☎️", chatID: chatID, type: "social", data: socialMedia, otherUser: userProfile)
                    self.showSocial.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                }
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
            )
    }
}

struct PaymentCardPreview: View {
    
    @State var payments : [String: String]
    @Binding var showPayments : Bool
    var width : CGFloat
    var height : CGFloat
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var chatID : String
    var userProfile : accountProfile
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Image("zelleIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(payments["zelle"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                
                
                Spacer()
                
                Button {
                    self.showPayments.toggle()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundColor(.white)
                        
                }.offset(x: 10, y: -10)
           
            }
            .padding(5)
            HStack {
                Image("venmoIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(payments["venmo"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
         
                  

                Spacer()
                
            }
            .padding(5)
            HStack {
                Image("cashappIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(payments["cashapp"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
               
                    
                Spacer()
        
            }
            .padding(5)
            HStack {
                Image("paypaIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(payments["paypal"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                
                
                Spacer()
                
      
            }
            .padding(5)
            HStack {
                Text("You can edit this information in your account settings.")
                    .foregroundColor(.white)
                .font(.custom("Montserrat-Regular", size: 10))
                Spacer()
                Button {
                    firestoreConnector.uploadMessageNoti(text: "Payment Information Received 💳", chatID: chatID, type: "payment", data: payments, otherUser: userProfile)
                    self.showPayments.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                }
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
            )
        
    }
}
struct AddressCardPreview: View {
    
    @State var address : [String: String]
    @Binding var showAddress : Bool
    var chatID : String
    var width : CGFloat
    var height : CGFloat
    var userProfile : accountProfile
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text("\(address["address"] ?? "No address"), \(address["address2"] ?? "")\n\(address["city"] ?? ""), \(address["state"] ?? "")\n\(address["zipcode"] ?? ""), \(address["country"] ?? "") ")
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .foregroundColor(.white)
                
                
                Spacer()
                Button {
                    self.showAddress.toggle()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title3)
                        .foregroundColor(.white)
                       
                } .offset(x: 10, y: -30)
                
            }
            .padding(5)
            HStack {
                Text("You can edit this information in your account settings.")
                    .foregroundColor(.white)
                .font(.custom("Montserrat-Regular", size: 10))
                Spacer()
                Button {
                    firestoreConnector.uploadMessageNoti(text: "Address Information Received 🏠", chatID: chatID, type: "address", data: address, otherUser: userProfile)
                    self.showAddress.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                }
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
               )
        
    }
}

struct LogCardPreview : View{
    @Binding var showLog : Bool
    var image : String
    var width : CGFloat
    var height : CGFloat
    @Binding var priceLog : String
    var chatID : String
    var userProfile : accountProfile
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body : some View{
        VStack(alignment: .leading){
            
            HStack {

                VStack (alignment: .leading,spacing: 10) {
                    Text("Sale Confirmation")
                        .foregroundColor(.white)
                        .underline()
                        .font(.custom("Montserrat-Bold", size: 14))
                    ZStack(alignment: .leading) {
                        HStack {
                            HStack {
                                Text("$")
                                    .font(.custom("Montserrat-SemiBold", size: 18))
                                
                                    .foregroundColor(.white)
                                TextField("", text: $priceLog)
                                    .limitInputLength(value: $priceLog, length: 7)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .keyboardType(.decimalPad)
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-SemiBold", size: 18))
                                
                                Spacer()
                                
                            }
                            .padding()
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                            .frame(height: 35))
                        .foregroundColor(.white)
                        .accentColor(.white)
                        
                        Text("Sale Price")
                            .foregroundColor(.white)
                            .font(.custom("Montserrat-SemiBold", size: 13))
                            .background(CustomColor.grayBackground)
                            .padding(EdgeInsets(top: 0, leading:15, bottom: 35, trailing: 0) )
                        
                    }.frame(width: width * 0.3)
                    
                   
                }
                    UrlImageView(urlString: image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 6.5, height: width / 6.5)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(5)
                Spacer()
                VStack {
                    Button {
                            self.showLog.toggle()
                        } label: {
                            Image(systemName: "x.circle")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                    } .offset(x: 15, y: -15)
          
                    
                    Button {
                        firestoreConnector.uploadMessageNoti(text: "Sale Log Created 📁" , chatID: chatID, type: "saleLog", data: ["Sale Price": self.priceLog], otherUser: userProfile)
                        self.showLog.toggle()
                        self.priceLog = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .frame(width: 50, height: 50)
                            .foregroundColor(priceLog == "" ? .gray : .white)
                        
                    }.offset(x: 15, y: 20)
                        .disabled(priceLog == "")
                }
            } .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            
            
            
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
            )

    }
}

struct ReviewCardPreview: View{
    @Binding var showRating : Bool
    var chatID : String
    var width : CGFloat
    var height : CGFloat
    var userProfile : accountProfile
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            HStack {
                Text("Request Feedback")
                    .foregroundColor(.white)
                    .underline()
                    .font(.custom("Montserrat-Bold", size: 14))
                
                
                Spacer()
                Button {
                    self.showRating.toggle()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                } .offset(x: 10, y: -15)
                
            }
            .padding(5)
            
            HStack {

                ForEach(1...5, id: \.self) { number in
                    
                          
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.title3)
                        
                    }
                
           
                
            }
            HStack {
                Text("You can only receive feedback from a user once")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-Regular", size: 10))
                Spacer()
                Button {
                    firestoreConnector.uploadMessageNoti(text: "Feedback Requested ⭐️", chatID: chatID, type: "rateCard", data: [:], otherUser: userProfile)
                    self.showRating.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                }
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
            )
        
    }
}


struct SocialCardPreviewDemo: View {
    
    @State var socialMedia = ["phoneNum" : ""]
    @State var priceLog = ""
    @State var showSocial = false
    var body: some View {
        Text("hello")
        //SocialCardPreview(socialMedia: ["phoneNum": "2245184878", "instagram": "samRidet", "twitter": "god12", "snap": "samr"], showSocial: $showSocial, width: 428, height: 926, chatID: "")
        //PaymentCardPreview(payments: ["zelle": "2245184878", "venmo": "samRidet", "cashapp": "god12", "paypal": "shunzi.fpv@gmail.com"], showPayments: $showSocial, width: 428, height: 926, chatID: "")
        //AddressCardPreview(address: socialMedia, showAddress: $showSocial, chatID: "", width: 428, height: 926)
        //LogCardPreview(showLog: $showSocial, image: "https://firebasestorage.googleapis.com:443/v0/b/looper-17aba.appspot.com/o/images%2F0-0CEA17BE-E627-40A6-9628-FC5AD1AE06CE.jpg?alt=media&token=5e223e0a-f943-4579-8fe0-aa30bdb9bc97", width: 428, height: 926, priceLog: $priceLog, chatID: "")
        
        //ReviewCardPreview(showRating: $showSocial, chatID: "", width: 428, height: 926)
    }
}
struct CardPreviews_Previews: PreviewProvider {
    static var previews: some View {
        SocialCardPreviewDemo()
            .environmentObject(FirebaseConnector())
    }
}
