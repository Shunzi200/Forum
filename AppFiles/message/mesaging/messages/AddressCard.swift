//
//  AddressCard.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct AddressCard: View {
    @State var chatData : chatMessage

    var width : CGFloat
    var height : CGFloat
  
    var body: some View {
        
        VStack(alignment:.leading){
            HStack {
                Text("\(chatData.data["address"] ?? ""), \(chatData.data["address2"] ?? "")\n\(chatData.data["city"] ?? ""), \(chatData.data["state"] ?? "")\n\(chatData.data["zipcode"] ?? ""), \(chatData.data["country"] ?? "") ")
                    .font(.custom("Montserrat-SemiBold", size: 14))
                    .foregroundColor(.white)
                
                
                Spacer()
                Button {
                    UIPasteboard.general.string = "\(chatData.data["address"] ?? ""), \(chatData.data["address2"] ?? "")\n\(chatData.data["city"] ?? ""), \(chatData.data["state"] ?? "")\n\(chatData.data["zipcode"] ?? ""), \(chatData.data["country"] ?? "") "
                } label: {
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.white)
                }
            }
            .padding(5)
        
      
        } .frame(width: width * 0.65)
        
    }
}

struct AddressCardDemo: View {
    @State var chatData = chatMessage(id: "", sender: "", date: "", messageType: "", message: "", data: ["address": "320 W Oakdale Ave", "address2": "2101", "city": "Chicago", "state": "IL", "zipcode": "60657", "country": "United States"])
    
    var body: some View {
        AddressCard(chatData: chatData, width: 428, height: 926)
    }
}

struct AddressCard_Previews: PreviewProvider {
    static var previews: some View {
        AddressCardDemo()
      
    }
}
