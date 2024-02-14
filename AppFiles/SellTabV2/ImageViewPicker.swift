//
//  ImagePicker.swift
//  Looper
//
//  Created by Samuel Ridet on 1/7/23.
//

import SwiftUI

struct ImageViewPicker: View {
    @Binding var images : [UIImage]
    @State var listing : Bool
    @Binding var bulk : Bool
    @State var showPicker = false
    @State private var image = UIImage()
    var width: CGFloat
    var height: CGFloat
    
    @State var showCam = false
    @State var showLibrary = false
    @Binding var defaultPicture : String
    
    var body: some View {
      
        
        VStack{
            HStack {
                Spacer()
                Button {
                    showPicker = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(self.images.count >= 6 ? .gray : .white)
                        .font(.title2)
                    
                }
                .disabled(self.images.count >= 6)
                .padding(.horizontal,8)
                
            }

                .padding(.vertical, 10)
                .layoutPriority(100)


      
            if images.count == 0 && defaultPicture.isEmpty{
                
                VStack{
                    
                    
                    Text("Add an image to get started")
                        .font(.custom("Montserrat-SemiBold", size: 15))
                    
                } .frame(height: width * 0.3)
                    .padding(.bottom, 10)
                    .offset(y: -15)
            }else{
                ScrollView(.horizontal, showsIndicators: true){
                    HStack(spacing: 15){
                        
                        if !defaultPicture.isEmpty{
                            UrlImageView(urlString: defaultPicture)       
                                .scaledToFit()
                                .clipped()
                                .frame(width: width * 0.35, height: width * 0.25)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(alignment: .topTrailing){
                                    Button {
                                        self.defaultPicture = ""
                                    } label: {
                                        Image(systemName: "xmark.square.fill")
                                            .font(.title2)
                                            .foregroundStyle(.white,.red)
                                        
                                        
                                        
                                    }.offset(x: 10, y : -10)
                                    
                                }
                        }
                        
                        
                        ForEach(images, id: \.self){i in
                            SellThumbnail(image: i, images: $images, width: width , height: height)
                            
                            
                        }
                    }.frame(height: width * 0.3).padding(.bottom, 10)
                        .padding(.horizontal, 15)
                }
            
              
                }
            
            
          
            

            
        } .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(CustomColor.grayBackground)
       
        )
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }.confirmationDialog("Delete?", isPresented: $showPicker){
            
            Button("Camera"){
                self.showCam.toggle()
            }
            Button("Photo Library"){
                self.showLibrary.toggle()
            }
            
        }
        .fullScreenCover(isPresented: $showLibrary, onDismiss: {
            if image.size.height != 0.0 {
                self.images.insert(image, at: images.endIndex)
                image = UIImage()
            }
            
            
        }) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .fullScreenCover(isPresented: $showCam, onDismiss: {
            if image.size.height != 0.0 {
                self.images.insert(image, at: images.endIndex)
                image = UIImage()
            }
            
        }) {
            ImagePicker(sourceType: .camera, selectedImage: self.$image)
        }
   
    }
}

struct ImageViewPickerDemo : View{
   @State var images : [UIImage] = [UIImage(named: "DunkPanda4") ?? UIImage(),UIImage(named: "DunkPanda5") ?? UIImage(),UIImage(named: "DunklPanda3") ?? UIImage()]
   // @State var images : [UIImage] = []
    @State var def = " "
    @State var listing = true
    //@State var images : [UIImage] = []
    var body: some View{
        ImageViewPicker(images: $images, listing: true, bulk: $listing, width: 428, height: 926, defaultPicture: $def)
    }
}


struct ImageViewPickerDemo_Preview: PreviewProvider {
    static var previews: some View {
        ImageViewPickerDemo()
            .environmentObject(FirebaseConnector())
    }
}

