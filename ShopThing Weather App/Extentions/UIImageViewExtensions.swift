//
//  UIImageViewExtensions.swift
//  ShopThing Weather App
//
//  Created by Dhruvil Patel on 2021-04-20.
//

import Foundation
import UIKit.UIImageView

extension UIImageView {
    
    /// Fetches and set image from url passed
    /// - Parameter url: Endpoint for img url
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
