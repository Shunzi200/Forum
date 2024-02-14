//
//  TabSwitcher.swift
//  Looper
//
//  Created by Samuel Ridet on 12/12/22.
//

import SwiftUI

struct TabSwitcher: View {
    @State var currentTab : Int = 0
    var body: some View {
        ZStack{
            TabView(selection: $currentTab) {
                FollowingPage().tag(0)
                Text("Bye").tag(1)
            }.tabViewStyle(.page(indexDisplayMode: .never))
            
            TabSwitcherView(currentTab: $currentTab)
                
        }
    }
}

struct TabSwitcherView: View{
    
    @Binding var currentTab : Int
    
    var tabOptions = ["Connections", "Feed"]
    
    var body: some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20){
                ForEach(Array(zip(self.tabOptions.indices, self.tabOptions)), id: \.0, content: {
                    index, name in
                    TabSwitcherItem(currentTab: self.$currentTab, tabitemName: name, tab: index)
                })
            }
            
        }
        .background(Color.white)
        .frame(height: 80)
    }
}


struct TabSwitcherItem : View{
    @Binding var currentTab : Int
    
    var tabitemName : String
    var tab : Int
    
    
    var body: some View{
        Button {
            self.currentTab = tab
        } label: {
            VStack{
                Spacer()
                Text(tabitemName)
            }
        }

        
    }
}

struct TabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        TabSwitcher()
    }
}
