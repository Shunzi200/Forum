
    //
    //  ListingThumbnailView.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/26/22.
    //

import SwiftUI

struct SellThumbnail: View {
    @State var image : UIImage
    @Binding var images : [UIImage]
    var width : CGFloat
    var height : CGFloat
    @State var croppedImage = UIImage()
    var body: some View {
      
      
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .frame(width: width * 0.35, height: width * 0.25)

            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(alignment: .topTrailing){
                Button {
                    if let index = self.images.firstIndex(of: image) {
                        self.images.remove(at: index)
                    }
                } label: {
                    Image(systemName: "xmark.square.fill")
                        .font(.title2)
                        .foregroundStyle(.white,.red)
                    
                    
                    
                }.offset(x: 10, y : -10)

            }.onAppear{
                let cropRect = CGRect(x: 0, y: 0, width: width * 0.25, height: width * 0.25)
                let viewWidth: CGFloat = width * 0.25
                let viewHeight: CGFloat = width * 0.25
                croppedImage = cropImage(image, toRect: cropRect, viewWidth: viewWidth, viewHeight: viewHeight) ?? UIImage()
            }
            
            
        
        
        
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(inputImage.size.width / viewWidth,
                                 inputImage.size.height / viewHeight)
        
            // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                              y:cropRect.origin.y * imageViewScale,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)
        
            // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
        else {
            return nil
        }
        
            // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
}



/*
struct SellThumbnailView_Previews: PreviewProvider {
    @State var array = ["imagePlaceHolder"]
    static var previews: some View {
        SellThumbnail(image: "imagePlaceHolder", images: $array )
    }
}
*/
