//
//  DeliveryPageViewController.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright (c) 2019 Deliveries. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import MapKit

protocol DeliveryPageDisplayLogic: class
{
    func displayPassedData(viewModel: DeliveryPage.PassedData.ViewModel)
}

class DeliveryPageViewController: UIViewController, DeliveryPageDisplayLogic,MKMapViewDelegate
{
    
    var interactor: DeliveryPageBusinessLogic?
    var router: (NSObjectProtocol & DeliveryPageRoutingLogic & DeliveryPageDataPassing)?
    
    let mapView : MKMapView = {
        let view = MKMapView()
        view.tintColor = UIColor.orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let detailView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#fcfcfc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deliveryImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let descriptionLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup()
    {
        let viewController = self
        let interactor = DeliveryPageInteractor()
        let presenter = DeliveryPagePresenter()
        let router = DeliveryPageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Delivery details"
        self.mapView.delegate = self
        
        configUI()
        getPassedData()
    }
    
    func getPassedData()
    {
        let request = DeliveryPage.PassedData.Request()
        interactor?.getPassedData(request: request)
    }
    
    func displayPassedData(viewModel: DeliveryPage.PassedData.ViewModel)
    {
        configMap(CLLocationCoordinate2D(
            latitude:viewModel.delivery?.location.lat ?? 0,
            longitude:viewModel.delivery?.location.lng ?? 0))
        deliveryImage.sd_setImage(with: URL(string: viewModel.delivery?.imageUrl ?? ""), placeholderImage: UIImage(named: "no-icon"))
        descriptionLable.text = viewModel.delivery?.desc ?? ""
    }
    
    func configMap(_ location:CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.02,longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func configUI(){
        self.view.addSubview(mapView)
        self.view.addSubview(detailView)
        self.detailView.addSubview(deliveryImage)
        self.detailView.addSubview(descriptionLable)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: detailView.topAnchor),
            
            detailView.heightAnchor.constraint(equalToConstant: 100),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            deliveryImage.heightAnchor.constraint(equalToConstant: 80),
            deliveryImage.widthAnchor.constraint(equalToConstant: 80),
            deliveryImage.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 8),
            deliveryImage.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            
            descriptionLable.heightAnchor.constraint(equalTo: deliveryImage.heightAnchor),
            descriptionLable.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 8),
            descriptionLable.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -8),
            descriptionLable.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            ])
        
    }
}
