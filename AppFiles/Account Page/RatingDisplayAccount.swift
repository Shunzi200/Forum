//
//  RatingDisplayAccount.swift
//  Looper
//
//  Created by Samuel Ridet on 1/9/23.
//

import SwiftUI

struct RatingDisplayAccount: View {
    @State var ratings :  ratingData
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(ratings.prevReview.sorted(by: { formatDate($0["date"] ?? " ") > formatDate($1["date"] ?? " ") }), id: \.self["user"]) { review in
                        ReviewTextView(review: review, width: geometry.size.width, height: geometry.size.height)
                        Divider()
                    }
                }
                .navigationTitle("Reviews")
            }
        }
        .background(.black)
        .accentColor(.white)
    }
    
    func formatDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}

struct RatingDisplayAccountDemo : View{
    var body: some View{
        RatingDisplayAccount(ratings: ratingData(id: "", rating: 0, prevRating: [[:]], prevReview: [[:]]))
    }
}
struct RatingDisplayAccount_Previews: PreviewProvider {
    static var previews: some View {
        RatingDisplayAccountDemo()
    }
}
