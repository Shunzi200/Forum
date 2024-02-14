    //
    //  TabView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/19/22.
    //

import SwiftUI

enum Tab {
    case home
    case sell
    case search
    case account
}

struct Tabs: View {
    @Binding var tabIndex: Tab
    let width : CGFloat
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    var body: some View {
        let iconWidth = width/18
        let iconHeight = width/18

            
                
            VStack (spacing: 0 ){
                Rectangle()
                
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "E042B6"),Color(hex: "9457F5"),Color(hex: "57AFE7")]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 4)
                HStack{
                    TabBarIcon(width: iconWidth, height: iconHeight, systemIconName: tabIndex == .home ? "house.fill" : "house", tabName: "Home")

                        .onTapGesture {
                         
                                self.tabIndex = .home
 
                        }
                    Spacer()
                    TabBarIcon(width: iconWidth, height: iconHeight, systemIconName:tabIndex == .sell ? "dollarsign.circle.fill" : "dollarsign.circle" , tabName: "Sell")
                        .onTapGesture {
                            self.tabIndex = .sell
                  
                        }
                    Spacer()
                    TabBarIcon(width: iconWidth, height: iconHeight, systemIconName: tabIndex == .search ? "list.bullet.circle.fill" : "list.bullet.circle", tabName: "Dash")
                        .onTapGesture {
                            self.tabIndex = .search
                        
                        }
                    Spacer()
                    TabBarIcon(width: iconWidth, height: iconHeight, systemIconName: tabIndex == .account ? "person.fill" : "person", tabName: "Profile")

                        .onTapGesture {
                            self.tabIndex = .account
                       
                        }
                    
                    
                    
                }.padding(.horizontal, 30)
                
 
            }.background(.black)

          
            
    }
}






struct TabBarIcon: View {
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.custom("Montserrat-SemiBold", size: 12))
            Spacer()
        }
        .padding(.horizontal, -4)
        
        
    }
}


struct TabDemo :View{
    @State var tabIndex: Tab = .home
    var body: some View{
        Tabs(tabIndex: $tabIndex, width: 428)
    }
}
struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        TabDemo()
    }
    
}
