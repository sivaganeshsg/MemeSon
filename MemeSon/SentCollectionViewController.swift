//
//  SentCollectionViewController.swift
//  MemeSon
//
//  Created by Siva Ganesh on 07/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import UIKit

let reuseIdentifier = "sentViewCell"

class SentCollectionViewController: UICollectionViewController {

    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 1.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = false
        collectionView?.reloadData()
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SentCollectionViewCell
        
        cell.image.image = memes[indexPath.row].memedImg
        cell.title.text = memes[indexPath.row].topText
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let memeVC = storyboard?.instantiateViewControllerWithIdentifier("SingleMemeViewController") as! SingleMemeViewController
        
        memeVC.tempTitle = memes[indexPath.row].topText!
        
        if let newImg = memes[indexPath.row].memedImg {
            memeVC.tempImg =  newImg
        }
        
        navigationController!.pushViewController(memeVC, animated: true)
        
    }

}
