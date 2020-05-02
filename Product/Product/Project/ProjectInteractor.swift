//
//  ProjectInteractor.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol ProjectBusinessLogic {
    func fetchFromRemoteDataStore(with request: ProjectModels.FetchFromRemoteDataStore.Request)
}

protocol ProjectDataStore {
    var projectId: String? { get set }
}

class ProjectInteractor: ProjectBusinessLogic, ProjectDataStore {

    // MARK: - Properties

    typealias Models = ProjectModels

    lazy var worker = ProjectWorker()
    var presenter: ProjectPresentationLogic?

    var projectId: String?

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: ProjectModels.FetchFromRemoteDataStore.Request) {
        worker.loadProject(projectId: projectId ?? "") { [weak self] projectDataModel in
            let response = Models.FetchFromRemoteDataStore.Response(projectDataModel: projectDataModel)
            self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        }
    }

}
