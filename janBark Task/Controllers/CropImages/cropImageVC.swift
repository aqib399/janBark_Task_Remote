//
//  cropImageVC.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import UIKit
import Kingfisher
class cropImageVC: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photoThumbnail: UIImage!
    private var cropVM : cropViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavigationBar(title: "Crop Image")
        self.leftBarButton()
        self.imageView.image = photoThumbnail
        cropVM = cropViewModel()
    }

}
extension cropImageVC{
    
    @IBAction func cropImage34(_ sender: Any) {
        self.imageView.image = photoThumbnail
        self.imageView.image = cropVM.crop(image: self.imageView.image!, to: 3/4)
    }
    
    @IBAction func cropImage54(_ sender: Any) {
        self.imageView.image = photoThumbnail
        self.imageView.image = cropVM.crop(image: self.imageView.image!, to: 5/4)
        
    }
    
    @IBAction func cropImage916(_ sender: Any) {
        self.imageView.image = photoThumbnail
        self.imageView.image = cropVM.crop(image: self.imageView.image!, to: 9/16)
        
    }
    @IBAction func cropImage169(_ sender: Any) {
        self.imageView.image = photoThumbnail
        self.imageView.image = cropVM.crop(image: self.imageView.image!, to: 16/9)
        
    }
    
}
