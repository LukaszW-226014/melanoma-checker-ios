//
//  ViewController.swift
//  Melanoma Checker
//
//  Created by Łukasz Wójcik on 15/11/2018.
//  Copyright © 2018 Łukasz Wójcik. All rights reserved.
//

import UIKit

import Photos

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imagePicked: UIImage!
    
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showAlertBy("Error", "Camera is not available!")
        }
    }
    
    @IBAction func browsePhotos(_ sender: UIButton) {
        self.checkPhotoLibraryPermission()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showAlertBy("Error", "Photo library is not available")
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Authorized")
            break
        //handle authorized status
        case .denied, .restricted :
            print("Denied or Restricted")
            break
        //handle denied status
        case .notDetermined:
            print("Not Determined")
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("2 Authorized")
                    break
                // as above
                case .denied, .restricted:
                    print("2 Denied or Restricted")
                    break
                // as above
                case .notDetermined:
                    print("2 not determined")
                    break
                    // won't happen but still
                }
            }
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // Local variable inserted by Swift 4.2 migrator.
        if let image = info[.originalImage] as? UIImage {
            imagePicked = image
            print("image found: \(imagePicked.size)")
            //do something with an image
            dismiss(animated: true, completion: { self.setAdditionalParams() })
        } else {
            print("Not able to get an image")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlertBy(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goToManual(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let manual = main.instantiateViewController(withIdentifier: "ManualVC")
        self.present(manual, animated: true, completion: nil)
    }
    
    private func setAdditionalParams() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let parameters = main.instantiateViewController(withIdentifier: "ParametersVC")
        self.present(parameters, animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true)
//
//        guard let image = info[.editedImage] as? UIImage else {
//            print("No image found")
//            return
//        }
//
//        // print out the image size as a test
//        print(image.size)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

@IBDesignable class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}

