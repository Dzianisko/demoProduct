//
//  ProjectViewController.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol ProjectDisplayLogic: class {
    func displayFetchFromRemoteDataStore(with viewModel: ProjectModels.FetchFromRemoteDataStore.ViewModel)
}

class ProjectViewController: UIViewController, ProjectDisplayLogic {

    // MARK: - Properties

    typealias Models = ProjectModels
    var router: (NSObjectProtocol & ProjectRoutingLogic & ProjectDataPassing)?
    var interactor: ProjectBusinessLogic?

    var projectDataModel: Models.ProjectDataModel?

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
        let interactor = ProjectInteractor()
        let presenter = ProjectPresenter()
        let router = ProjectRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSKView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchFromRemoteDataStore()
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: ProjectModels.FetchFromRemoteDataStore.ViewModel) {
        projectDataModel = viewModel.projectDataModel
        updateProject()
    }


    // MARK: - SKView

    var projectScene: ProjectScene? = SKScene(fileNamed: "ProjectScene") as? ProjectScene

    func setupSKView() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'ProjectScene.sks'
            if let scene = projectScene {
                self.projectScene = scene
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    func updateProject() {
        guard let projectModel = projectDataModel?.items.first else { return }
        projectScene?.label?.text = projectModel.name
        projectScene?.size = view.bounds.size

        let scale = max(view.bounds.size.width / CGFloat(projectModel.data.width),
                        view.bounds.size.height / CGFloat(projectModel.data.height) )

        let root = SKNode()
        root.position = .zero

        projectModel.data.items.forEach { (floor) in
            floor.items.forEach { (room) in
                switch room.className {
                case .room:
                    let shape = SKShapeNode()
                    let path = UIBezierPath()
                    path.move(to: .zero)

                    room.items?.forEach({ (wall) in
                        guard wall.className == .wall else { return }

                        wall.items.forEach { (point) in
                            if path.currentPoint == .zero {
                                path.move(to: CGPoint(x: CGFloat(point.x) * scale,
                                                      y: CGFloat(point.y) * scale))
                            } else {
                                path.addLine(to: CGPoint(x: CGFloat(point.x) * scale,
                                                         y: CGFloat(point.y) * scale))
                            }
                            guard point.className == .point else { return }
                        }
                    })
                    shape.path = path.cgPath
                    shape.strokeColor = UIColor.darkGray
                    shape.lineWidth = 2
                    shape.fillTexture = SKTexture(imageNamed: "floor")
                    shape.fillColor = .white
                    shape.position = CGPoint(x: CGFloat(room.x) * scale, y: CGFloat(room.y) * scale)
                    root.addChild(shape)

                case .window:

                    break

                case .ns:
                    break
                }
            }
        }

        let frm = root.calculateAccumulatedFrame()
        root.position = CGPoint(x: -frm.midX, y: -frm.midY)
        projectScene?.addChild(root)
    }

}
