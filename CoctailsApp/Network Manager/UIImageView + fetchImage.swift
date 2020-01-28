//
//  UIImageView + fetchImage.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

extension UIImageView {
    func fetchImage(fromURL string: String?) {
        
        guard let string = string else { return }
        guard let imageURL = URL(string: string) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
