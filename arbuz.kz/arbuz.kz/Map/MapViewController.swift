//
//  MapViewController.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//


import MapKit
import UIKit
import CoreLocation

final class MapViewController: UIViewController {
    
    //MARK: - Properties
    
    var locationName: String?
    var completion: ((String) -> Void )?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getLocation()
    }
    
    override func viewDidLayoutSubviews() {
        setupLayout()
    }
    
    //MARK: - Setup
    
    private func setupView(){
        view.addSubview(map)
        view.addSubview(continueButton)
        setupNaviagtionController()
    }
    
    private func setupLayout(){
        map.frame = view.bounds
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupNaviagtionController(){
        let image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(dismissButton))
    }
    
    //MARK: - Methods
    
    private func getLocation(){
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    }
    
    private func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(
                                                        latitudeDelta: 0.7,
                                                        longitudeDelta: 0.7)),
                                animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
            self?.locationName = locationName
        }
    }
    
    //MARK: - UI elements
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private let continueButton: CustomButton = {
        let button = CustomButton(title: "Подтвердить")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Objective-C methods
    
    @objc private func dismissButton(){
        dismiss(animated: true)
    }
    
    @objc private func continueButtonPressed() {
        if let locationName = locationName {
            self.completion?(locationName)
        }
        dismiss(animated: true)
    }
}
