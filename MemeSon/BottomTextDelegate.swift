//
//  BottomTextDelegate.swift
//  MemeSon
//
//  Created by Siva Ganesh on 06/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import UIKit
import Foundation

class BottomTextDelegate: NSObject, UITextFieldDelegate {
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        let oldText = textField.text! as NSString
        
        if(oldText == "BOTTOM"){
            textField.text = ""
        }
        
        return true
    }
    
}
