//
//  SentOffersList.swift
//  Looper
//
//  Created by Samuel Ridet on 4/1/23.
//

import SwiftUI

struct SentOffersList: View {

        @EnvironmentObject var firestoreConnector : FirebaseConnector

        var body: some View {
            GeometryReader{geometry in
                VStack{
                    
                    ScrollView(showsIndicators: false) {
                        if(firestoreConnector.sentOffers.count == 0){
                            Spacer()
                            HStack{
                                Spacer()
                                Text("You have not sent \n        any offers.")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                Spacer()
                            }
                            Spacer()
                        }
                        VStack(spacing: 10){
 
                            ForEach(firestoreConnector.sentOffers) { list in
                                
                                SentOffer(Off: list, width: geometry.size.width, height: geometry.size.height)
    
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }  .onAppear{
                    firestoreConnector.pullSentOffers()
                    
                }
                
            }
            
            
            
            
        }
    
}

struct SentOffersList_Previews: PreviewProvider {
    @State static var off  = false
    static var previews: some View {
        SentOffersList()
    }
}
