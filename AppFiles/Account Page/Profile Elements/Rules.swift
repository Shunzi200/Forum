//
//  Rules.swift
//  Looper
//
//  Created by Samuel Ridet on 5/25/23.
//

import SwiftUI

struct Rules: View {
    @State private var selectedTab = 0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{geometry in

                VStack{
               
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }).padding(.trailing)
                            VStack(alignment: .leading) {
                                Text("Our Community Rules")
                                    .font(.custom("Montserrat-Bold", size: 20))
                                    .foregroundColor(.white)
                                Text("Building a Safe Community Together")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    
                  
                    TabView(selection: $selectedTab) {
                
               
                        VStack {
                            Image("rule2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                          
                                .clipped()
                            Text("Be kind")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.white)
                            Text("Since the start, Forum has always been a community-oriented platform which aims to connect buyers and sellers while allowing for opportunities past simply business and networking services.\n\n Please treat each other as equal and essential part of our community. In other words, be kind to one another!")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }       .padding(.horizontal,10)
                        .tabItem {
                            EmptyView() // Empty view, as we want to use a custom tab item view
                        }
                        .tag(0)
                        
                        
                        VStack {
                            Image("rule7")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                                .clipped()
                            Text("Do not scam")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.white)
                            Text("We present a networking platform in a niche industry with lots of entrepreneurship, passion, and motivation. This is a place for growth, respect, and good business only.\n\n DO NOT attempt to scam other members. Such actions will result in disclosure of any and all available information connected to your digital identity to victims, law enforcement, or other parties for investigative purposes.")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        } .padding(.horizontal,10)
                            .tabItem {
                                EmptyView() // Empty view, as we want to use a custom tab item view
                            }
                            .tag(1)
                        
                        
                        VStack {
                            Image("rule5")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                                .clipped()
                            Text("Only sell related items")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.white)
                            Text("Conduct appropriate forms of business suitable to available categories. DO NOT attempt to sell unrelated products on the platform.\n\n If you want to ask about a product outside of sneakers, apparel, or accessories, please DM our staff. This includes products and services.\n\nNO NSFW content.")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        } .padding(.horizontal,10)
                            .tabItem {
                                EmptyView() // Empty view, as we want to use a custom tab item view
                            }
                            .tag(3)
                        
                        VStack {
                            Image("rule8")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                                .clipped()
                            Text("Be respectful")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.white)
                            Text("DO NOT engage in trolling within the app. Avoid wasting each others time.\n\n If you disagree with the seller/buyer about the condition, price, etc. with no mutual ground to continue negotiating, please move on.")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        } .padding(.horizontal,10)
                        .tabItem {
                            EmptyView() // Empty view, as we want to use a custom tab item view
                        }
                        .tag(4)
                        
                  
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default tab index
                    .padding(.vertical, 10)
                    
                        // Custom index view
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Circle()
                                .foregroundColor(index == selectedTab ? .white : .gray)
                                .frame(width: 8, height: 8)
                        }
                    }
  
                }
          
                
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
           
                .navigationBarTitleDisplayMode(.inline)
                .padding(10)
                .onAppear {
                        // Disable back swipe gesture
                    UINavigationController().interactivePopGestureRecognizer?.isEnabled = false
                }
             
           

            
        }
  
    }
}

struct Rules_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Rules()
        }
  
    }
}
