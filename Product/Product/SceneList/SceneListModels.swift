//
//  SceneListModels.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

enum SceneListModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
            var projectsList: [String]
        }

        struct ViewModel {
            var projectsList: [String]
        }
    }

}
