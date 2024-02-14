//
//  customDropDownPicker.swift
//  Looper
//
//  Created by Samuel Ridet on 2/18/23.
//

import SwiftUI

struct customDropDownPicker: View {
    var title: String
    @Binding var selection: String
    var options: [String]
    
    @Binding var disabled : Bool

    init(title: String, selection: Binding<String>, options: [String], disabled: Binding<Bool> = .constant(true)) {
        self.title = title
        self._selection = selection
        self.options = options
        self._disabled = disabled
    }

    
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
                // Static row which shows user's current selection
            HStack {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.custom("Montserrat-Regular", size: 13))
                Spacer()
                Text(selection)
                    .foregroundColor(!disabled ? .gray : .white)
                    .font(.custom("Montserrat-SemiBold", size: 15))
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .foregroundColor(!disabled ? .gray : .white)
            }
           // .padding(.vertical, 8)
            .background(CustomColor.grayBackground)
            .onTapGesture {
                    // show the dropdown options
                withAnimation(Animation.spring().speed(2)) {
                    showOptions = true
                }
            }
            
                // Drop down options
            if showOptions {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .foregroundColor(.gray)
                        .font(.custom("Montserrat-Regular", size: 13))
                    
                    HStack {
                        Spacer()
                        ForEach(options.indices, id: \.self) { i in
                            if options[i] == selection {
                                Text(options[i])
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                            // hide dropdown options - user selection didn't change
                                        withAnimation(Animation.spring().speed(2)) {
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[i])
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                                    .onTapGesture {
                                            // update user selection and close options dropdown
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = options[i]
                                            showOptions = false
                                        }
                                    }
                            }
                            Spacer()
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                }
         
                .background(CustomColor.grayBackground)
                .foregroundColor(.white)
                .transition(.opacity)
                
            }
            
        }
    }
}

struct customDropDownPicker_Previews: PreviewProvider {
    @State static var select = "New"
    static var previews: some View {
        customDropDownPicker(title: "Condition", selection: $select, options: ["New", "Used"])
    }
}
