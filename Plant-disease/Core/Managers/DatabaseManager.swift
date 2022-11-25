//
//  DatabaseManager.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 08/11/22.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class DatabaseManager{
    
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    private let storage = Storage.storage().reference()
    private let userdefaultsManager = UserDefaultsManager.shared

    func addImg(userName: String, imgDate: String, imgData: UIImage,name: String, typeAndCatergory: String, price: String, per: String, userNameAndDate: String, id: Int){

        storage.child("users/").child("\(userName)_\(imgDate).png").putData(imgData.pngData()!,
                                                         metadata: nil) { _, error in
            guard error == nil else {return}
            
            self.storage.child("users/").child("\(userName)_\(imgDate).png").downloadURL { urL, err in
                guard let url = urL, err == nil else {
                    print("url error")
                    return
                }
                
                let urlString = url.absoluteString

                
                let object: [String: Any] = [
                    "id" : id,
                    "imageDownloadUrl" : urlString,
                    "name" : name as NSObject,
                    "per" : per,
                    "price" : price,
                    "type" : typeAndCatergory,
                ]

                self.database.ref.child("Products").child("\(typeAndCatergory)").child("\(userNameAndDate)").setValue(object)
            }
        }
      
    }
    
   
    func addUserData(username: String,phoneNum: String,password: String){
        let object: [String: Any] = [
            "username" : username as NSObject,
            "phoneNumber" : phoneNum,
            "password" : password
        ]
        database.ref.child("users").child("\(username)").setValue(object)
    }


    func getProduct(productType: String){
        var productData = ProductsModel()
        database.child("Products").child("\(productType)").observe(.value, with: { snapshot in
           
            print(snapshot.value)
            
//            guard let id = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "id").value else {return}
//            guard let productImgUrl = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "imageDownloadUrl").value else {return}
//            guard let productName = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "name").value else {return}
//            guard let productPer = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "per").value else {return}
//            guard let productPrice = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "price").value else {return}
//            guard let productType = snapshot.childSnapshot(forPath: "\(userAndId)").childSnapshot(forPath: "type").value else {return}
            
//            var array: [String] = []
//           
//            array.append("ID: \(id) --- url: \(productImgUrl) --- name: \(productName) --- per: \(productPer) --- price: \(productPrice) --- type: \(productType)")
//            print(array)
            
        })
    }
    
    func getProductsSize(productType: String){
        database.child("Products").child("\(productType)").observe(.value, with: { snapshot in
            self.userdefaultsManager.setDataSize(typeProduct: Int(snapshot.childrenCount)) 
        })
    }
    
}
