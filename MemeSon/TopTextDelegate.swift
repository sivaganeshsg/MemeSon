//
//  TopTextDelegate.swift
//  MemeSon
//
//  Created by Siva Ganesh on 06/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import UIKit
import Foundation

class TopTextDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        let oldText = textField.text! as NSString
        
        if(oldText == "TOP"){
            textField.text = ""
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // let oldText = textField.text! as NSString
        
        //        textField.text = oldText.uppercaseString
        
        return true
    }
}
