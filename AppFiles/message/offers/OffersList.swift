//
//  OffersList.swift
//  Looper
//
//  Created by Samuel Ridet on 12/18/22.
//

import SwiftUI

struct OffersList: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
   
    @Binding var offerSelect : Bool
    @State var showingOne = false
    @Binding var option : Int
    var body: some View {
        GeometryReader{geometry in
            VStack{
                
                ScrollView(showsIndicators: false) {
                    if(firestoreConnector.offers.count == 0){
                        Spacer()
                        HStack{
                            Spacer()
                            Text("You have not received \n        any new offers.")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack(spacing: 15){
                        
                        
                        
                        ForEach(firestoreConnector.offers) { list in
                            if list.offers.count > 0{
                                OfferItemView(listingId: list.id, offerAr: list.offers, width: geometry.size.width, height: geometry.size.height, offerMainAr: $firestoreConnector.offers, offerSelect: $offerSelect, option: $option)
                                    //.frame(height: geometry.size.height / 6)
                                    .padding(.horizontal, 5)
                                    .onAppear{
                                        self.showingOne = true
                                    }
                            }
                            
                            
                        }
                        
                        
                    }
                    
                   
                }
                
            }  .onAppear{
                firestoreConnector.pullOffers()
                
            }
            
        }
        
        
        
        
    }
}

//struct OffersList_Previews: PreviewProvider {
 //   static var previews: some View {
        //OffersList(, offerSelect: )
          //  .environmentObject(FirebaseConnector())
 //   }
//}
