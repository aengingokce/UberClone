//
//  LocationInputView.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 30.03.2022.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputViewDelegate?
    
    var user: User? {
        didSet {
            titleLabel.text = user?.fullname
        }
    }
    
    private let backButton: UIButton = {
       let button = UIButton()
       button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
       button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
       return button
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.textColor = .darkGray
       label.font = UIFont.systemFont(ofSize: 16)
       return label
    }()
    
    private let originLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var originLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Current Location"
        textField.backgroundColor = .systemGroupedBackground
        textField.isEnabled = false
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a destination"
        textField.backgroundColor = .lightGray
        textField.returnKeyType = .search
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12, width: 24, height: 25)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(originLocationTextField)
        originLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                       paddingTop: 4, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: originLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                            paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(originLocationIndicatorView)
        originLocationIndicatorView.centerY(inView: originLocationTextField, leftAnchor: leftAnchor, paddinfLeft: 20)
        originLocationIndicatorView.setDimension(height: 6, width: 6)
        originLocationIndicatorView.layer.cornerRadius = 3
        
        addSubview(destinationLocationIndicatorView)
        destinationLocationIndicatorView.centerY(inView: destinationLocationTextField, leftAnchor: leftAnchor, paddinfLeft: 20)
        destinationLocationIndicatorView.setDimension(height: 6, width: 6)
        
        addSubview(linkingView)
        linkingView.centerX(inView: originLocationIndicatorView)
        linkingView.anchor(top: originLocationIndicatorView.bottomAnchor, bottom: destinationLocationIndicatorView.topAnchor,
                           paddingTop: 4, paddingBottom: 4, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
}
