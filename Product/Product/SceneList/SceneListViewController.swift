//
//  SceneListViewController.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

protocol SceneListDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: SceneListModels.FetchFromLocalDataStore.ViewModel)
}

class SceneListViewController: UIViewController, SceneListDisplayLogic {

    // MARK: - Properties

    typealias Models = SceneListModels
    var router: (NSObjectProtocol & SceneListRoutingLogic & SceneListDataPassing)?
    var interactor: SceneListBusinessLogic?

    var projectsList = [String]()

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = SceneListInteractor()
        let presenter = SceneListPresenter()
        let router = SceneListRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - TableView

    @IBOutlet weak var tableView: UITableView!

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
        setupTableView()
    }

    // MARK: - Use Case - Fetch From Local DataStore

    func setupFetchFromLocalDataStore() {
        let request = Models.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: SceneListModels.FetchFromLocalDataStore.ViewModel) {
        projectsList = viewModel.projectsList
        tableView.reloadData()
    }

}

// MARK: - UITableViewController

extension SceneListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsList.count
    }

}

// MARK: - UITableViewCell

extension SceneListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") else { return .init() }
        cell.detailTextLabel?.text = projectsList[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeTo(projectId: projectsList[indexPath.row])
    }
}
