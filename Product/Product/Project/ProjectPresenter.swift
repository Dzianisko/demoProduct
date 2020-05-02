//
//  ProjectPresenter.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol ProjectPresentationLogic {
    func presentFetchFromRemoteDataStore(with response: ProjectModels.FetchFromRemoteDataStore.Response)
}

class ProjectPresenter: ProjectPresentationLogic {

    // MARK: - Properties

    typealias Models = ProjectModels
    weak var viewController: ProjectDisplayLogic?

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: ProjectModels.FetchFromRemoteDataStore.Response) {
        let projectDataModel = response.projectDataModel
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(projectDataModel: projectDataModel)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

}
