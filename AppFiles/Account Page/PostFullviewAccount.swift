    //
    //  ListingFullViewAccount.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/27/22.
    //

import SwiftUI

struct PostFullViewAccount: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Environment(\.presentationMode) var presentation
    
    @State var postCaption = " "
    @State var aType = " "
    @State var postID = " "
    @State var username = " "
    
    @State var postData : feedInfo

 
    

    @State var isEditing = false

    
    var body: some View {
        let imageName : [String] = postData.images as? [String] ?? [""]
        GeometryReader { geometry in
            
            ScrollView {
                VStack {
      
                    VStack (spacing: 0){
                        TabView{
                            ForEach(imageName, id: \.self){i in
                                
                                UrlImageView(urlString: i)
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                                    .clipShape(Rectangle())
                                
                            }
                        }
                        
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.5)
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        Rectangle()
                        
                            .foregroundColor(CustomColor.mainBlue)
                            .frame(height: 4)
                    }
          
                    ZStack (alignment: .topLeading){
                        
                        MessageField(text: $postCaption, minHeight: 60)
                            .frame(width: geometry.size.width * 0.95)
                            .foregroundColor(isEditing ? .white : .gray)
                            .disabled(!isEditing)
                        Text("Caption")
                            .font(.custom("Montserrat-Bold", size: 15))
                            .background(.black)
                            .offset(x: 10, y: 2)
                            .foregroundColor(isEditing ? .white : .gray)
                            .disabled(!isEditing)
                    }
              
                
            }

  
            .navigationBarTitle(" ", displayMode: .inline)
            
            .navigationBarItems(trailing:
                                    
                                    Button {
                
                if isEditing{
                    firestoreConnector.EditPost(postID: postData.id, caption: postCaption, Type: self.aType, username: postData.username, postType: postData.postType)
                    self.presentation.wrappedValue.dismiss()
                }else{
                    isEditing.toggle()
                    self.postCaption = postData.caption
                    self.aType = postData.atype
            
                }
                
            } label: {
                Image(systemName: isEditing ? "checkmark" : "pencil")
                    .resizable()
                    .scaledToFit()
                
                    .padding(.trailing)
                    .foregroundColor(.white)
            }
                                
                                
            )
            
            .onAppear{
                self.postCaption = postData.caption
                self.aType = postData.atype
              
        }
                Spacer(minLength: 7)
            }
     
        
        
    }
    
}
}
struct demo7: View {
    @State var postData = feedInfo(id: "", username: "", productName: "", productSKU: "", productSize: "", productCat: "", productPrice: "", productCondition: "", productDelivery: "", city: "", state: "", shipping: "", time: "", postType: "", atype: "", caption: "", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [[:]], rating: "", Nameimages: [])
    
    var body: some View {
        
        PostFullViewAccount(postData: postData)
    }
}

struct PostAccountView_Previews: PreviewProvider {
    static var previews: some View {
        demo7()
    }
}


