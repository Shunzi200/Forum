    //
    //  Account.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/14/22.
    //

import SwiftUI




struct Account: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @State var deletedItem = false
    @State private var image = UIImage()
    @State var isEditing =  false
    @State var Listings : Int = 0
    @State var isDeleting : Bool = false
    @State var deleteStuff = false
    @State var editPic = false
    @State var imagePicked = false
    
    var GridOptions = Array(repeating: GridItem(.flexible()), count: 2)
    


    var body: some View {
        
        
        GeometryReader {geometry in
            VStack{
                let listingData = firestoreConnector.listings
                let profilePic = firestoreConnector.dataToDisplay.profilePic
                let postsData = firestoreConnector.posts

                HStack(spacing: 20) {
                    Text("Account")
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Bold", size: 20))
                    Spacer()
                    
                    Button {
                        isEditing.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                        
                    } label: {
                        Image(systemName: isEditing ? "checkmark" : "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 17)
                            .foregroundColor(.white)
                    }
                    
                    
                    NavigationLink(destination: SavedPosts()){
                        
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 28)
                            .foregroundColor(.white)
                        
                    }
                    
                    NavigationLink(destination: Profile()){
                        
                        Image(systemName: "gear")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 13)
                            .foregroundColor(.white)
                        
                    }
                    
                }
                .padding(.horizontal)
                
                ScrollView (showsIndicators: false) {
                    VStack {
                        HStack (spacing: 15){
                            if imagePicked{
                                Image(uiImage: image)
                                    .resizable()
                                
                                    .scaledToFill()
                                    .frame(width: geometry.size.width / 7, height: geometry.size.width / 7)
                                    .clipShape(Circle())
                                
                                
                                    .overlay(alignment: .topTrailing){
                                        if isEditing{
                                            Image(systemName: "pencil.circle.fill")
                                                .font(Font.body)
                                                .foregroundStyle(.white, .gray)
                                            
                                        }
                                    }
                                
                                    .onTapGesture {
                                        
                                        if isEditing{
                                            
                                            image = UIImage()
                                            editPic.toggle()
                                        }
                                    }
                            }
                            else  {
                                UrlImageView(urlString: profilePic)
                                    .scaledToFill()
                                    .frame(width: geometry.size.width / 7, height: geometry.size.width / 7)
                                    .clipShape(Circle())
                                
                                    .overlay(alignment: .topTrailing){
                                        if isEditing{
                                            Image(systemName: "pencil.circle.fill")
                                                .font(Font.body)
                                                .foregroundStyle(.white, .gray)
                                        }
                                    }
                                
                                
                                    .onTapGesture {
                                        if isEditing{
                                                //imagePicked = false
                                            image = UIImage()
                                            editPic.toggle()
                                        }
                                    }
                                
                                
                            }
                            
                            VStack(alignment: .leading){
                                
                                Text("\(firestoreConnector.dataToDisplay.username)")
                                    .font(.custom("Montserrat-Bold", size: 18))
                                
                                Text("\(String(format: "%.1f", firestoreConnector.ratingToDisplay.rating))★")
                                    .font(.custom("Montserrat-SemiBold", size: 14))
                                
                            }
                            Spacer()
                        }.padding(.horizontal)
                        
                        
                        DataCardAccount(width: geometry.size.width, height: geometry.size.height)
                            .frame(width: geometry.size.width * 0.96)
                            .padding(.vertical, 5)

                        CustomSegmentedPickerView(selection: $Listings, width: geometry.size.width * 0.98, height: geometry.size.height)
                        
                        if Listings  == 1{
                            
                            if (postsData.count == 0 ){
                                Spacer()
                                Text("No active posts")
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                    .padding(.vertical, 10)
                                Spacer()
                            }else{
                                LazyVGrid(columns: GridOptions, spacing: 10){
                                    ForEach(postsData) {currentPost in
                                        
                                        PostThumbnailView(width: geometry.size.width / 2.1, height: geometry.size.height / 4.1, postsData: currentPost, isEditing: $isEditing)
                                            .frame(width:geometry.size.width / 2.1, height: geometry.size.height / 4.1 )
                                        
                                    }
                                }
                            }
                            
                        }else{

                            VStack(spacing: 10){
                                if (listingData.count == 0 ){
                                    Spacer()
                                    Text("No items listed")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                    Spacer()
                                }else{
                                    ForEach(listingData) {currentListing in
                                        
                                        if currentListing.postType == "Item"{
                                            ThumbnailBarListing(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, isEditing: $isEditing)
                                            
                                                .frame(width:geometry.size.width * 0.95)
                                        }
                                        
                                        else if currentListing.postType == "Bulk"{
                                            ThumbnailBarBulk(width: geometry.size.width, height: geometry.size.height,  listingData: currentListing, isEditing: $isEditing)
                                            
                                                .frame(width:geometry.size.width * 0.95)
                                            
                                        }
                                        
                                    }
                            }
                                Spacer(minLength: 10)
                            }
                            .fullScreenCover(isPresented: $editPic, onDismiss: {
                                if image.size.height != 0.0 {
                                    
                                    imagePicked = true
                                    firestoreConnector.uploadProfile(image: image, pic: firestoreConnector.dataToDisplay.NameImages)
                                }
                                isEditing = false
                                
                            }) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            }
                        }
                        
                        
                        
                        
                    } .animation(.default, value: Listings)
                }.refreshable{
                    firestoreConnector.fetchAccount(){
                        
                    }
                }
            }
                .onAppear{
                    firestoreConnector.fetchAccount(){
                        
                    }
                    print("Appear")
                    
                }
                
            
            
            
        }
        .background(.black)
     
    }
}


struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
            .environmentObject(FirebaseConnector())
    }
}
