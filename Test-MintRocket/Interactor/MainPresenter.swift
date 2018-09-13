//
//  MainPresentor.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import Foundation


class MainPresenter {
    
    private var repositories: [RepositoryModel] = []
    
    func getCountRepositories() -> Int {
        return repositories.count
    }
    
    func getListRepositroriesWithoutSines(completion: @escaping () -> ()){
        Api.shared.getRepositories(sines: nil) { (repositories) in
            self.repositories = repositories
            completion()
        }
    }
    
    func getListRepositories(completion: @escaping () -> ()){
        Api.shared.getRepositories(sines: repositories.last?.id) { (repositories) in
            self.repositories = self.repositories + repositories
            completion()
        }
    }
    
    func getRepository(_ numberOfArray: Int) -> RepositoryModel{
        return repositories[numberOfArray]
    }
    
    func getLastNumberRepositories() -> Int{
        return repositories.count - 1
    }
    
//    func getIdLastItemRepositories() -> Int{
//        return repositories.last?.id
//    }
    
    init() {
        
    }
}
