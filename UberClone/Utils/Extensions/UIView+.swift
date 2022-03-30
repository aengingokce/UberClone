//
//  UIView+.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 12.03.2022.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddinfLeft: CGFloat = 0, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let leftAnchor = leftAnchor {
            anchor(left: leftAnchor, paddingLeft: paddinfLeft)
        }
    }
    
    func setDimension(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func containerView(imageName: String, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil, labelName: String? = nil) -> UIView {
        let view = UIView()
        let label = UILabel()
        
        if let labelName = labelName {
            label.text = labelName
            label.font = UIFont(name: "Avenir-Light", size: 16)
            label.textColor = UIColor(white: 1, alpha: 0.8)
            view.addSubview(label)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        if let textField = textField {
            view.addSubview(textField)
            textField.centerY(inView: view)
            textField.anchor(left: imageView.rightAnchor, paddingLeft: 8, paddingRight: 8)
        }
        
        if let segmentedControl = segmentedControl {
            label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: -8, paddingLeft: 8)
            label.centerX(inView: view)
            //imageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 8, width: 24, height: 24)
            view.addSubview(segmentedControl)
            segmentedControl.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8)
            segmentedControl.centerY(inView: view, constant: 8)
        }
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lightGray
        view.addSubview(seperatorView)
        seperatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
}
