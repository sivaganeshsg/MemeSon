//
//  Meme.swift
//  MemeSon
//
//  Created by Siva Ganesh on 06/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import Foundation
import UIKit

struct Meme{

    var topText : String?
    var bottomText : String?
    var originalImg : UIImage?
    var memedImg : UIImage?
    
    init(text1: String,text2: String, image: UIImage, newImage: UIImage){
        self.topText = text1
        self.bottomText = text2
        self.originalImg = image
        self.memedImg = newImage
    }
    
}
