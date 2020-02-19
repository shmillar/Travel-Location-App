//
//  ViewController.swift
//  Homework2
//
//  Created by Sam Millar on 11/5/19.
//  Copyright © 2019 Sam Millar. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var myCityList:cities =  cities()
    
    var cityList = [String: [city]]()
    let picker = UIImagePickerController()
    var newName = ""
    var newDesc = ""
    var newPic = UIImage()
    var updatedCity:city!
    
    @IBOutlet weak var cityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for var city in myCityList.cities{
            if city.cityName == (updatedCity?.cityName){
                city = updatedCity!
            }
        }
        createCityDictionary()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCityDictionary() {
        // for each fruit in the fruit list from the fruits object
        for city in myCityList.cities {
            
            // extract the first letter as a string for the key
            let cName = city.cityName
            
            let endIndex = cName.index((cName.startIndex), offsetBy: 1)
            
            let cityKey = String(cName[(..<endIndex)])
            
            // build the fruit object array for each key
            if var cityObjects = cityList[cityKey] {
                cityObjects.append(city)
                cityList[cityKey] = cityObjects
                
            } else {
                cityList[cityKey] = [city]
            }
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // get the section count
        return myCityList.citySectionTitles.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete{
            let cityKey = myCityList.citySectionTitles[indexPath.section]
            let cityObjects = self.cityList[cityKey]
            let deletedCity = cityObjects?[indexPath.row]
            
            var x = 0
            
            for city in myCityList.cities{
                x = x + 1
                if city.cityName == (deletedCity?.cityName){
                    myCityList.cities.remove(at: x-1)
                    cityList.removeAll()
                    createCityDictionary()
                }
                else{}
                
            }
        }
        
        self.cityTable.reloadData()
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        // get the section title
        let cityKey = myCityList.citySectionTitles[section]
        
        // use the section title to count howmany fruits are in that section
        if let cityValues = cityList[cityKey]
        {
            return cityValues.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // returns the heading for each section
        return myCityList.citySectionTitles[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        // get the section key
        let cityKey = myCityList.citySectionTitles[indexPath.section]
        
        
        // build each each row for section
        if let cityValues = cityList[cityKey]{
            cell.cityTitle.text = cityValues[indexPath.row].cityName
            
            cell.cityImage.image = cityValues[indexPath.row].cityImage
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailView"){
            let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
            // access the section for the selected row
            let cityKey = myCityList.citySectionTitles[selectedIndex.section]
            
            // get the fruit object for the selected row in the section
            let city = cityList[cityKey]![selectedIndex.row]
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCityName = city.cityName;
                viewController.selectedCityDesc = city.cityDescription;
                viewController.selectedCityImage = city.cityImage;
            }
        }
    }
    
    
    @IBAction func addARecord(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField1 in
            textField1.placeholder = "Enter Name of the City Here"
        })
        alert.addTextField(configurationHandler: { textField2 in
            textField2.placeholder = "Enter Description of the City Here"
        })
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.newName = (alert.textFields?.first!.text)!
                self.newDesc = (alert.textFields?.last!.text)!
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker, animated: true, completion: nil)
            }else{
                print("No Camera")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.newName = (alert.textFields?.first!.text)!
            self.newDesc = (alert.textFields?.last!.text)!
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            print("test")
            self.present(self.picker, animated: true, completion: nil)
        }))
//        alert.addAction(UIAlertAction(title: "Picture", style: .default, handler: { action in
//
//            // Do this first, then use method 1 or method 2
//            if let name = alert.textFields?.first?.text {
//                let desc = alert.textFields?.last?.text
//
//                print("Your name: \(name)")
//                let newCity = city(cn: name, cd: desc!, ci: "banana.jpg")
//                self.myCityList.addCity(newCity: newCity)
//
//                //Method 2
//                let cName = name
//
//                let endIndex = cName.index((cName.startIndex), offsetBy: 1)
//
//                let cityKey = String(cName[(..<endIndex)])
//
//                // adding the new fruit object to hthe dictionary
//                if var cityObjects = self.cityList[cityKey] {
//                    cityObjects.append(newCity)
//                    self.cityList[cityKey] = cityObjects
//
//                } else {
//                    self.cityList[cityKey] = [newCity]
//                }
//                self.cityTable.reloadData()
//            }
//        }))
        
        self.present(alert, animated: true)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        //info[.originalImage] as! UIImage
        
        self.newPic = ((info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage?)!)
        let newCity = city(cn: self.newName, cd: self.newDesc, ci:self.newPic)
        myCityList.addCity(newCity: newCity)
        cityList.removeAll()
        createCityDictionary()
        cityTable.reloadData()
        
        dismiss(animated: true)
        cityTable.reloadData()
    }
    
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? DetailViewController {
            updatedCity = sourceViewController.returnCity
            dump(updatedCity)
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
