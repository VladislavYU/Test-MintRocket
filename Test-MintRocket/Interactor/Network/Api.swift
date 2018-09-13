//
//  Api.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import Foundation
import Moya

class Api {
    
    let provider = MoyaProvider<MoyaService>()//(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static var shared = Api()
    
    private init (){}
    
    private func parseJSON<T: Decodable>(response: Data) -> T?{
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(T.self, from: response)
            return data
        }catch {
            print(error)
            return nil
        }
    }
    
    func getRepositories(sines: Int?, completion: @escaping ([RepositoryModel]) -> ()) {
        provider.request(.listAllPublicRepositories(since: sines?.description)) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let response):
                guard let json: [RepositoryModel]  = self.parseJSON(response: response.data) else { return }
                completion(json)
            }
        }
    }
    
    func getRepository(name: String, completion: @escaping (Data) -> ()){
        provider.request(.repository(name: name)) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let response):
                completion(response.data)
            }
        }
    }
}
