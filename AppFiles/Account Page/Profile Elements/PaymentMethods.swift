//
//  PaymentMethods.swift
//  Looper
//
//  Created by Samuel Ridet on 12/23/22.
//

import SwiftUI

struct PaymentMethods: View {
    var width : CGFloat
    var height : CGFloat
    @Binding var zelle : String
    @Binding var venmo : String
    @Binding var cashapp : String
    @Binding var paypal : String
    var images = ["zelleIcon","venmoIcon","cashappIcon","paypaIcon"]
    var txt = ["Zelle","Venmo","CashApp","PayPal"]

    var body: some View {
        
        VStack{

                HStack {
                    Image("zelleIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("Zelle", text: $zelle)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Image("venmoIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("Venmo", text: $venmo)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Image("cashappIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("CashApp", text: $cashapp)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
                HStack {
                    Image("paypaIcon")
                        .resizable()
                        .frame(width: width / 25, height: width / 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("PayPal", text: $paypal)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
            
        }.padding().background(RoundedRectangle(cornerRadius: 10).foregroundColor(CustomColor.grayBackground))
    }
}


struct PaymentMethodsDemo : View{
    @State var zelle = ""
    @State var venmo = ""
    @State var cashapp = ""
    @State var paypal = ""
    var body: some View{
        PaymentMethods(width: 428, height: 926, zelle: $zelle, venmo: $venmo, cashapp: $cashapp, paypal: $paypal)
    }
}

struct PaymentMethods_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodsDemo()
    }
}
