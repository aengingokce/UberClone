//
//  LoginViewController.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 12.03.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
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
    
    private let emailTextField: UITextField = {
        return UITextField().textField(placeholder: "Email",
                                       isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(placeholder: "Password",
                                       isSecureTextEntry: true)
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Don't have an account?  ",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                        NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(
            string: "Sign Up",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                        NSAttributedString.Key.foregroundColor : UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    //SignUp Button Tapped
    @objc func handleShowSignUp() {
        let controller = SignUpViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let vc = UIApplication.shared.keyWindow?.rootViewController as? HomeViewController else { return }
            vc.configureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        configureNavigationBar()
        view.backgroundColor = .backgroundColor
        
        // Title Label - Constraints
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        // Email and Password Stack View - Constraints
        let stackViewForEmailAndPassword = UIStackView(arrangedSubviews: [emailContainerView,
                                                                          passwordContainerView,
                                                                          loginButton])
        stackViewForEmailAndPassword.axis = .vertical
        stackViewForEmailAndPassword.distribution = .fillEqually
        stackViewForEmailAndPassword.spacing = 16
        view.addSubview(stackViewForEmailAndPassword)
        stackViewForEmailAndPassword.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                                            right: view.rightAnchor, paddingTop: 40,
                                            paddingLeft: 16, paddingRight: 16)
        
        // Sign Up Button - Constraints
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
}
