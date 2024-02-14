
    //
    //  ListingThumbnailView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/26/22.
    //

import SwiftUI

struct PostThumbnailView: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    let width: CGFloat
    let height: CGFloat
    let postsData : feedInfo

    
    
    var localShow = false
    
    @Binding var isEditing: Bool
    @State var isDeleting = false
    
        //var image = "DunkPanda5"
    @State var showProduct : Bool = false
    @State var image = "imagePlaceHolder"

    var body: some View {
        
        let imageName = postsData.images as? [String] ?? [""]
        
        NavigationLink(destination: PostFullViewAccount(postData: postsData)){
            GeometryReader { geometry in
                    VStack (alignment: .leading){
                        UrlImageView(urlString: imageName[0])
                           
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                    }
              
                    .confirmationDialog("Delete?", isPresented: $isDeleting){
                        
                        Button("Delete", role: .destructive){
                            if let index:Int = self.firestoreConnector.posts.firstIndex(where: {$0.id == postsData.id }) {
                               self.firestoreConnector.posts.remove(at: index)
                            }
 
                          
                 
                            firestoreConnector.deleteDoc(collection: "Posts", doc: postsData.id, images: postsData.Nameimages)
                        }
                    } message: {
                        Text("Are you sure you want to delete this post/listing?")
                    }
    
                      
                    
                
                    .overlay(alignment: .topTrailing){
                        if isEditing{
                            Button {
                                isDeleting = true
                                
                            } label: {
                                Image(systemName: "xmark.square.fill")
                                    .font(Font.title)
                                    .foregroundStyle(.white,.red)
                                
                            }
                            
                        }
                    }
 
                .cornerRadius(10)
                
                
            }
      
            
        }
       
       
        
    }
}


struct demo5 : View{
    @State var postData = feedInfo(id: "", username: "", productName: "", productSKU: "", productSize: "", productCat: "", productPrice: "", productCondition: "", productDelivery: "", city: "", state: "", shipping: "", time: "", postType: "", atype: "", caption: "", likes: [], saves: [], comments: [], images: [], userID: "", bulkSize: [[:]], rating: "", Nameimages: [])
    
    @State var isEditing = true

    var body: some View {
        PostThumbnailView(width: 300, height: 400, postsData: postData, isEditing: $isEditing)
    }
}

 struct PostThumbnailView_Previews: PreviewProvider {
    
 static var previews: some View {
    demo5()
 }
 }

