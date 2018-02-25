//
//  PhotoUploadViewController.swift
//  pseudo_Instagram
//
//  Created by Raquel Figueroa-Opperman on 2/24/18.
//  Copyright © 2018 Raquel Figueroa-Opperman. All rights reserved.
//

import UIKit
import Parse

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var uploadText: UITextField!
    @IBOutlet weak var uploadImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true

        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var editedImage = originalImage
        editedImage = resize(image: editedImage, newSize: CGSize(width: 300, height: 300))
        
        // Do something with the images
        uploadImage.image = editedImage

        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height:newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    
    @IBAction func shareUpload(_ sender: Any) {
        Post.postUserImage(image: uploadImage.image, withCaption: uploadText.text) { (success, error) in
            if success {
                print ("Uploaded image!")
            }
            else {
                print (error?.localizedDescription)
            }
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelUpload(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
