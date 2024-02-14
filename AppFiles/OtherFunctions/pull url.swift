//
//  pull url.swift
//  Looper
//
//  Created by Samuel Ridet on 10/10/22.
//

import Foundation
import SwiftUI
import FirebaseStorage


struct Links : Hashable {
    var id: String
    var name: String
    var url: String
}
class getURL: ObservableObject{
 
    @Published var arrayURL : [Links] = [Links(id: "", name: "", url: "")]
    
    func getImages(imageName: String, completion: @escaping (URL?) -> Void) {
        let storage = Storage.storage()
        let path = "images/\(imageName)"
        storage.reference().child(path).downloadURL(completion: { (url, error) in
            if error != nil {
                    //assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
       
    }
    
    
    
    func fetchUrl (images: [String]){
        DispatchQueue.main.async {
            
        
            for image in images{
  
                let firstlet = image.prefix(1)
                self.getImages(imageName: image) { (downloadURL) in
                    guard let downloadURL = downloadURL else {
                        return
                    }
                    let urlString = downloadURL.absoluteString
                
                    if self.arrayURL[0].name == ""{
                        let el = Links(id: image, name: String(firstlet), url: "\(urlString)")
                        self.arrayURL[0] = el
                        self.arrayURL.sort {
                            $0.name < $1.name
                        }
                        
                    }else{
                        let el = Links(id: image, name: String(firstlet), url: "\(urlString)")
                        self.arrayURL.append(el)
                        self.arrayURL.sort {
                            $0.name < $1.name
                        }
                    }
                    
                    
                }
  
            }
            
        }
        }
    

}
