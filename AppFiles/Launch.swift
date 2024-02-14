//
//  Launch.swift
//  Looper
//
//  Created by Samuel Ridet on 3/28/23.
//

import SwiftUI

struct Launch: View {

    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            Image("finallogo-1024")
                .resizable()
                .frame(width: 200, height: 200)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Launch_Previews: PreviewProvider {
    static var previews: some View {
        Launch()
    }
}
