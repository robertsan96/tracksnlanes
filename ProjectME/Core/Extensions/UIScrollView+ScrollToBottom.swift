//
//  UIScrollView+ScrollToBottom.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
