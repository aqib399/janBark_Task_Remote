//
//  imagesCollectionCell.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import UIKit
import Kingfisher
class imagesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var photoGrapherName: UILabel!
    @IBOutlet weak var imagesIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBgView()
    }
    public func configure (with viewmodel :cellViewModel){
        photoGrapherName.text = "\(viewmodel.photoGrapherName)"
        imagesIcon.kf.indicatorType = .activity
        imagesIcon.kf.setImage(with: URL(string: "\(viewmodel.imageURL)"))
        
    }
    func setBgView()  {
        bgView.layer.cornerRadius = 8.0
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 1.0
    }
}
