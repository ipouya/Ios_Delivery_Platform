//
//  DeliveryListViewController.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright (c) 2019 Deliveries. All rights reserved.

import UIKit
import SDWebImage

protocol DeliveryListDisplayLogic: class
{
    func displayDeliveries(viewModel: DeliveryList.FetchData.ViewModel)
    func displayCacheDeliveries(viewModel: DeliveryList.CacheData.ViewModel)
}

class DeliveryListViewController: UITableViewController, DeliveryListDisplayLogic
{
    
    var interactor: DeliveryListBusinessLogic?
    var router: (NSObjectProtocol & DeliveryListRoutingLogic & DeliveryListDataPassing)?
    var deliveris = [Delivery]()
    var lastPage = false
    var offset = 0
    let limit = 10
    
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
        let interactor = DeliveryListInteractor()
        let presenter = DeliveryListPresenter()
        let router = DeliveryListRouter()
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
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 66
        self.tableView.estimatedRowHeight = 66
        
        fetchDeliverisFromCache()
    }
    
    func changeTitle (_ isLoading : Bool){
        if isLoading{
           self.title = "Loading data ..."
        }else{
           self.title = "Things to delivers"
        }
    }
    func fetchDeliverisFromServer()
    {
        changeTitle(true)
        var request = DeliveryList.FetchData.Request()
        request.limit = limit
        request.offset = offset
        interactor?.fetchDeliveriesFromServer(request: request)
    }
    
    func fetchDeliverisFromCache()
    {
        let request = DeliveryList.CacheData.Request()
        interactor?.fetchDeliverisFromCache(request: request)
    }
    
    func displayCacheDeliveries(viewModel: DeliveryList.CacheData.ViewModel)
    {
        if viewModel.deliveries?.count ?? 0  > 0 {
            self.deliveris.append(contentsOf: viewModel.deliveries!)
            self.tableView.reloadData()
        }
        fetchDeliverisFromServer()
    }
    
    func displayDeliveries(viewModel: DeliveryList.FetchData.ViewModel)
    {
        switch viewModel.state {
        case .loading:
            print("loading")
        case .success(let data):
            if offset == 0 {
                self.deliveris.removeAll() // empty array from Cache data
            }
            self.offset += limit
            self.deliveris.append(contentsOf: data)
            
            self.tableView.reloadData()
            if data.count < limit {
                self.lastPage = true
            }
        case .failure(let error):
            print(error.message)
        }
        changeTitle(false)
    }
    
}

extension DeliveryListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveris.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == deliveris.count - 1 && !lastPage{
            fetchDeliverisFromServer()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.deliveris[indexPath.row]
        let cell = DeliveryCell()
        cell.deliveryImage.sd_setImage(with: URL(string: item.imageUrl!), placeholderImage: UIImage(named: "no-icon"))
        cell.descriptionLable.text = item.desc!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDeliveryPage()
    }
}




