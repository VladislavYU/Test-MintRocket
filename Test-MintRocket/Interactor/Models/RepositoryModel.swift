//
//  RepositoryModel.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import Foundation


struct RepositoryModel: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let fullName: String
    let htmlUrl: String
    
    struct Owner: Decodable{
        let login: String
    }
}
