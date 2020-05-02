//
//  ProjectRouter.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol ProjectRoutingLogic {
    func routeToNext()
}

protocol ProjectDataPassing {
    var dataStore: ProjectDataStore? { get }
}

class ProjectRouter: NSObject, ProjectRoutingLogic, ProjectDataPassing {

    // MARK: - Properties

    weak var viewController: ProjectViewController?
    var dataStore: ProjectDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: ProjectDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
