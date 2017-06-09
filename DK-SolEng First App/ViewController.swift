//
//  ViewController.swift
//  DK-SolEng First App
//
//  Created by Dave Kanter on 6/5/17.
//  Copyright © 2017 Rubicon Project. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RFMAdDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var simpsonCharNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //RUBICON:
    //Creates the ad view
    //Replaces line @interface SimpleBannerViewController()<RFMADelegate>
    weak var SimpleBannerViewController: RFMAdDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        //RUBICON
        //put the banner in the app
        //Need to refactor for swift:
        //RFMAdView [createAdwithDelegate:self];
        
        //swift refactor
        //SimpleBannerViewController.delegate = self
        
        //RFMAdView.createAd(with: self as! RFMAdDelegate)
        //weak var delegate:
        //THIS IS NOT RIGHT
        _ = RFMAdRequest.init(requestWithServer: "", andAppId: "", andPubId: "") //all constants
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        simpsonCharNameLabel.text = textField.text
    }
    
    //MARK: RFMAdDelegate
//    func didReceiveAd(_ adView: RFMAdView!) {
//        guard let RFMAdDelegateImage = createAd[RFMAdView] as?
//            UIImage else {
//                fatalError("Expected an ad image, but was provided the following: \(createAd)")
//        }
//        
//        //SimpleBannerViewController should be set to the imported image
//        SimpleBannerViewController.image = RFMAdDelegateImage
//    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representations of the image.  You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else{
                fatalError("Expected a dictionary containining an image, but was provided the following: \(info)")
        }
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        simpsonCharNameLabel.text = "Simpsons Character"
    }
}



