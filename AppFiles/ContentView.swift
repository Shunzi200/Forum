import SwiftUI
import InstantSearch
import InstantSearchSwiftUI
import FirebaseCore
import Firebase

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @EnvironmentObject private var authModel: AuthViewModel
    @EnvironmentObject var firestoreConnector: FirebaseConnector
    @EnvironmentObject var appState : AppState
    
    @StateObject var algoliaController = AlgoliaController()
    @StateObject var algoliaControllerAccount = AlgoliaControllerAccount()

    
    @State var images: [UIImage] = []
    @State var launch = true
    @State var tabIndex: Tab = .home

    @State var option1 = 1
    @State var option2 = 2
    @State var otherMember : String?
    @State var showConfirmation = false
    @State var query = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                
              
                if Auth.auth().currentUser?.uid != nil {
                
                    if authModel.isNewAppleUser || authModel.userAppleUsername{
                        thirdPartyUsername(apple: true)
                    }else if authModel.emailVerified{
                        VStack(spacing: 0) {
                         
                            NavigationLink(destination: AllMessages(option: $option1) , isActive: $appState.offer) {
                                
                            }
              
                            NavigationLink(destination: AllMessages(option: $option2) , isActive: $appState.sentOffers) {
                                
                            }
                            
                            NavigationLink(destination: ChatView(chatID: appState.chatID) , isActive: $appState.showChat) {
                                
                            }
                            
                            
                            NavigationLink(destination: sellPart2(images: $images, sku: $appState.sku, name: $appState.name, query: $query, defaultPicture: $appState.defaultImage, hitsController: HitsObservableController(), showConfirmation: $showConfirmation) , isActive: $appState.showSell) {
                                
                            }
                           if tabIndex == .home {

                                    Home(launch: $launch, searchBoxController: algoliaController.searchBoxController,
                                         hitsController: algoliaController.hitsController, searchBoxControllerAccount: algoliaControllerAccount.searchBoxController, hitsControllerAccount: algoliaControllerAccount.hitsController)
                                    .transition(.scale)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                               
                            } else if tabIndex == .sell {
                                SellMain(images: $images)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            } else if tabIndex == .search {
                                SalesMain()
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            } else if tabIndex == .account {
                                Account()
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }
                            Tabs(tabIndex: self.$tabIndex, width: geometry.size.width)
                                .frame(height: geometry.size.height * 0.1)
                        }
                        .edgesIgnoringSafeArea(.bottom)
                    }else{
                        emailConfirmation()
                    }
                } else {
                    SignIn()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                     
                }
            }.opacity(showConfirmation ? 0.6: 1)
                .transition(.opacity) .overlay{
                if showConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Listing Successful", bodytext: "Your item has been listed successfully.", showConfirmation: $showConfirmation)
                    
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
       
     
 
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let algoliaController = AlgoliaController()
    static let algoliaControllerAccount = AlgoliaControllerAccount()
    @State static var b = false
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
