//
//  SingleMemeViewController.swift
//  MemeSon
//
//  Created by Siva Ganesh on 07/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import UIKit

class SingleMemeViewController: UIViewController {

    

    @IBOutlet weak var memeImage: UIImageView!
    
    var tempTitle:String?
    var tempImg: UIImage?
   
    
    @IBOutlet weak var imgTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgTitle.text = tempTitle
        memeImage.image = tempImg
        
        memeImage.autoresizingMask = [.FlexibleBottomMargin, .FlexibleHeight, .FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleTopMargin, .FlexibleWidth ]
    
    }
    
    
}
