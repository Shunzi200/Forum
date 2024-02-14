//
//  ListingMain.swift
//  Looper
//
//  Created by Samuel Ridet on 2/8/23.
//

import SwiftUI
import InstantSearchSwiftUI

struct ListingMain: View {
    @Binding var images : [UIImage]
    @StateObject var firestoreConnector = FirebaseConnector()
    @ObservedObject var searchBoxController: SearchBoxObservableController
    @ObservedObject var hitsController: HitsObservableController<JSONItem>
    @StateObject var itemSearchConnector = itemSearch()

    @State var query = ""
    @State var productName = ""
    @State var productSKU = ""
    @State var defaultPicture = ""
    
    @State var isTyping = false
    @State var bulk = false
    @State var showConfirmation = false
    @State var active = false
    var body: some View {
        GeometryReader {geometry in
            
            ZStack {
                VStack (spacing: 0){
                        ScrollView (showsIndicators: false) {
                            VStack{
                                HStack {
                                    Spacer()
                             
                                        ImageViewPicker(images: $images, listing:true, bulk: $bulk, width: geometry.size.width, height: geometry.size.height, defaultPicture: $defaultPicture)
                                            .padding(.horizontal, 5)
                        
                              
                                    Spacer()
                                }
                                SearchShoe(text: $searchBoxController.query, isEditing: $isTyping, hitsController: self.hitsController, placeHolderImage: "", placeHolderText: "Search Item", productName: $productName, sku: $productSKU, defaultPicture: $defaultPicture, onSubmit: self.searchBoxController.submit)
                                    .onSubmit{
                                    
                                        //self.hitsController.hits = []
                                    }
                                
                                
                                if (hitsController.hits.count == 0){
                                    
                                    Text("No results found")
                                        .foregroundColor(.white)
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                    
                                }else{
                                    ForEach(hitsController.hits, id: \.?.styleID) { hit in
                                        
                                        if hit?.thumbnail ?? "" != "https://stockx-assets.imgix.net/media/Product-Placeholder-Default-20210415.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=0"{
                                            SellSearchResult(hit: hit, productName: $productName, sku: $productSKU, text: $searchBoxController.query, defaultPicture: $defaultPicture, width: geometry.size.width, height: geometry.size.height)
                                        }
                                      
                                        
                                        
                                    }
                                }
                                
                            }
                        
                    }.onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                        Spacer()
                        
                       
                    NavigationLink(destination: sellPart2(images: $images, sku: $productSKU, name: $productName, query: $searchBoxController.query, defaultPicture: $defaultPicture, hitsController: hitsController, showConfirmation: $showConfirmation), isActive: $active) {
                        Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            if !productSKU.isEmpty && !(images.isEmpty && defaultPicture.isEmpty){
                                active = true
                            }
                          
                        } label: {
                            ZStack{
                                Capsule()
                                    .foregroundColor((productSKU.isEmpty || (images.isEmpty && defaultPicture.isEmpty)) ? .gray : .white)
                                    .frame(width: geometry.size.width*0.9, height: geometry.size.width * 0.12)
                                Text("Next")
                                
                                
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .padding(10)
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .disabled(productSKU.isEmpty || (images.isEmpty && defaultPicture.isEmpty))
                            .padding(.bottom, 10)
                        } .disabled(productSKU.isEmpty || (images.isEmpty && defaultPicture.isEmpty))

                                
                            
                        
                } .opacity(showConfirmation ? 0.6: 1)
                    .transition(.opacity)
                    .navigationBarTitle("", displayMode: .inline)
                    .onAppear{
           
                        self.productName = ""
                        self.productSKU = ""

                    }.onDisappear{
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
                if showConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Listing Successful", bodytext: "Your item has been listed successfully.", showConfirmation: $showConfirmation)
                      
                }
            }
                
        }
    }
}

/*
struct ListingMain_Previews: PreviewProvider {
    @State static var images: [UIImage] = []
    @StateObject static var algoliaController = AlgoliaController()
    static var previews: some View {
        ListingMain(images: $images, itemSearchConnector: itemSearch())
    }
}

*/
