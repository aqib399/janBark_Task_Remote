//
//  ImagesViewModel.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import Foundation

import UIKit

var items = [ImagesModel]()
class ImagesViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var imagesData : [ImagesModel]! {
        didSet {
            self.bindImagesViewModelToController()
        }
    }
    
    var bindImagesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToCheckAvailability()
       
    }

    func callFuncToCheckAvailability() {
        if ConnectionManager.shared.hasConnectivity(){
            self.callFuncToGetImages(pageUrl: "https://api.pexels.com/v1/search/?page=1&per_page=15&query=people")
        }else {
            showMessage(message: "No internet connection")
        }
        
    }
    func showMessage(message : String = "")  {
        var messageInfo = ""
        messageInfo = message
        let alert = UIAlertController(title: "Important", message: messageInfo, preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: { action in
                    exit(0)
            }))
        UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true)
         
    }
    func callFuncToGetImages(pageUrl: String) {
        self.apiService.getImages(pageUrl: pageUrl) { (imagesData) in
            self.imagesData = items
        }
        
    }
    
}

struct cellViewModel {
    var photoGrapherName: String
    var imageURL: String
}

