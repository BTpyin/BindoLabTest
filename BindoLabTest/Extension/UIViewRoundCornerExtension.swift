//
//  UIViewRoundCornerExtension.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 29/4/2021.
//

import UIKit

extension UIView {
  func roundCorners(cornerRadius: Double) {
    self.layer.cornerRadius = CGFloat(cornerRadius)
    self.clipsToBounds = true
  }
  
}
