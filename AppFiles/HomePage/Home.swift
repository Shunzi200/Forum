    //
    //  Home.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/14/22.
    //

import SwiftUI
import InstantSearchSwiftUI
import InstantSearch
import FirebaseMessaging

struct Home: View {
    @State private var showingPopover = false
    @State private var searchText = ""
    @State var splitSearchText = [String]()
    @State var Feed = true
    @State var shoeSearch = true
    @State var isEditing = false
    @Binding var launch : Bool
    @EnvironmentObject private var authModel : AuthViewModel
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    
    @ObservedObject var searchBoxController: SearchBoxObservableController
    @ObservedObject var hitsController: HitsObservableController<JSONItem>
    @ObservedObject var searchBoxControllerAccount: SearchBoxObservableController
    @ObservedObject var hitsControllerAccount: HitsObservableController<algoliaUser>

    @StateObject var itemSearchConnector = itemSearch()
    
    @State var complete = true
    
    @State var shoequery = ""
    
    @State var option = 0
    
    var body: some View {
        
        GeometryReader {geometry in
  
                VStack{
                        HStack{
              
                        Image("logo1black")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.1)
  
                            
                            if shoeSearch{
                                SearchBar(text: $searchBoxController.query, text2: $searchBoxControllerAccount.query,
                                          isEditing: $isEditing, itemSearchConnector: itemSearchConnector,
                                          hitsController: self.hitsController, hitsControllerAccount: self.hitsControllerAccount, onSubmit: searchBoxController.submit, shoeSearch: $shoeSearch)
                                
                             
                        }else{
                               SearchBar(text: $searchBoxControllerAccount.query,text2: $searchBoxController.query,
                                        isEditing: $isEditing, itemSearchConnector: itemSearchConnector,
                                         hitsController: self.hitsController, hitsControllerAccount: self.hitsControllerAccount, onSubmit: searchBoxControllerAccount.submit, shoeSearch: $shoeSearch)
                              
                           }
                  
                 
                            NavigationLink(destination: AllMessages(option: $option)){
                             
                                ZStack {
                                    Image(systemName: "message")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                   if (firestoreConnector.notificationsData.messages + firestoreConnector.notificationsData.offers) > 0 {
                                    Text("\(firestoreConnector.notificationsData.messages + firestoreConnector.notificationsData.offers)")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x: 12, y: -12)
                                    }
                                }
                                    
                            }
                        }
                        
                        .padding([.top, .leading, .trailing])
                    
                        
                    if searchBoxController.query.isEmpty && self.searchBoxControllerAccount.query.isEmpty{
                            
                        ZStack (alignment: .top){
                            
                            if Feed{
                                FeedPage()
                             
                                
                            }else{
                                FollowingPage()
                            }
                            HStack {
                                Spacer()
                                Button {
                                  
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    self.Feed.toggle()
                                } label: {
                                    Text("Follow")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .foregroundColor(Feed ? .gray : .white)
                                        .padding(.horizontal)
                                }
                                
                                Button {
                          
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    self.Feed.toggle()
                                } label: {
                                    Text("Feed")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .foregroundColor(Feed ?  .white : .gray)
                                    
                                        .padding(.horizontal)
                                    
                                }
                                Spacer()
                            }.padding(.bottom)
                        }

                    }else{
                        ZStack (alignment: .top){
                            
                            if shoeSearch{
                                VStack{
                                    
                                    ScrollView(showsIndicators: false){
                                        Spacer(minLength: 25)
                                        if (hitsController.hits.count == 0){
                                   
                                            Text("No results found")
                                                .foregroundColor(.white)
                                                .font(.custom("Montserrat-SemiBold", size: 15))
                                                .padding(.vertical)
                                            
                                        }else{
                                            ForEach(hitsController.hits, id: \.?.styleID) { hit in
                                                
                                                if hit?.thumbnail ?? "" != "https://stockx-assets.imgix.net/media/Product-Placeholder-Default-20210415.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&trim=color&q=90&dpr=2&updated_at=0" {
                                                    SearchResultsStruct(prod: hit, width: geometry.size.width, height: geometry.size.height)
                                            
                                                }
                                                
                                                
                                                
                                            }
                                        }
                                        Spacer(minLength: 15)
                                    }
                                }
                            }else{
                                VStack{
                                    HitsList(hitsControllerAccount) { (userhit, _) in
                                        Spacer(minLength: 25)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            
                                            if userhit?.username != "User not found"{
                                                AccountResultStruct(user: userhit, width: geometry.size.width, height: geometry.size.height)
                                            }
                                            
                                            
                                        }
                                        Spacer(minLength: 15)
     
                                        
                                    } noResults: {
                                        
                                        ScrollView(showsIndicators: false){
                                            Spacer(minLength: 25)
                                            VStack {
                                                
                                                Text("No results found")
                                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                                    .padding(.vertical)
                                                
                                            }  }   .onTapGesture {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                    }
                                    
                                    
                                }
                            }
                            HStack {
                                Button {
                                   
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    self.shoeSearch.toggle()
                                } label: {
                                    
                                    Text("User")
                                        .bold()
                                        .foregroundColor(shoeSearch ? .gray : .white)
                                    
                                        .padding([.leading,.trailing])
                                }
                                
                                Button {
                     
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    self.shoeSearch.toggle()
                                } label: {
                                    Text("Item")
                                        .bold()
                                        .foregroundColor(shoeSearch ?  .white : .gray)
                                    
                                        .padding([.leading,.trailing])
                                    
                                }
                            }
                            
                        }
                    }
                    
                    
                }     .fullScreenCover(isPresented: $authModel.justsignedUp, content: {
                    tutorialView()
                })
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .background(.black)
                    .onAppear{
                        
                        if !launch{
                           
                            firestoreConnector.feedPull{
                            }
                            firestoreConnector.fetchAccount {
                                
                            }
                        }
                       firestoreConnector.retrieveNotifications()
                        self.launch = false

                }
        }
            
        
        
    }
    
    
}



struct Home_Previews: PreviewProvider {
    static let algoliaController = AlgoliaController()
    static let algoliaControllerAccount = AlgoliaControllerAccount()
    @State static var launch = false
    static var previews: some View {
        Home(launch: $launch, searchBoxController: algoliaController.searchBoxController,
             hitsController: algoliaController.hitsController, searchBoxControllerAccount: algoliaControllerAccount.searchBoxController,
             hitsControllerAccount: algoliaControllerAccount.hitsController)
            .environmentObject(FirebaseConnector())
    }
}
