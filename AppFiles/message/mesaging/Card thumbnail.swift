//
//  Card thumbnail.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct SocialMediaCard_thumbnail: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .foregroundColor(.pink)
                .font(.system(size: 13))
            Text("Social")
                .foregroundColor(.white)
                .font(.custom("Montserrat-SemiBold", size: 13))
        }.padding([.top, .bottom],5)
            .padding([.trailing, .leading],10)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
    }
}
struct PaymentCard_thumbnail: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    var body: some View {
        HStack{
            Image(systemName: "creditcard")
                .foregroundColor(.blue)
                .font(.system(size: 13))
            Text("Payment")
                .foregroundColor(.white)
                .font(.custom("Montserrat-SemiBold", size: 13))
        }.padding([.top, .bottom],5)
            .padding([.trailing, .leading],10)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
    }
}
struct AddressCard_thumbnail: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    var body: some View {
        HStack{
            Image(systemName: "house.fill")
                .foregroundColor(.green)
                .font(.system(size: 13))
            Text("Address")
                .foregroundColor(.white)
                .font(.custom("Montserrat-SemiBold", size: 13))
        }.padding([.top, .bottom],5)
            .padding([.trailing, .leading],10)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
    }
}

struct SaleCard_thumbnail: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    var body: some View {
        HStack{
            Image(systemName: "dollarsign.circle")
                .foregroundColor(CustomColor.mainPurple)
                .font(.system(size: 13))
            Text("Log")
                .foregroundColor(.white)
                .font(.custom("Montserrat-SemiBold", size: 13))
        }.padding([.top, .bottom],5)
            .padding([.trailing, .leading],10)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
    }
}

struct RateCard_thumbnail: View {
    @StateObject var firestoreConnector = FirebaseConnector()
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
           
                .font(.system(size: 13))
            Text("Rate")
                .foregroundColor(.white)
                .font(.custom("Montserrat-SemiBold", size: 13))
        }.padding([.top, .bottom],5)
            .padding([.trailing, .leading],10)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.grayBackground))
    }
}
struct Card_thumbnail_Previews: PreviewProvider {
    static var previews: some View {
        RateCard_thumbnail()
            .environmentObject(FirebaseConnector())
    }
}
