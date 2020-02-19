//
//  cities.swift
//  Homework2
//
//  Created by Sam Millar on 11/5/19.
//  Copyright © 2019 Sam Millar. All rights reserved.
//

import Foundation
import UIKit
class cities
{
    var cities:[city] = []
    let citySectionTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    init()
    {
        
    }
    
    func addCity(newCity: city){
        cities.append(newCity)
    }
    
    func removeCityObject(index: Int) {
        cities.remove(at: index)
    }
    
}
class city
{
    var cityName:String
    var cityDescription:String
    var cityImage:UIImage
    
    init(cn:String, cd:String, ci:UIImage)
    {
        cityName = cn
        cityDescription = cd
        cityImage = ci
        
    }
    
    
}
