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
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private let locationInputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        checkLocationPermission()
        //signOut()
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
        configureMapView()
        
        locationInputActivationView.delegate = self
        
        view.addSubview(locationInputActivationView)
        locationInputActivationView.centerX(inView: view)
        locationInputActivationView.setDimension(height: 50, width: view.frame.width - 64)
        locationInputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        locationInputActivationView.alpha = 0
        UIView.animate(withDuration: 1 ) {
            self.locationInputActivationView.alpha = 1
        }
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 200)
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            print("TableView")
        }

    }
}

    // MARK: - Location Services

extension HomeViewController: CLLocationManagerDelegate {
    
    func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            fatalError()
            break
        }
    }
    
    // Allows immediately ask permission to user
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
}

    // MARK: - Extensions

extension HomeViewController: LocationInputActivationViewDelegate {
    func presentLocationInputActivationView() {
        configureLocationInputView()
        locationInputActivationView.alpha = 0
        
    }
}

extension HomeViewController: LocationInputViewDelegate {
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.locationInputActivationView.alpha = 1
            }
        }
    }
}
