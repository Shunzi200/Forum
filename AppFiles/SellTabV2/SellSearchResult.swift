//
//  SellSearchResult.swift
//  Looper
//
//  Created by Samuel Ridet on 1/7/23.
//

import SwiftUI

struct SellSearchResult: View {
    @State var hit : JSONItem?
    @Binding var productName : String
    @Binding var sku : String
    @Binding var text : String
    @Binding var defaultPicture : String
    var width : CGFloat
    var height : CGFloat
    var body: some View {
        HStack{
            UrlImageView(urlString: hit?.thumbnail ?? "" == "https://stockx-assets.imgix.net/media/Product-Placeholder-Default-20210415.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=0" ? "https://www.macmillandictionary.com/external/slideshow/full/White_full.png" : hit?.thumbnail ?? "" )
                .scaledToFit()
                .frame(width: width / 4.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading){
                Text(String(hit?.shoeName ?? " "))
                    .font(.custom("Montserrat-SemiBold", size : 15))
                    .lineLimit(2)
              
                Text("\(hit?.styleID ?? " ")")
                    .lineLimit(1)
                    .font(.custom("Montserrat-Regular", size : 13))
            }
            Spacer()
          
            
        }.background(sku == String(hit?.styleID ?? " ") ? CustomColor.grayBackground : Color.black)
        
            .cornerRadius(8)
            .padding(.horizontal, 2)
            .onTapGesture {
            self.productName = String(hit?.shoeName ?? " ")
            self.text = String(hit?.shoeName ?? " ")
            self.sku = String(hit?.styleID ?? " ")
                self.defaultPicture = String(hit?.thumbnail ?? "")
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

/*
struct SellSearchResultDemo: View {
    @State var hit = StockItem(nameColor: "Jordan 1 White/Yellow", shoeName: "Jordan 1 A Ma Maniere", sku: "DO7097-100", colorway: "White Yellow", releaseDate: "", image: "https://images.stockx.com/images/UGG-Classic-Mini-Lace-Up-Weather-Boot-Dune.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=1636503608" )
    @State var productName = "Jordan 1 A Ma Maniere"
    @State var sku = ""
  
    var body: some View {
        SellSearchResult(hit: hit, productName: $productName, sku: $sku, text: $productName, width: 428, height: 926)
    }
}
struct SellSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SellSearchResultDemo()
    }
}
*/
