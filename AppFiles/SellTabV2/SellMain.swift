//
//  SellMain.swift
//  Looper
//
//  Created by Samuel Ridet on 2/8/23.
//

import SwiftUI

struct SellMain: View {
    
    @Binding var images : [UIImage]
    @State var page = 0
    @StateObject var algoliaController = AlgoliaController()
    @StateObject var itemSearchConnector = itemSearch()
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        NavigationView {
            GeometryReader {geometry in
                VStack {
                    TabBarSales(selectedIndex: $page, titles: ["Listing", "Post"], width: geometry.size.width)
                        .onAppear{
                            firestoreConnector.fetchAccount {
                                
                            }
                        }
                    
                    if page == 0{
                        ListingMain(images: $images, searchBoxController: algoliaController.searchBoxController, hitsController: algoliaController.hitsController)
                    }else{
                        PostMain(images: $images)
                    }
                    
                }
            }
        }
    }
}



struct SellMain_Previews: PreviewProvider {
    @State static var images : [UIImage] = []
    static var previews: some View {
        SellMain(images: $images)
            .environmentObject(FirebaseConnector())
    }
}
