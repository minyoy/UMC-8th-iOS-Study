//
//  ImageHandling.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
}
