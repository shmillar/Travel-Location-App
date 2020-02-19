//
//  DetailViewController.swift
//  Homework2
//
//  Created by Sam Millar on 11/5/19.
//  Copyright © 2019 Sam Millar. All rights reserved.
//

import Foundation
import UIKit
import Photos

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedCityName:String?
    var selectedCityImage:UIImage?
    var selectedCityDesc:String?
    var returnCity:city!
    
    let picker = UIImagePickerController()
    var newPic = UIImage()
    
    @IBOutlet weak var cityNameField: UILabel!
    @IBOutlet weak var cityImageField: UIImageView!
    @IBOutlet weak var cityDescriptionField: UITextField!
    @IBOutlet weak var segmentUpdate: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityNameField.text = selectedCityName
        self.cityDescriptionField.text = selectedCityDesc
        self.cityImageField.image = selectedCityImage
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updatePicture(_ sender: Any) {
        if segmentUpdate.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker, animated: true, completion: nil)
            }else{
                print("No Camera")
            }
        }
        else if segmentUpdate.selectedSegmentIndex == 1
        {
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        //info[.originalImage] as! UIImage
        
        self.newPic = ((info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage?)!)
        self.cityImageField.image = newPic
        
        dismiss(animated: true)

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "updateCity"){
//            let newCity = city(cn: self.cityNameField.text!, cd: self.cityDescriptionField.text!, ci:self.cityImageField.image!)
//            if let viewController: ViewController = segue.destination as? ViewController {
//                viewController.updatedCity = newCity
//            }
//        }
//    }
    @IBAction func saveUpdate(_ sender: Any) {
        returnCity = city(cn: self.cityNameField.text!, cd: self.cityDescriptionField.text!, ci:self.cityImageField.image!)
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
//    @IBAction func dismissVC(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
