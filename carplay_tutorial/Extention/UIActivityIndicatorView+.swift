//
//  UIActivityIndicatorView+.swift
//  carplay_tutorial
//
//  Created by 小柳智之 on 2021/09/14.
//

import UIKit

extension UIActivityIndicatorView{
    func animation(isStart: Bool) {
        DispatchQueue.main.async {
            if isStart {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
        }
    }
}
