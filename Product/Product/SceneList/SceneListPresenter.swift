//
//  SceneListPresenter.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol SceneListPresentationLogic {
    func presentFetchFromLocalDataStore(with response: SceneListModels.FetchFromLocalDataStore.Response)
}

class SceneListPresenter: SceneListPresentationLogic {

    // MARK: - Properties

    typealias Models = SceneListModels
    weak var viewController: SceneListDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: SceneListModels.FetchFromLocalDataStore.Response) {
        let projectsList = response.projectsList
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(projectsList: projectsList)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

}
