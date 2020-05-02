//
//  SceneListRouter.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol SceneListRoutingLogic {
    func routeTo(projectId: String)
}

protocol SceneListDataPassing {
    var dataStore: SceneListDataStore? { get }
}

class SceneListRouter: NSObject, SceneListRoutingLogic, SceneListDataPassing {

    // MARK: - Properties

    weak var viewController: SceneListViewController?
    var dataStore: SceneListDataStore?

    // MARK: - Routing

    func routeTo(projectId: String) {
         let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
         var destinationDS = destinationVC.router!.dataStore!
         passDataTo(&destinationDS, from: projectId)
         viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

     func passDataTo(_ destinationDS: inout ProjectDataStore, from projectId: String) {
         destinationDS.projectId = projectId
     }
}
