//
//  ViewController.swift
//  MemeSon
//
//  Created by Siva Ganesh on 06/09/15.
//  Copyright (c) 2015 Siva Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bottomToolbar: UIToolbar!

    @IBOutlet weak var userGuide: UILabel!
    
    @IBOutlet weak var userGuideImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true
    
        defaultMemeTextDisappear()
        defaultHideBtns()
        
        subscribeToKeyboardNotification()
        subscribeToKeyboardHideNotification()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        camButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        topText.delegate = topTextDelegate
        bottomText.delegate = bottomTextDelegate
        
        textChar()
        
    }
    
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    var topTextDelegate = TopTextDelegate()
    var bottomTextDelegate = BottomTextDelegate()
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var camButton: UIBarButtonItem!
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBAction func picImage(sender: UIBarButtonItem) {
        let pickerCont = UIImagePickerController()
        pickerCont.delegate = self
        pickerCont.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerCont, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let imgSelected = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let screenSize = UIScreen.mainScreen().bounds.size;
            
            imgView.image = scaleUIImageToSize(imgSelected, size: screenSize)

            imgView.autoresizingMask = [.FlexibleBottomMargin, .FlexibleHeight, .FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleTopMargin, .FlexibleWidth ]
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            
            
            userGuide.hidden = true
            userGuideImage.hidden = true
            defaultMemeTextAppear()
            shareBtn.enabled = true

            // Disabled for Review Purpose.
            // enableSaveBtn()

        }
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func camImage(sender: UIBarButtonItem) {
        
        let camCont = UIImagePickerController()
        camCont.delegate = self
        camCont.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(camCont, animated: true, completion: nil)
        
    }
    
    var savedImg : UIImage?
    
    @IBAction func saveMeme(sender: UIBarButtonItem) {
        
        saveMemeFn()
        
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        
        savedImg = generateMemedImage()
        
        if let img = savedImg{
            let title = topText.text!
            let avCont = UIActivityViewController(activityItems: [title, img], applicationActivities: nil)
            presentViewController(avCont, animated: true, completion: {
                self.saveMemeFn()
            })
        }
        
    }
        
    @IBAction func memeModel(sender: AnyObject) {
        
        var memes: [Meme] {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        }
        
    }
    
    
    // MARK : Helper Functions
    
    func saveMemeFn(){
        
        let newImg = generateMemedImage()
        
        //Create the meme
        let meme = Meme( text1: topText.text!, text2: bottomText.text!, image: imgView.image!, newImage: newImg)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        imgView.image = newImg
        
        defaultMemeTextDisappear()
    
    }
    
    func disableSaveBtn(){
        saveBtn.enabled = false
    }
    
    func enableSaveBtn(){
        saveBtn.enabled = true
    }
    
    func textChar(){
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : "-5.2"
        ]
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center


    }
    
    
    func defaultMemeTextDisappear(){
        topText.hidden = true
        bottomText.hidden = true
    }
    
    func defaultMemeTextAppear(){
        topText.hidden = false
        bottomText.hidden = false
    }
    
    func defaultHideBtns(){
        shareBtn.enabled = false
        saveBtn.enabled = false
    }
    
    func generateMemedImage() -> UIImage
    {
        
        // Hiding toolbar and navbar
        
        bottomToolbar.hidden = true
        navigationController?.navigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Showing toolbar and navbar
        bottomToolbar.hidden = false
        navigationController?.navigationBarHidden = false
        
        
        return memedImage
    }
    
    
    
    /* From http://nshipster.com/image-resizing/ */
    
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    // NSNotifications
    
    // Mark : Move Keyboard
    
    func subscribeToKeyboardNotification(){
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification){

        // Note : Swift 2 - weird issue with getKeyBoardHeight
        // view.frame.origin.y -= getKeyboardHeight(notification)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.height - keyboardSize.height)
        }
        
        // Alternate
        /*
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
        view.frame.origin.y -= keyboardSize.height
        print(view.frame.origin.y)
        print(keyboardSize.height)
        }
        */

        disableSaveBtn()
        
    }
    
    /*
    Note : Swift 1.2 code. Not using now.
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
        
    }
    */
    
    func unsubscribeToKeyboardNotification(){
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // Move the pic back to bottom
  
    func subscribeToKeyboardHideNotification(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    func keyboardWillHide(notification: NSNotification){

        // Note : Swift 2 - weird issue with getKeyBoardHeight
        // view.frame.origin.y += getKeyboardHeight(notification)
        
        
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, UIScreen.mainScreen().bounds.size.height)
        
        // Alternate
        /*
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
        view.frame.origin.y += keyboardSize.height
        }
        */
        
        // Disabled for Review
        // enableSaveBtn()
        
    }
    
   
    func unsubscribeToKeyboardHideNotification(){
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }


}

