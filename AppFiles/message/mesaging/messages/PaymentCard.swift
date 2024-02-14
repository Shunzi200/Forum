//
//  PaymentCard.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct PaymentCard: View {
    @State var chatData : chatMessage
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        
        VStack(alignment:.leading){
            HStack {
                Image("zelleIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["zelle"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
             
            
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["zelle"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
            HStack {
                Image("venmoIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["venmo"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                            // Check if the Venmo app is installed on the device
                        if UIApplication.shared.canOpenURL(URL(string: "venmo://?$\(chatData.data["venmo"] ?? "")")!) {
                                // Open the Venmo app on the account
                            UIApplication.shared.open(URL(string: "venmo://?$\(chatData.data["venmo"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If the Venmo app is not installed, open the account in the browser
                            UIApplication.shared.open(URL(string: "https://venmo.com/\(chatData.data["venmo"] ?? "")")!, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["venmo"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
                
            }
            .padding(5)
            HStack {
                Image("cashappIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["cashapp"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .underline()
                    .onTapGesture {
                            // Check if the Cash App is installed on the device
                        if UIApplication.shared.canOpenURL(URL(string: "cashapp://")!) {
                                // Open the Cash App on the account
                            UIApplication.shared.open(URL(string: "cashapp://?$\(chatData.data["cashapp"] ?? "")")!, options: [:], completionHandler: nil)
                        } else {
                                // If the Cash App is not installed, open the account in the browser
                            UIApplication.shared.open(URL(string: "https://www.cash.app/\(chatData.data["cashapp"] ?? "")")!, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["cashapp"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
            HStack {
                Image("paypaIcon")
                    .resizable()
                    .frame(width: width / 20, height: width / 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("\(chatData.data["paypal"] ?? "")")
                    .foregroundColor(.white)
                    .font(.custom("Montserrat-SemiBold", size: 14))
                 

                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["paypal"] ?? "")"
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
        }.frame(width: width * 0.5)
       
    }
}

struct PaymentCardDemo: View {
    @State var chatData = chatMessage(id: "", sender: "", date: "", messageType: "", message: "", data: ["zelle": "2245184878", "venmo": "samRidet", "cashapp": "god12", "paypal": "shunzi.fpv@gmail.com"])
    
    var body: some View {
        PaymentCard(chatData: chatData, width: 428, height: 926)
    }
}

struct PaymentCard_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCardDemo()
    }
}
