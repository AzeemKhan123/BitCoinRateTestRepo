//
//  File.swift
//  BitCoinSample
//
//  Created by Abdul Azeem on 23/01/2019.
//  Copyright © 2019 Abdul Azeem Khan. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        let path = UIBezierPath(rect: CGRect(origin: CGPoint(), size: size))
        color.setFill()
        path.fill()
        if let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
            self.init(cgImage: image)
        } else {
            return nil
        }
    }
}
