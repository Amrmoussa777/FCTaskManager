//
//  CustomTextView.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 21/02/2023.
//

import UIKit

class CustomTextView:UITextView,UITextViewDelegate{
    var txtColor:UIColor = .black
    
    var placeHolderLabel:UILabel!
    
    public init (placeholder:String,placeHolderColor:UIColor = .systemGray5,txtColor:UIColor = .black){
        super.init(frame: .zero, textContainer: nil)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = txtColor
        returnKeyType  = .done
        font = .systemFont(ofSize: 17)
        delegate = self
        
        placeHolderLabel = UILabel()
        placeHolderLabel.numberOfLines = 1
        placeHolderLabel.font = .systemFont(ofSize: 14)
        placeHolderLabel.font = font
        placeHolderLabel.text = placeholder
        placeHolderLabel.textColor = placeHolderColor
        addSubview(placeHolderLabel)
        sendSubviewToBack(placeHolderLabel)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeHolderLabel.font = font
        let nFrame = frame
        placeHolderLabel.frame = .init(x: 10, y: 0, width: nFrame.width, height: 40)
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden =  textView.text.count > 0  ?  true:false
    }
    
    
    func setText(txt:String){
        self.text = txt
        placeHolderLabel.isHidden =  self.text.count > 0  ?  true:false
    }
    
    func getText()->String{
        return  text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    
}

