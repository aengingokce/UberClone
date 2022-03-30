//
//  LocationInputActivationView.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 26.03.2022.
//

import UIKit

protocol LocationInputActivationViewDelegate: AnyObject {
    func presentLocationInputActivationView()
}

class LocationInputActivationView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputActivationViewDelegate?
    
    private let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel: UILabel = {
       let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        addSubview(indicatorView)
        indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddinfLeft: 16)
        indicatorView.setDimension(height: 6, width: 6)
        
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddinfLeft: 20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func presentLocationInputView() {
        delegate?.presentLocationInputActivationView()
    }
    
}
