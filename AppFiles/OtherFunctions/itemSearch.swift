//
//  itemSearch.swift
//  Looper
//
//  Created by Samuel Ridet on 2/22/23.
//

import Foundation
import SwiftUI


struct LowestResellPrice: Codable {
    let stockX: Int
    let flightClub: Int
    let goat: Int
}




class itemSearch : ObservableObject {
    @Published var resultList : [JSONItem] = []
    @Published var isFetchingData = false
 
    func searchQuery(query: String){
        self.isFetchingData = true
        self.resultList = []
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://us-central1-forum-app-373704.cloudfunctions.net/sneaksSearch?q=\(encodedQuery)") else {
            print("Invalid URL")
            self.isFetchingData = false
            return
        }
        
        print("Fetching data")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                self.isFetchingData = false
                return
            }
            
            guard let data = data else {
                print("No data returned")
                self.isFetchingData = false
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let jsonItems = try jsonDecoder.decode([JSONItem].self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.resultList = jsonItems
                    self?.isFetchingData = false
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.isFetchingData = false
            }
        }.resume()
        
    }
    
}

