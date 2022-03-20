//
//  SignUpViewController.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 13.03.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().containerView(imageName: "ic_mail_outline_white_2x",
                                          textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().containerView(imageName: "ic_lock_outline_white_2x",
                                          textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = UIView().containerView(imageName: "ic_person_outline_white_2x",
                                          textField: fullnameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().containerView(imageName: "",
                                          segmentedControl: accountTypeSegmentedControl, labelName: "Type of your account?")
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(placeholder: "Email",
                                       isSecureTextEntry: false)
    }()
    
    private let fullnameTextField: UITextField = {
        return UITextField().textField(placeholder: "Full Name",
                                       isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(placeholder: "Password",
                                       isSecureTextEntry: true)
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Passenger", "Driver"])
        segmentedControl.backgroundColor = .backgroundColor
        segmentedControl.tintColor = UIColor(white: 1, alpha: 0.87)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let signupButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Already have an account?  ",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                         NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(
            string: "Sign In",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(handleShowSignIn),for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else { return }
            
            let values = ["email" : email,
                          "fullname" : fullname,
                          "accountType" : accountTypeIndex] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { err, ref in
                
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func  configureUI() {
        view.backgroundColor = .backgroundColor
        
        // Title Label - Constraints
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        // Email, Fullname, Password and Segmented Control Stack View - Constraints
        let stackViewForEmailAndPassword = UIStackView(arrangedSubviews: [emailContainerView,
                                                                          fullnameContainerView,
                                                                          passwordContainerView,
                                                                          accountTypeContainerView,
                                                                          signupButton])
        stackViewForEmailAndPassword.axis = .vertical
        stackViewForEmailAndPassword.distribution = .fillProportionally
        stackViewForEmailAndPassword.spacing = 24
        view.addSubview(stackViewForEmailAndPassword)
        stackViewForEmailAndPassword.anchor(top: titleLabel.bottomAnchor,
                                            left: view.leftAnchor,
                                            right: view.rightAnchor,
                                            paddingTop: 40,
                                            paddingLeft: 16,
                                            paddingRight: 16)
        
        // Sign In Button - Constraints
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.centerX(inView: view)
        alreadyHaveAnAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
}
