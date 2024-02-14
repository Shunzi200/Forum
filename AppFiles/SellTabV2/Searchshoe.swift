//
//  Searchshoe.swift
//  Looper
//
//  Created by Samuel Ridet on 1/6/23.
//

import SwiftUI

    //
    //  SearchBar.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 1/6/23.
    //

import SwiftUI
import InstantSearchSwiftUI
import InstantSearch
import FirebaseAnalytics

struct SearchShoe: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @ObservedObject var hitsController: HitsObservableController<JSONItem>
    @State var placeHolderImage : String
    @State var placeHolderText : String
    @Binding var productName : String
    @Binding var sku : String
    @Binding var defaultPicture : String

    var onSubmit: (() -> Void)?
    var body: some View {
        
        
        ZStack(alignment: .leading) {
            ZStack (alignment: .trailing){
              
                    TextField("Search by name or SKU", text: $text, onEditingChanged: { isEditing in
                        self.isEditing = isEditing
                    }, onCommit: {
                        if text != "" {
                            print(text)
                            self.onSubmit?()
                            Analytics.logEvent("item_search", parameters: [:
                                                                              ])
                        }
                        
                    }) .onChange(of: text) { newText in
                        if newText != "" && newText.count >= 4 {
                            self.onSubmit?()
                            Analytics.logEvent("item_search", parameters: [:
                                                                          ])
                        }
                    } .foregroundColor(.primary)
                        .submitLabel(.search)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(height: 50))
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                    
                    Button(action: {
                        self.text = ""
                        self.hitsController.hits = []
                        self.productName = ""
                        self.sku = ""
                        self.defaultPicture = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                   
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
                            .foregroundColor(.white)
                            .background(.black)
                    }.padding()
                
            }
            
                ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(.white)
                .font(.custom("Montserrat-Bold", size: 15))
                .background(.black)
                .padding(EdgeInsets(top: 0, leading:15, bottom: 50, trailing: 0) )
            
        }.padding(.horizontal)
         
  

    }
}

/*
struct SearchShoeDemo: View{
    @State var text = ""
    @State var isEditing = false
    let algoliaController = AlgoliaController()
    var body: some View{
        SearchShoe(text: $text, isEditing: $isEditing, hitsController: algoliaController.hitsController, placeHolderImage: "", placeHolderText: "Search Item", productName: $text, sku: $text)
    }

}

struct Searchshoe_Previews: PreviewProvider {
    static var previews: some View {
        SearchShoeDemo()
    }
}
 */
