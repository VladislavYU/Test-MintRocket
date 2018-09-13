//
//  MoyaService.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case listAllPublicRepositories(since: String?)
    case repository(name: String)
}

extension MoyaService: TargetType {
    var baseURL: URL {
        switch self {
        case .listAllPublicRepositories(let since):
            if let since = since {
                guard let url = URL(string: "https://api.github.com/repositories?since=\(since)") else { break }
                return url
            } else {
                guard let url = URL(string: "https://api.github.com/repositories") else { break}
                return url
            }
        case .repository:
            guard let url = URL(string: "https://github.com/") else { break }
            return url
        }
        return URL(string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        case .repository(let name):
            return "\(name)/"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listAllPublicRepositories:
            return .get
        case .repository:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listAllPublicRepositories:
            return .requestPlain
        case .repository:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
