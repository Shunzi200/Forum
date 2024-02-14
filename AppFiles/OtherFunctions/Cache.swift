//
//  Cache.swift
//  Looper
//
//  Created by Samuel Ridet on 10/2/22.
//

import SwiftUI

import SDWebImageSwiftUI

import Kingfisher

import SwiftUI
import Kingfisher

struct UrlImageView: View {
    var urlString: String
    
    var body: some View {
    
        if let url = URL(string: urlString) {
            KFImage(url)
                .resizable()
                .scaledToFit()
          
        }else{
            Color("grayBackground")
        }
   
    }
}




