//
//  saleItemSelection.swift
//  Looper
//
//  Created by Samuel Ridet on 4/11/23.
//

import SwiftUI

struct saleItemSelection: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Binding var showConfirmation : Bool
    @State var isEditing = false
    @State var exitNext = false
    var body: some View {
        GeometryReader {geometry in
            
            HStack {
                Spacer()
                VStack(spacing: 10){
                        if (firestoreConnector.listings.count == 0 ){
                            Spacer()
                            Text("No items listed")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            Spacer()
                        }else{
                            ScrollView(showsIndicators: false){
                                ForEach(firestoreConnector.listings) {currentListing in
                                    if !firestoreConnector.dataToDisplay.logs.contains(currentListing.id){
                                        
                                   
                                        if currentListing.postType == "Item"{
                                          
                                                itemSelectionBarListing(width: geometry.size.width, height: geometry.size.height, listingData: currentListing, showConfirmation: $showConfirmation, exitNext: $exitNext, sale: false)
                                            
                                                    .frame(width:geometry.size.width * 0.95)
                                            
                                              
                                            
                                        } else if currentListing.postType == "Bulk"{
                                            
                                            
                                            itemSelectionBarBulk(width: geometry.size.width, height: geometry.size.height, listingData: currentListing, showConfirmation: $showConfirmation, exitNext: $exitNext, sale: false)
                                            
                                                .frame(width:geometry.size.width * 0.95)
                                           
                                            
                                        }
                                    }
                                
                                
                            }
                        }
                        
                    }
                    
                }.onAppear{
                    firestoreConnector.fetchAccount {
                        
                    }
                    
                    if exitNext{
                        self.presentation.wrappedValue.dismiss()
                    }
                }.onDisappear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if exitNext{
                            firestoreConnector.fetchAccount {
                                firestoreConnector.pullSales(SaleID: firestoreConnector.dataToDisplay.sales)
                            }
                        }
                        
                    }
                    
                }
                Spacer()
            }.navigationBarTitle("Select an active listing", displayMode: .inline)
        }
    }
}

struct saleItemSelection_Previews: PreviewProvider {
    @State static var showConfirmation = false
    static var previews: some View {
        saleItemSelection(showConfirmation: $showConfirmation)
    }
}
