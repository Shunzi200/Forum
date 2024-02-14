//
//  FitlerPage.swift
//  Looper
//
//  Created by Samuel Ridet on 1/31/23.
//

import SwiftUI

struct FilterPage: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var itemSelect : Bool
    @Binding var bulkSelect : Bool
    @Binding var newSelect : Bool
    @Binding var usedSelect : Bool
    @Binding var shipSelect : Bool
    @Binding var localSelect : Bool
    @Binding var minSelect : String
    @Binding var maxSelect : String
    @Binding var descending : Bool
    
    
    
    
    var body: some View {
        GeometryReader {geometry in
            VStack(alignment: .leading){
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    
                    Spacer()
                    Text("Filters")
                        .font(.custom("Montserrat-Bold", size: 15))
                    Spacer()
                    Button {
                        self.itemSelect = true
                        self.itemSelect = true
                        self.bulkSelect = true
                        self.newSelect = true
                        self.usedSelect = true
                        self.shipSelect = true
                        self.localSelect = true
                        self.minSelect = ""
                        self.maxSelect = ""
                        self.descending = true
                    } label: {
                        Text("Reset")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }

                    
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Categories")
                        .font(.custom("Montserrat-SemiBold", size: 14))
                    HStack {
                        Button {
                            self.itemSelect.toggle()
                        } label: {
                            Image(systemName: itemSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(itemSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("Item")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    HStack {
                        Button {
                            self.bulkSelect.toggle()
                        } label: {
                            Image(systemName: bulkSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(bulkSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("Bulk")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    
                }.padding(.vertical, 5)
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Condition")
                        .font(.custom("Montserrat-SemiBold", size: 14))
                    HStack {
                        Button {
                            self.newSelect.toggle()
                        } label: {
                            Image(systemName: newSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(newSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("New")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    HStack {
                        Button {
                            self.usedSelect.toggle()
                        } label: {
                            Image(systemName: usedSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(usedSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("Used")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    
                }.padding(.vertical,5)
                
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Delivery")
                        .font(.custom("Montserrat-SemiBold", size: 14))
                    HStack {
                        Button {
                            self.shipSelect.toggle()
                        } label: {
                            Image(systemName: shipSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(shipSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("Ship")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    HStack {
                        Button {
                            self.localSelect.toggle()
                        } label: {
                            Image(systemName: localSelect ? "checkmark.square.fill": "square")
                                .foregroundColor(localSelect ? CustomColor.mainPurple : .white)
                        }
                        Text("Local meetup")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                    }
                    
                    
                }.padding(.vertical,5)
                
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Price")
                            .font(.custom("Montserrat-SemiBold", size: 14))
                        Spacer()
                        
                    }
                    
                    HStack{
                        Spacer()
                        minMaxPrice(text: $minSelect, exampleString: "", characterLimit: 5, textFieldHeight: geometry.size.width * 0.08, placeHolderText: "Min")
                            .frame(width: geometry.size.width * 0.38)
                        Text("to")
                            .font(.custom("Montserrat-SemiBold", size: 14))
                            .padding(.horizontal, 5)
                        
                        minMaxPrice(text: $maxSelect, exampleString: "", characterLimit: 5, textFieldHeight: geometry.size.width * 0.08, placeHolderText: "Max")
                            .frame(width: geometry.size.width * 0.38)
                        Spacer()
                      
                    }
                    
                    

                    
                    
                    
                }.padding(.vertical,5)
                
                
                
                
                
            }.padding(.horizontal)
                .padding(.vertical, 10)
        }
    }
}


struct FilterPageDemo : View{
    @State var itemSelect = true
    @State var bulkSelect = true
    @State var newSelect = true
    @State var usedSelect = true
    @State var shipSelect = true
    @State var localSelect = true
    @State var minSelect = ""
    @State var maxSelect = ""
    @State var descending = true
    var body: some View{
        FilterPage(itemSelect: $itemSelect, bulkSelect: $bulkSelect, newSelect: $newSelect, usedSelect: $usedSelect, shipSelect: $shipSelect, localSelect: $localSelect, minSelect: $minSelect, maxSelect: $maxSelect, descending: $descending)
    }
}
struct FitlerPage_Previews: PreviewProvider {
    static var previews: some View {
            FilterPageDemo()
    }
}


struct minMaxPrice : View{
    @Binding var text : String
    var exampleString : String
    var characterLimit : Int
    var textFieldHeight: CGFloat
    var placeHolderText : String
    
    var body: some View{
        ZStack(alignment: .leading) {
            
            if text.count == 0{
                Text(exampleString)
                    .lineLimit(1)
                    .foregroundColor(Color.gray)
                    .background(Color(UIColor.systemBackground))
                    .padding()
                    .lineLimit(1)
            }
            
            
            HStack{
                Text("$")
                    .font(.custom("Montserrat-SemiBold", size: 13))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                TextField("", text: $text)
                    // .keyboardType(.decimalPad)
                    .limitInputLength(value: $text, length: characterLimit)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    
                    .keyboardType(.decimalPad)
                    .font(.custom("Montserrat-SemiBold", size: 13))
                
                
            }
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
                .frame(height: textFieldHeight))
            .foregroundColor(Color.primary)
            .accentColor(Color.secondary)
 
            Text(placeHolderText)
                .font(.custom("Montserrat-SemiBold", size: 13))
                .foregroundColor(Color.white)
                .background(Color(UIColor.systemBackground))
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
            
            
        }
    }
}
