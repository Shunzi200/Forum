//
//  confirmationPopover.swift
//  Looper
//
//  Created by Samuel Ridet on 4/8/23.
//

import SwiftUI

struct confirmationPopover: View {
    var width: CGFloat
    var title : String
    var bodytext : String
    @Binding var showConfirmation : Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(spacing: 5){
                Text(title)
                    .font(.custom("Montserrat-Bold", size: 15))
                
                Text(bodytext)
                    .font(.custom("Montserrat-Regular", size: 15))
                    .multilineTextAlignment(.center)
            }.frame(width: width * 0.6).padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(CustomColor.grayBackground)
                )
            Button {
                withAnimation{
                    showConfirmation = false
                }
            } label: {
                Image(systemName: "x.circle")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .padding(4)

            
            
        }
         //   .overlay(
             //   RoundedRectangle(cornerRadius: 15)
             //       .stroke(Color.white, lineWidth: 1)
           // )
            .transition(.opacity)
            .onAppear{
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
            }
        
        
        
   
    }
}

struct confirmationPopover_Previews: PreviewProvider {
    @State static var showConfirmation = false
    static var previews: some View {
        confirmationPopover(width: 426, title: "Listing Successful", bodytext: "Your item has been listed successfully.", showConfirmation: $showConfirmation)
    }
}
