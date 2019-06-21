//
//  DeliveryListRouter.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright (c) 2019 Deliveries. All rights reserved.


import UIKit

@objc protocol DeliveryListRoutingLogic
{
    func routeToDeliveryPage()
}

protocol DeliveryListDataPassing
{
    var dataStore: DeliveryListDataStore? { get }
}

class DeliveryListRouter: NSObject, DeliveryListRoutingLogic, DeliveryListDataPassing
{
    weak var viewController: DeliveryListViewController?
    var dataStore: DeliveryListDataStore?
    
    
    func routeToDeliveryPage()
    {
        let destinationVC = DeliveryPageViewController(nibName: nil, bundle: nil)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDeliveryPage(source: dataStore!, destination: &destinationDS)
        navigateToDeliveryPage(source: viewController!, destination: destinationVC)
    }
    
    func navigateToDeliveryPage(source: DeliveryListViewController, destination: DeliveryPageViewController)
    {
        source.show(destination, sender: nil)
    }
    
    func passDataToDeliveryPage(source: DeliveryListDataStore, destination: inout DeliveryPageDataStore)
    {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.delivery = viewController?.deliveris[selectedRow!]
    }
}
