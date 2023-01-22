//
//  cropViewModel.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import Foundation

import UIKit
class cropViewModel : NSObject {
    
    func crop(image: UIImage, to aspectRatio: CGFloat) -> UIImage {
        
        let originalAspectRatio = image.size.height/image.size.width
        
        var newImagesize = image.size
        
        if originalAspectRatio > aspectRatio {
            newImagesize.height = image.size.width * aspectRatio
        } else if originalAspectRatio < aspectRatio {
            newImagesize.width = image.size.height / aspectRatio
        } else {
            return image
        }
        
        let center = CGPoint(x: image.size.width/2, y: image.size.height/2)
        let origin = CGPoint(x: center.x - newImagesize.width/2, y: center.y - newImagesize.height/2)
        
        let cgCroppedImage = image.cgImage!.cropping(to: CGRect(origin: origin, size: CGSize(width: newImagesize.width, height: newImagesize.height)))!
        let croppedImage = UIImage(cgImage: cgCroppedImage, scale: image.scale, orientation: image.imageOrientation)
        
        return croppedImage
    }
}
