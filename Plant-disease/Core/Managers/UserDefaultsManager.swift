//
//  UserDefaultsManager.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 02/11/22.
//

import Foundation
import UIKit

class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    
    //MARK: SET
    func setUserName(username: String, password: String, isUserEnter: Bool){
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
    }
    
    func setImgNum(imgNum: Int){
        defaults.set(imgNum, forKey: "imageNumber")
    }
    
    func setImageURL(imgUrl: String){
        defaults.set(imgUrl, forKey: "imageUrl")
    }
    
    func setUserEnter(isUserEntered: Bool){
        defaults.set(isUserEntered, forKey: "isUserEnter")
    }
    
    
    func setPhoneNumber(userPhoneNumber: String){
        defaults.set(userPhoneNumber, forKey: "phoneNumber")
    }
    
    func setDataSize(typeProduct: Int){
        defaults.set(typeProduct, forKey: "productCount")
    }
    
    //MARK: GET
    func getDataSize()->Int{
        defaults.integer(forKey: "productCount")
    }
    
    
    func getUsername()->String{
         defaults.string(forKey: "username") ?? ""
    }

    
    func getPassword()->String{
        defaults.string(forKey: "password") ?? ""
    }
    
    
    func getUserIsEntered()->Bool{
        defaults.bool(forKey: "isUserEnter") 
    }
    
    
    func getPhoneNumber()->String{
        defaults.string(forKey: "phoneNumber") ?? ""
    }
    
    
    func getImageUrl()->String{
        defaults.string(forKey: "imageUrl") ?? ""
    }
    
    func getImgNum()->Int{
        defaults.integer(forKey: "imageNumber")
    }
}
