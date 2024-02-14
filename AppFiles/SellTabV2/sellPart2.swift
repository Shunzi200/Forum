//
//  sellPart2.swift
//  Looper
//
//  Created by Samuel Ridet on 4/10/23.
//

import SwiftUI
import InstantSearchSwiftUI

struct sellPart2: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var images : [UIImage]
    @Binding var sku : String
    @Binding var name : String
    @Binding var query : String
    @Binding var defaultPicture : String
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @ObservedObject var hitsController : HitsObservableController<JSONItem>
    @Binding var showConfirmation : Bool
    
    @State var bulk = false
    @State var price = ""
    @State var size = ""
    @State var cat = ""
    @State var condition = "New"
    @State var delivery = "Shipping"
    @State var shippingPrice = ""
    @State var city = ""
    @State var state = ""
    
  
    
    var body: some View {
        GeometryReader {geometry in
 
                VStack{
                    if !bulk{
                        ItemSell(images: $images, sku: $sku, name: $name, query: $query, defaultPicture: $defaultPicture, hitsController: hitsController, showConfirmation: $showConfirmation)
                    }else{
                        BulkSell(images: $images, sku: $sku, name: $name, query: $query, defaultPicture: $defaultPicture, hitsController: hitsController, showConfirmation: $showConfirmation)
                        
                    }
                }.navigationBarItems(leading: CustomSegmentedPickerViewSell(selection: $bulk, width: geometry.size.width * 0.4, height: geometry.size.height)
                    .navigationBarTitleDisplayMode(.inline)
                           
            )
        }.onDisappear{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
  
    }
}

struct sellPart2_Previews: PreviewProvider {
 
        @State static var t = "Jordan"
        @State static var im = [UIImage(named: "DunkPanda4") ?? UIImage(),UIImage(named: "DunkPanda5") ?? UIImage(),UIImage(named: "DunklPanda3") ?? UIImage()]
        @State static var show = false
        static var previews: some View {
            NavigationView{
                sellPart2(images: $im,sku: $t, name: $t, query: $t, defaultPicture: $t, hitsController: HitsObservableController<JSONItem>(), showConfirmation: $show)
                    .environmentObject(FirebaseConnector())
            }
        }
    
}
