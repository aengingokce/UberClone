//
//  HomeViewController.swift
//  UberClone
//
//  Created by Ahmet Engin Gökçe on 21.03.2022.
//

import UIKit
import Firebase
import MapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}
