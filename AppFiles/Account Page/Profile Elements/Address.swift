//
//  Address.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct Address: View {
    var width : CGFloat
    var height : CGFloat
    @Binding var address : String
    @Binding var address2 : String
    @Binding var state : String
    @Binding var zipcode : String
    @Binding var country : String
    @Binding var city : String
    var body: some View {
        VStack{
 
                HStack {
                    Text("Address: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("123 Apple St", text: $address)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Text("Address 2: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("Apt 22", text: $address2)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Text("City: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("Chicago", text: $city)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Text("Zip Code: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("60689", text: $zipcode)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Text("State: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("IL", text: $state)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
           
                HStack {
                    Text("Country: ")
                        .font(.custom("Montserrat-Regular", size: 15))
                    TextField("United States", text: $country)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
        }.padding().background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
    }
}


struct AddressDemo : View{
    @State var address = ""
    @State var address2 = ""
    @State var state = ""
    @State var zipcode = ""
    @State var country = ""
    @State var city = ""
    var body: some View{
        Address(width: 428, height: 926, address: $address, address2: $address2, state: $state, zipcode: $zipcode, country: $country, city: $city)
    }
}
struct Address_Previews: PreviewProvider {
    static var previews: some View {
        AddressDemo()
    }
}
