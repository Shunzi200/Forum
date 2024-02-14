//
//  SegmentedControl.swift
//  Looper
//
//  Created by Samuel Ridet on 12/28/22.
//

import SwiftUI

import SwiftUI

struct TabBarSales: View {
    @Binding private var selectedIndex: Int
    
    @State private var frames: Array<CGRect>
    @State private var backgroundFrame = CGRect.zero
    @State private var isScrollable = true
    
    private let titles: [String]
    var width : CGFloat
    init(selectedIndex: Binding<Int>, titles: [String], width : CGFloat) {
        self._selectedIndex = selectedIndex
        self.titles = titles
        self.width = width
        frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    var body: some View {
        VStack {
            if isScrollable {
                ScrollView(.horizontal, showsIndicators: false) {
                    SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles, width: width)
                }
            } else {
                SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles, width: width)
            }
        }
        .background(
            GeometryReader { geoReader in
                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                    .onPreferenceChange(RectPreferenceKey.self) {
                        self.setBackgroundFrame(frame: $0)
                    }
            }
        )
    }
    
    private func setBackgroundFrame(frame: CGRect)
    {
        backgroundFrame = frame
        checkIsScrollable()
    }
    
    private func checkIsScrollable()
    {
        if frames[frames.count - 1].width > .zero
        {
            var width = CGFloat.zero
            
            for frame in frames
            {
                width += frame.width
            }
            
            if isScrollable && width <= backgroundFrame.width
            {
                isScrollable = false
            }
            else if !isScrollable && width > backgroundFrame.width
            {
                isScrollable = true
            }
        }
    }
}




struct SegmentedControlButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect
    @Binding private var isScrollable: Bool

    private let titles: [String]
    var width : CGFloat
    let checkIsScrollable: (() -> Void)
    
    init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, isScrollable: Binding<Bool>, checkIsScrollable: (@escaping () -> Void), titles: [String], width: CGFloat)
    {
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame
        _isScrollable = isScrollable
        
        self.checkIsScrollable = checkIsScrollable
        self.titles = titles
        self.width = width
        
    }
    
    var body: some View {
        HStack{
            ForEach(titles.indices, id: \.self) { index in
                Button(action:{ selectedIndex = index })
                {
                    HStack {
                        Text(titles[index])
                            .font(.custom("Montserrat-Bold", size: 15))
                            .bold()
                            .frame(height: 30)
                          
                         
                    }
                }
                .buttonStyle(CustomSegmentButtonStyle())
                .background(
                    GeometryReader { geoReader in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                )
            }
        }.frame(width: width)
            .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames, width: width))
    
    }
    
    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
        
        checkIsScrollable()
    }
}

private struct CustomSegmentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20))
          
    }
}


struct UnderlineModifier: ViewModifier {
    var selectedIndex: Int
    let frames: [CGRect]
    var width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "DE71F9"),Color(hex: "C729FF"),Color(hex: "8729FF")]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: frames[selectedIndex].width, height: 2)
                    .foregroundColor(.black)
                    .offset(x: frames[selectedIndex].minX, y: frames[selectedIndex].minY - frames[0].minY), alignment: .bottomLeading
            )
            .background(
                Rectangle()
                    .foregroundColor(CustomColor.grayBackground)
                    .frame(height: 2), alignment: .bottomLeading
            )
            .animation(.default)
    }
}


struct RectPreferenceKey: PreferenceKey
{
    typealias Value = CGRect
    
    static var defaultValue = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
    {
        value = nextValue()
    }
}



struct SegmentedDemo : View{
    @State var hello = 0
    var body: some View{
        TabBarSales(selectedIndex: $hello, titles: ["Overall", "Sales", "Purchases"], width: 428)
        
    }
}
/*
struct SegmentedPreview: PreviewProvider {
    
    static var previews: some View {
       SegmentedDemo()
 
    }
    
}
*/
