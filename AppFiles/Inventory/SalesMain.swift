//
//  Search.swift
//  Looper
//
//  Created by Samuel Ridet on 8/14/22.
//

import SwiftUI
import Foundation

import FirebaseStorage


struct SalesMain: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @State var imageURL : String = ""
    @State var index = 0
    @State var selectedIndex = 0
    
    var titles = ["Overall", "Sales", "Purchases"]
    
    var body: some View {
        GeometryReader {geometry in

            VStack {
                TabBarSales(selectedIndex: $selectedIndex, titles: titles, width: geometry.size.width)
                    .frame(width: geometry.size.width)
                    .padding([.bottom], 5)
               
           
                
                if selectedIndex == 0{
                    Lifetime()
                    

                }else if selectedIndex == 1{
                    SalePage()
                   
                }else if selectedIndex == 2{
                    PurchasePage()
                 
                       
                }
    
            } 
        }
    }
    

    
   
}



struct Search_Previews: PreviewProvider {
    
    static var previews: some View {
        SalesMain()
            .environmentObject(FirebaseConnector())
          
    }
    
}

