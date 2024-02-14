//
//  SocialMediaHandles.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct SocialMediaHandles: View {
    var width : CGFloat
    var height : CGFloat
    @Binding var phoneNum : String
    @Binding var instagram : String
    @Binding var twitter : String
    @Binding var snap : String
    var body: some View {
        VStack{
  
                HStack {
                    Image(systemName: "phone.fill")
                    TextField("Phone Number", text: $phoneNum)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .keyboardType(.phonePad)
                }
                HStack {
                    Image("igIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("Instagram (username only, no @)", text: $instagram)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Image("twitterIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("Twitter (username only)", text: $twitter)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Image("snapchatIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("SnapChat (username only)", text: $snap)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
        }.padding().background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
        
    }
}


struct SocialMediaDemo : View{
    @State var phoneNum = ""
    @State var instagram = ""
    @State var twitter = ""
    @State var snap = ""
    var body: some View{
        SocialMediaHandles(width: 428, height: 926, phoneNum: $phoneNum, instagram: $instagram, twitter: $twitter, snap: $snap)
    }
}
struct SocialMediaHandles_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaDemo()
    }
}
