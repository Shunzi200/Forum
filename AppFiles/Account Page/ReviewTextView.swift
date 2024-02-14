//
//  ReviewTextView.swift
//  Looper
//
//  Created by Samuel Ridet on 1/8/23.
//

import SwiftUI

struct ReviewTextView: View {
    @State var review  : [String: String]
    @StateObject var firestoreConnector = FirebaseConnector()
    var width: CGFloat
    var height: CGFloat
    @State var showAc = false
    @State var days = 0
    var body: some View {
        

            VStack(alignment: .leading){
                    HStack (alignment: .top){
                        UrlImageView(urlString: firestoreConnector.viewdataToDisplay.profilePic )
                            .scaledToFill()
                            .frame(width: width * 0.15, height: width * 0.15)
                            .clipShape(Circle())
                        
                        
                        VStack(alignment: .leading) {
                            Text("\(firestoreConnector.viewdataToDisplay.username)")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                        }
                        .padding(.horizontal, 5)
                        
                        Spacer()
                        Text(" \(days)d")
                            .font(.custom("Montserrat-Regular", size: 15))
                        
                   
                    }.padding(.horizontal, 5)
                    
                    Text("\(review["rating"] ?? "")★, \(review["review"] ?? "")")
                        .font(.custom("Montserrat-SemiBold", size: 13))
                        .padding(.horizontal, 5)
                        .lineLimit(10)
                    
                }.padding(5)     .onAppear{
                    firestoreConnector.fetchViewAccount(userID: review["user"] ?? "")
                    let givenDateString = review["date"] ?? ""
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM.dd.yyyy"
                    
                    let givenDate = dateFormatter.date(from: givenDateString)!
                    let today = Date()
                    
                    let calendar = Calendar.current
                    let days = calendar.dateComponents([.day], from: givenDate, to: today)
                    
                    if let days = days.day {
                        self.days = days
                    }
                }.navigationBarTitle("Reviews").navigationBarTitleDisplayMode(.inline)
                .background(.black).onTapGesture {
                    self.showAc.toggle()
                }.sheet(isPresented: $showAc) {
                    ViewUserAccount(userID: review["user"] ?? "")
            }
        
       
    
    }
}

/*
 struct ReviewTextViewDemo: View {
 @State var review  : [String: String] = ["userID": "M17K7nYafvPjwJqDsyEwDAX4UCy1", "text": "Great seller, super good deal", "date": "01.08.2023", "rating": "4"]
 var body: some View {
 ReviewTextView(review: review, width: 428, height: 926)
 }
 }
 struct ReviewTextView_Previews: PreviewProvider {
 static var previews: some View {
 ReviewTextViewDemo()
 .environmentObject(FirebaseConnector())
 }
 }
 */
