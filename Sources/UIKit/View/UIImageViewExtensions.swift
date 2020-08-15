//
//  UIImageViewExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/11.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIImageView {
    @objc func download(from url: URL, placeholder: UIImage? = nil, completionHandler: ((UIImage?) -> Void)? = nil) {
        image = placeholder
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, let image = UIImage(data: data) else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async { [unowned self] in
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }

    /// 使图像视图模糊
    @objc func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    
    /// 用一个UIImage遮罩当前的UIImageView。
    @objc func mask(image: UIImage) {
        let mask = CALayer()
        mask.contents = image.cgImage
        mask.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.mask = mask
        layer.masksToBounds = false
    }
}
