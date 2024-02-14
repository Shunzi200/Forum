//
//  PostMain.swift
//  Looper
//
//  Created by Samuel Ridet on 2/8/23.
//

import SwiftUI

struct PostMain: View {
    @EnvironmentObject var firestoreConnector : FirebaseConnector
    @Binding var images : [UIImage]
    @State var bulk = false
    @State var caption = ""
    @State var showConfirmation = false
    @State var defaultPicture = ""
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                VStack {
                    ScrollView (showsIndicators: false){
                        VStack{
                            HStack {
                                Spacer()
                                ImageViewPicker(images: $images,listing: false, bulk: $bulk, width: geometry.size.width, height: geometry.size.height, defaultPicture: $defaultPicture)
                                    .padding(.horizontal, 5)
                                Spacer()
                            }
                            ZStack (alignment: .topLeading){
                                
                                MessageField(text: $caption, minHeight: 60)
                                    .frame(width: geometry.size.width * 0.9)
                                Text("Caption")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .background(.black)
                                    .offset(x: 10, y: 2)
                            }
      
                            
                            
                           
                        }
                    }.onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                    Spacer()
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        withAnimation{
                            showConfirmation = true
                        }
            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation{
                                showConfirmation = false
                            }
                            
                        }
                        firestoreConnector.UploadPost(username: firestoreConnector.dataToDisplay.username, caption: caption, type: "", images: images, rating: firestoreConnector.dataToDisplay.rating)
                        caption = " "
                        images = []
                
                        
                    } label: {
                        ZStack{
                            Capsule()
                                .foregroundColor((caption.isEmpty || images.isEmpty) ? .gray : .white)
                                .frame(width: geometry.size.width*0.9, height: geometry.size.width * 0.12)
                            Text("Post")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .padding(10)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 10)
                    .disabled(caption.isEmpty || images.isEmpty)
                    
                    
                    
                } .opacity(showConfirmation ? 0.6: 1)
                    .transition(.opacity)
                if showConfirmation{
                    confirmationPopover(width: geometry.size.width, title: "Post Successful", bodytext: "Your post has been uploaded successfully.", showConfirmation: $showConfirmation)
                    
                }
            }
        }
    }

}

struct PostMain_Previews: PreviewProvider {
    @State static var images: [UIImage] = []
    static var previews: some View {
        PostMain(images: $images)
            .environmentObject(FirebaseConnector())
    }
}
