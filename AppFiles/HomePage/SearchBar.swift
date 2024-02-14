import SwiftUI
import InstantSearchSwiftUI
import InstantSearch
struct SearchBar: View {
    @Binding var text: String
    @Binding var text2 : String
    @Binding var isEditing: Bool
    
    @ObservedObject var itemSearchConnector : itemSearch
    @ObservedObject var hitsController: HitsObservableController<JSONItem>
    @ObservedObject var hitsControllerAccount: HitsObservableController<algoliaUser>
    
    var onSubmit: (() -> Void)?
    @Binding var shoeSearch : Bool
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.caption)
                
                TextField("Search", text: $text, onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                }, onCommit: {
                    print(text)
                
                    if text != "" {
                        if shoeSearch{
                      
                            self.hitsController.hits = []
                        }else{
                            self.hitsControllerAccount.hits = []
          
                        }
                        self.onSubmit?()

                    }
                    
                }).onChange(of: text) { newText in
                
                    if newText != "" && newText.count >= 4 {
                        self.onSubmit?()
                    }
                }.foregroundColor(.primary)
                    .submitLabel(.search)
                    .font(.custom("Montserrat-Regular", size: 13))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Button(action: {
                    self.text = ""
                    self.text2 = ""
                    self.hitsControllerAccount.hits = []
                    self.hitsController.hits = []
                    self.shoeSearch = true
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
                        .font(.body)
                    
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .font(.custom("Montserrat-Regular", size: 13))
            .background(CustomColor.grayBackground)
            .cornerRadius(10.0)
            
            
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
    }
}
