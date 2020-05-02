//
//  SceneListInteractor.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol SceneListBusinessLogic {
    func fetchFromLocalDataStore(with request: SceneListModels.FetchFromLocalDataStore.Request)
}

protocol SceneListDataStore {
    var projectsList: [String] { get set }
}

class SceneListInteractor: SceneListBusinessLogic, SceneListDataStore {

    // MARK: - Properties

    typealias Models = SceneListModels

    lazy var worker = SceneListWorker()
    var presenter: SceneListPresentationLogic?

    var projectsList = [String]()

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: SceneListModels.FetchFromLocalDataStore.Request) {
        projectsList = worker.fetchFromDataStore()
        let response = Models.FetchFromLocalDataStore.Response(projectsList: projectsList)
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

}
