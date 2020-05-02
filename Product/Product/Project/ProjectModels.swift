//
//  ProjectModels.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import UIKit

enum ProjectModels {

    // MARK: - Use Cases

    enum FetchFromRemoteDataStore {
        struct Request {
            var projectId: String?
        }

        struct Response {
            var projectDataModel: ProjectDataModel?
        }

        struct ViewModel {
            var projectDataModel: ProjectDataModel?
        }
    }

    // MARK: - Types

    struct Error: Codable {
        let error: Int
        let errorMessage, method: String
    }


    // MARK: - ProjectData
    struct ProjectDataModel: Codable {
        let items: [ProjectDataItem]
        let storage: String
        let error: Int
    }

    // MARK: - ProjectDataItem
    struct ProjectDataItem: Codable {
        let udate, name, s, hash: String
        let uid: String
        let data: DataClass
        let gstatus: String
        let my: Bool
        let readOnly: Int
    }

    // MARK: - DataClass
    struct DataClass: Codable {
        let className: String
        let version, width, height, sscounter: Int
        let s, currentFloor, autoinc: Int
        let ground: Ground
        let v: Int
        let items: [DataItem]
    }

    // MARK: - Ground
    struct Ground: Codable {
        let texture, color: String
    }

    // MARK: - DataItem
    struct DataItem: Codable {
        let className, name: String
        let h: Int
        let puid: String
        let items: [PurpleItem]
    }

    // MARK: - PurpleItem
    struct PurpleItem: Codable {
        let className: PurpleClassName
        let x, y: Double
        let z, sX, sY: Double
        let rtype, h: Int?
        let materials: MaterialsUnion
        let rhidden, fhidden: Bool?
        let puid: String
        let items: [FluffyItem]?
        let id: ID?
        let otf, sZ, fX, fY: Double?
        let a, aframe: Double?
        let stored: Stored?
        let wall: String?
    }

    enum PurpleClassName: String, Codable {
        case ns = "Ns"
        case room = "Room"
        case window = "Window"
    }

    enum ID: Codable {
        case integer(Int)
        case string(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .integer(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            }
        }
    }

    // MARK: - FluffyItem
    struct FluffyItem: Codable {
        let className: FluffyClassName
        let hidden: Bool
        let w: Int
        let materials: ItemMaterialsClass
        let puid: String
        let items: [TentacledItem]
    }

    enum FluffyClassName: String, Codable {
        case wall = "Wall"
    }

    // MARK: - TentacledItem
    struct TentacledItem: Codable {
        let className: TentacledClassName
        let x, y: Double
        let puid: String
    }

    enum TentacledClassName: String, Codable {
        case point = "Point"
    }

    // MARK: - ItemMaterialsClass
    struct ItemMaterialsClass: Codable {
        let indoor, outdoor: Ceil
    }

    // MARK: - Ceil
    struct Ceil: Codable {
        let texture: Texture
        let color: Color
        let scale, rotate: Int
    }

    enum Color: String, Codable {
        case colorFFFFFF = "#FFFFFF"
        case ffffff = "#ffffff"
    }

    enum Texture: String, Codable {
        case laminate0_1_6 = "laminate_0_1_6"
        case linen1_4 = "linen_1_4"
        case wallp0 = "wallp_0"
    }

    enum MaterialsUnion: Codable {
        case materialArray([Material])
        case materialsMaterials(MaterialsMaterials)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([Material].self) {
                self = .materialArray(x)
                return
            }
            if let x = try? container.decode(MaterialsMaterials.self) {
                self = .materialsMaterials(x)
                return
            }
            throw DecodingError.typeMismatch(MaterialsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MaterialsUnion"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .materialArray(let x):
                try container.encode(x)
            case .materialsMaterials(let x):
                try container.encode(x)
            }
        }
    }

    // MARK: - Material
    struct Material: Codable {
        let color: String
        let texture: String?
        let name: String
    }

    // MARK: - MaterialsMaterials
    struct MaterialsMaterials: Codable {
        let floor, ceil, indoor, outdoor: Ceil
    }

    // MARK: - Stored
    struct Stored: Codable {
        let id, cid: String
        let data, className: JSONNull?
        let size: [String]
        let g: Bool
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public func hash(into hasher: inout Hasher) {
            // No-op
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }


}
