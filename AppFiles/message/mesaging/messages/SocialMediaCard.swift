//
//  SocialMediaCard.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct SocialMediaCard: View {
    @State var chatData : chatMessage
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        
        VStack(alignment:.leading){
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.white)
                Text("\(chatData.data["phoneNum"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                            // Check if the iMessage app is installed on the device
                        if UIApplication.shared.canOpenURL(URL(string: "sms:")!) {
                                // Open the iMessage app on the phone number
                            UIApplication.shared.open(URL(string: "sms:\(chatData.data["phoneNum"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If iMessage is not installed, show an error message
                            print("iMessage is not installed on this device")
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["phoneNum"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
            HStack {
                Image("igIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["instagram"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                        if UIApplication.shared.canOpenURL(URL(string: "instagram://user?username=\(chatData.data["instagram"] ?? "")")!) {
                                // Open the Instagram app on the account
                            UIApplication.shared.open(URL(string: "instagram://user?username=\(chatData.data["instagram"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If the Instagram app is not installed, open the account in the browser
                            UIApplication.shared.open(URL(string: "https://www.instagram.com/\(chatData.data["instagram"] ?? "")")!, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["instagram"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }

            }
            .padding(5)
            HStack {
                Image("twitterIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["twitter"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                            // Check if the Twitter app is installed on the device
                        if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
                                // Open the Twitter app on the account
                            UIApplication.shared.open(URL(string: "twitter://user?screen_name=\(chatData.data["twitter"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If the Twitter app is not installed, open the account in the browser
                            UIApplication.shared.open(URL(string: "https://twitter.com/\(chatData.data["twitter"] ?? "")")!, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["twitter"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
            HStack {
                Image("snapchatIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["snap"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                            // Check if the Snapchat app is installed on the device
                        if UIApplication.shared.canOpenURL(URL(string: "snapchat://")!) {
                                // Open the Snapchat app on the account
                            UIApplication.shared.open(URL(string: "snapchat://add/\(chatData.data["snap"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If the Snapchat app is not installed, open the account in the browser
                            UIApplication.shared.open(URL(string: "https://www.snapchat.com/add/\(chatData.data["snap"] ?? "")")!, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["snap"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
         
        } .frame(width: width * 0.5)
      
        
    }
}

struct SocialMediaCardDemo: View {
    @State var chatData = chatMessage(id: "", sender: "", date: "", messageType: "", message: "", data: ["phoneNum": "2245184878", "instagram": "samRidet", "twitter": "god12", "snap": "samr"])
    
    var body: some View {
        SocialMediaCard(chatData: chatData, width: 428, height: 926)
    }
}
struct SocialMediaCard_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaCardDemo()
    }
}
