//
//  UIViewExtension.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 22/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibFile = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nibFile.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view ?? UIView()
    }
}
