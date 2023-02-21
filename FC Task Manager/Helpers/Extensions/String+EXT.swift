//
//  String+EXT.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation


public extension String{
    static var language:Language  = .en {didSet{
        updateBundle()
    }}
    
    static var stringsBundle:Bundle? =  {
        let path = Bundle.main.path(forResource: String.language.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle
    }()
    
    
     func localized() -> String{
         return NSLocalizedString(self, tableName: nil, bundle: String.stringsBundle!, value: "", comment: "")
    }
    
    
    fileprivate static func updateBundle(){
        let path = Bundle.main.path(forResource: String.language.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)
        stringsBundle = bundle
    }
    
    
    
}


public enum Language:String{
    case en = "en"
    case ar = "ar"
    case de = "de"
    case fr = "fr"
    case es = "es"
}


