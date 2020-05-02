//
//  ProjectWorker.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

class ProjectWorker: NSObject, URLSessionDataDelegate {

    // MARK: - Properties

    typealias Models = ProjectModels


    private let baseUrl = "https://planner5d.com/api/project/"

    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "background_session")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    // MARK: - Methods

    // MARK: Screen Specific Validation

    var completition: ((ProjectModels.ProjectDataModel?)-> Void)?

    func loadProject(projectId: String, completition: @escaping( (ProjectModels.ProjectDataModel?)->Void )) {
        guard
            let url = URL(string: baseUrl + projectId)
        else {
            urlSession.invalidateAndCancel()
            completition(nil)
            return
        }

        self.completition = completition
        urlSession.dataTask(with: url).resume()

    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let projectDataModel = try? JSONDecoder().decode(ProjectModels.ProjectDataModel.self, from: data)
        DispatchQueue.main.async {
            self.completition?(projectDataModel)
        }
        urlSession.invalidateAndCancel()
    }

}

