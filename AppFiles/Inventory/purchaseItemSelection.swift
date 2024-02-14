//
//  purchaseItemSelection.swift
//  Looper
//
//  Created by Samuel Ridet on 4/12/23.
//

import SwiftUI

struct purchaseItemSelection: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Binding var showConfirmation : Bool
   
    @State var exitNext = false
    var body: some View {
        GeometryReader{geometry in
            VStack{
                
                if firestoreConnector.potentialPurchases.count == 0{
                    Spacer()
                    HStack{
                        Spacer()
                        Text("No potential purchases")
                            .font(.custom("Montserrat-Bold", size: 14))
                        Spacer()
                    }
                    Spacer()
                }else{
                    ScrollView(showsIndicators: false) {
                        ForEach(firestoreConnector.potentialPurchases, id: \.id){ listing in
                            
                            if !firestoreConnector.dataToDisplay.logs.contains(listing.id){
                                
                                
                                if listing.atype == "Bulk"{
                                    itemSelectionBarBulk(width: geometry.size.width, height: geometry.size.height, listingData: listing, showConfirmation: $showConfirmation, exitNext: $exitNext, sale: true)
                                }else{
                                    itemSelectionBarListing(width: geometry.size.width, height: geometry.size.height, listingData: listing, showConfirmation: $showConfirmation, exitNext: $exitNext, sale: true)
                                }
                                
                            }
                        }
                    }
                }
            }.onAppear{
                print("pulling from itemselection")
                firestoreConnector.fetchPotentialPurchases()
                
                if exitNext{
                    self.presentation.wrappedValue.dismiss()
                }
            }.onDisappear{
                if exitNext{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        firestoreConnector.fetchAccount {
                            firestoreConnector.pullPurchases(PurchaseID: firestoreConnector.dataToDisplay.purchases)
                        }
                        
                    }
                }
            
            }.navigationBarTitle("Select a listing from your chats", displayMode: .inline)
            
            
        }
    }
}

struct purchaseItemSelection_Previews: PreviewProvider {
    @State static var showConfirmation = false
    static var previews: some View {
        purchaseItemSelection(showConfirmation: $showConfirmation)
    }
}
