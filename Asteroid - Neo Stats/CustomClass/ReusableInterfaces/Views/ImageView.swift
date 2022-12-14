//
//  ImageView.swift
//  TropProf
//
//  Created by Keyur on 21/12/21.
//

import UIKit

//@IBDesignable
class ImageView: UIImageView {
    
    var isDownloadingImage = false
    
    @IBInspectable var bgColor : UIColor? {
        didSet {
            setBackgroundColor(color: bgColor)
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        didSet {
            setBorderColor(borderColor: borderColor!)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialzeImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialzeImageView()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        initialzeImageView()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        initialzeImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialzeImageView() {
//        kf_showIndicatorWhenLoading = true
    }

    func downloadImage(from url : String?, placeHolderImageName : String?) {
//        isDownloadingImage = true
//
//        let placeHolder = placeHolderImageName != nil ? UIImage(named: placeHolderImageName!) : nil
//
//        if isEmptyString(string: url) == false {
//            self.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: placeHolder, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
//                self.isDownloadingImage = false
//                if image == nil {
//                    self.image = placeHolder
//                }
//            })
//        } else {
//            isDownloadingImage = false
//            self.image = placeHolder
//        }
    }
}
