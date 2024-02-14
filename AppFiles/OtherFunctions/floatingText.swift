    //
    //  floatingText.swift
    //  Looper
    //
    //  Created by Samuel Ridet on 8/25/22.
    //

import SwiftUI

import SwiftUI

struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    private let placeHolderImage: String
    private let characterLimit : Int
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, Iconimage: String, charLimit: Int) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderImage = Iconimage
        self.characterLimit = charLimit
    }
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack (alignment: .trailing){
                TextField("", text: $text)
                    .limitInputLength(value: $text, length: characterLimit)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(.custom("Montserrat-SemiBold", size: 15))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1.5)
                        .frame(height: textFieldHeight))
                    .foregroundColor(.white)
                    .accentColor(.white)
                
                Image(systemName: placeHolderImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding()
            }
            
                ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(.white)
                .background(.black)
                .font(.custom("Montserrat-SemiBold", size: 15))
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
        }
    }
}

struct SecureFloatingTextField: View {
    
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    private let characterLimit : Int
    private let placeHolderImage: String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, Iconimage: String, charLimit: Int) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderImage = Iconimage
        self.characterLimit = charLimit
    }
    @State var show = false

    var body: some View {
        ZStack(alignment: .leading) {
            ZStack (alignment: .trailing){
                if !show{
                    SecureField("", text: $text)
                        .limitInputLength(value: $text, length: characterLimit)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(height: textFieldHeight))
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }else{
                    TextField("", text: $text)
                        .limitInputLength(value: $text, length: characterLimit)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(height: textFieldHeight))
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Montserrat-SemiBold", size: 15))
                }
               
                Button {
                    show.toggle()
                } label: {
                    
                    Image(systemName: show ?  "eye.fill" : placeHolderImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding()
                        .foregroundColor(.white)
                }

            }
            
                ///Floating Placeholder
            Text(placeHolderText)
                .font(.custom("Montserrat-SemiBold", size: 15))
                .foregroundColor(.white)
                .background(.black)
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
        }
    }
}

struct ItemTextFields: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    private let placeHolderImage: String
    private let characterLimit : Int
    private let exampleString : String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, Iconimage: String, charLimit: Int, exampleText: String) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderImage = Iconimage
        self.characterLimit = charLimit
        self.exampleString = exampleText
    }
    var body: some View {
        ZStack(alignment: .leading) {
            
            if text.count == 0{
                Text(exampleString)
                    .foregroundColor(Color.gray)
                    .background(Color(UIColor.systemBackground))
                    .padding()
                    .lineLimit(1)
            }
            
            
            ZStack (alignment: .trailing){
                TextField("", text: $text)
                    .limitInputLength(value: $text, length: characterLimit)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                    .accentColor(Color.secondary)
                
                Image(systemName: placeHolderImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding()
            }
            
                ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(Color.white)
                .background(Color(UIColor.systemBackground))
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
            
            
        }
    }
}

struct SizeTextFields: View {
    let textFieldHeight: CGFloat = 50
    @State var selectedSize = ""
    private let placeHolderText: String
    private let characterLimit : Int
    private let exampleString : String
    @Binding var category: String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, charLimit: Int, exampleText: String, category: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        self.characterLimit = charLimit
        self.exampleString = exampleText
        self._category = category
    }
    var body: some View {
        VStack {
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
                    TextField("", text: $text)
                        .limitInputLength(value: $text, length: characterLimit)
                    
                        //.keyboardType(.decimalPad)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding([.bottom, .top, .leading])
                        .keyboardType(.decimalPad)
                        
                    
                    
                    Picker(selection: $category) {
                        Text("M").tag("M")
                        Text("W").tag("W")
                        Text("Y").tag("Y")
                    } label: {
                        
                    }
                    //.pickerStyle(MenuPickerStyle())
                    .foregroundColor(.white)
                    .accentColor(.white)
                   
                   
                }
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
                    .frame(height: textFieldHeight))
                .foregroundColor(Color.primary)
                .accentColor(Color.secondary)
                    ///Floating Placeholder
                Text(placeHolderText)
                    .foregroundColor(Color.white)
                    .background(Color(UIColor.systemBackground))
                    .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
                
            }
            
            
        }
    }
}

struct PriceTextFields: View {
    let textFieldHeight: CGFloat = 30
    private let placeHolderText: String
    private let characterLimit : Int
    private let exampleString : String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, charLimit: Int, exampleText: String) {
        self._text = text
        self.placeHolderText = placeHolder
        
        self.characterLimit = charLimit
        self.exampleString = exampleText
    }
    var body: some View {
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
                TextField("", text: $text)
                   // .keyboardType(.decimalPad)
                    .limitInputLength(value: $text, length: characterLimit)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(.decimalPad)

                Text("$")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding([.trailing,.bottom,.top])
            }
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
                .frame(height: textFieldHeight))
            .foregroundColor(Color.primary)
            .accentColor(Color.secondary)
            
                ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(Color.white)
                .background(Color(UIColor.systemBackground))
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
            
            
        }
    }
}

struct ConditionTextFields: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        
    }
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                
                ZStack {
                    
                    Picker(text, selection: $text)
                    {
                        Text("New ").tag("New")
                        Text("Used").tag("Used")
                        
                    }
                    
                    .pickerStyle(MenuPickerStyle())
                    
                    .accentColor(.white)
                    .padding()
                    .padding([.trailing,.leading], 20)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                    .accentColor(Color.secondary)
                    
                }
                
                    ///Floating Placeholder
                Text(placeHolderText)
                    .foregroundColor(Color.white)
                    .background(Color(UIColor.systemBackground))
                    .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
                
            }
            
            
        }
    }
}


struct DeliveryTextFields: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        
    }
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                
                ZStack {
                    
                    Picker(selection: $text, label: Text("M")) {
                        Text("Ship ").tag("Ship")
                        Text("Local").tag("Local")
                        Text("Both").tag("Both")
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.white)
                    .padding()
                    .padding([.trailing,.leading], 20)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                    .accentColor(Color.secondary)
                    
                }
                
                    ///Floating Placeholder
                Text(placeHolderText)
                    .foregroundColor(Color.white)
                    .background(Color(UIColor.systemBackground))
                    .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
                
            }
            
            
        }
    }
}

struct StateTextFields: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    private let placeHolderImage: String
    private let characterLimit : Int
    private let exampleString : String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>, Iconimage: String, charLimit: Int, exampleText: String) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderImage = Iconimage
        self.characterLimit = charLimit
        self.exampleString = exampleText
    }
    var body: some View {
        ZStack(alignment: .leading) {
            
            if text.count == 0{
                Text(exampleString)
                    .foregroundColor(Color.gray)
                    .background(Color(UIColor.systemBackground))
                    .padding()
                    .lineLimit(1)
            }
            
            
            ZStack (alignment: .trailing){
                TextField("", text: $text)
                    .textCase(.uppercase)
                    .limitInputLength(value: $text, length: characterLimit)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                    .accentColor(Color.secondary)
                
                Image(systemName: placeHolderImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding()
            }
            
                ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(Color.white)
                .background(Color(UIColor.systemBackground))
                .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
            
            
            
        }
    }
}
struct PostTypeTextFields: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    public init(placeHolder: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        
    }
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                
                ZStack {
                    
                    Picker(selection: $text, label: Text("")) {
                        Text("Post ").tag("Post")
                        Text("Story").tag("Story")
                        
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.white)
                    .padding()
                    .padding([.trailing,.leading], 20)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(height: textFieldHeight))
                    .foregroundColor(Color.primary)
                    .accentColor(Color.secondary)
                    
                }
                
                    ///Floating Placeholder
                Text(placeHolderText)
                    .foregroundColor(Color.white)
                    .background(Color(UIColor.systemBackground))
                    .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) )
                
            }
            
            
        }
    }
}
struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}
extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

struct BulkTextFields: View {
    let textFieldHeight: CGFloat = 50
    @State var selectedSize = ""
    

    @Binding var category: String
    @Binding var text: String
    @Binding var quantity : String
    @Binding var price: String
   
    var body: some View {
        GeometryReader {geometry in

                HStack{
                    VStack(alignment: .leading, spacing: 2){
                        Text("Size")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .padding(.leading)
                        HStack(spacing: 15) {
                                TextField("9", text: $selectedSize)
                                    .limitInputLength(value: $selectedSize, length: 5)
                                    .font(.custom("Montserrat-SemiBold", size: 15))
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: geometry.size.width * 0.15)
                                    
         
                                    
                                Picker(category, selection: $category)
                                {
                                    Text("M ")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .tag("M")
                                    Text("W ")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .tag("W")
                                    Text("GS")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .tag("GS")
                                    
                                }
                                
                                .pickerStyle(MenuPickerStyle())
                                .accentColor(.white)
                                .foregroundColor(.white)
                                .padding(.trailing)
                                .frame(width: geometry.size.width * 0.1)

                        }.frame(height: geometry.size.width * 0.05)
                    }
    
                    Spacer()
                    VStack(alignment: .leading, spacing: 2){
                        Text("Price")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                        
                        HStack {
                            
                            TextField("200", text: $price)
                                .limitInputLength(value: $price, length: 5)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: geometry.size.width * 0.2)
                            
                            Text("$")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                            
                            
                        }.frame(height: geometry.size.width * 0.05)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 2){
                        Text("Quantity")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                        HStack{

                            TextField("5", text: $quantity)
                                .limitInputLength(value: $quantity, length: 3)
                            
                                .keyboardType(.decimalPad)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .frame(width: geometry.size.width * 0.2)
                        }.frame(height: geometry.size.width * 0.05)
                    }
     
                        
                        
                 
                   
                        
                        
                    }
                    .foregroundColor(.white)
                    .accentColor(.white)
                   
                
            }
    }
}


struct WrappedTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    let textDidChange: (UITextView) -> Void
    let font: UIFont
    let maxLines: Int
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.font = self.font
        view.delegate = context.coordinator

            // Set the maximum number of lines for the text container
        view.textContainer.maximumNumberOfLines = maxLines
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void
        
        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
}

struct WrappedTextViewWhite: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    let textDidChange: (UITextView) -> Void
    let font: UIFont
    let maxLines: Int
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.font = self.font
        view.delegate = context.coordinator
        view.backgroundColor = UIColor(hex: "#28292D")
        view.textColor = .white
            // Set the maximum number of lines for the text container
        view.textContainer.maximumNumberOfLines = maxLines
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void
        
        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText = textView.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
            return newText.count <= 120
        }
    }

}


struct MessageField: View {
    @Binding var text: String
    let minHeight: CGFloat
    @State private var height: CGFloat?
    
    
    var body: some View {
        
        HStack(alignment: .center){
            WrappedTextView(text: $text, textDidChange: self.textDidChange, font: UIFont(name: "Montserrat-SemiBold", size: 16)!, maxLines: 8)
                .frame(height: height ?? minHeight)

        
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.black)
                


        }.padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1.5)
            .frame(height: height ?? minHeight))
            .accentColor(.white)
 

    }
    
    private func textDidChange(_ textView: UITextView) {
        self.height = max(textView.contentSize.height, minHeight)
    }
}


struct ReviewField: View {
    @Binding var text: String
    let minHeight: CGFloat
    @State private var height: CGFloat?
    
    var body: some View {
        
        HStack(alignment: .center){
            WrappedTextViewWhite(text: $text, textDidChange: self.textDidChange, font: UIFont(name: "Montserrat-SemiBold", size: 16)!, maxLines: 8)
                .frame(height: height ?? minHeight)
          
    
        }.padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
                .frame(height: height ?? 20))
            .accentColor(.white)

   
        
        
    }
    
    private func textDidChange(_ textView: UITextView) {
        self.height = max(textView.contentSize.height, minHeight)
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    var font: UIFont
    var background: UIColor
    
    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        
        textField.isEditable = true
        textField.font = font
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = background
        if nil != onDone {
            textField.returnKeyType = .done
        }
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        
        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            
                // Limit the number of characters to 50
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            return newText.count <= 160
        }

    }
}

struct MultilineTextField: View {
    
    private var placeholder: String
    private var onCommit: (() -> Void)?
    private var font: UIFont
    private var background: UIColor
    
    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }
    
    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false
    
    init (_ placeholder: String = "", text: Binding<String>, font: UIFont = UIFont.preferredFont(forTextStyle: .body), background: UIColor = .clear, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self.font = font
        self.background = background
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }
    
    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit, font: font, background: background)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
    }
    
    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}


struct NewField : View{
    @State var text: String = ""
    var body: some View{
        VStack {
            MultilineTextField(text: $text)
            
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
    }
}

struct demo: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var category: String = ""
    @State var q = ""
    @State var text = ""
    @State var price = ""
    var body: some View {
    
        SecureFloatingTextField(placeHolder: "", text: $name, Iconimage: "eye.slash.fill", charLimit: 23)

        //ReviewField(text: $name, minHeight: 40)
        //BulkTextFields(category: $category, text: $name, quantity: $q, price: $price)
            
                
            
    
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        demo()
    }
}
