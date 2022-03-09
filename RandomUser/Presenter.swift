//
//  Presenter.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 08.03.2022.
//

import Foundation
import UIKit

protocol ProfileViewProtocol {
    func success()
    func failure(error: Error)
}

protocol PresenterProtocol {
    init(view: ProfileView?, networkService: NetworkServiceProtocol?)
    func getUser()
    var response: Response? { get set }
}

final class Presenter: PresenterProtocol {
    weak var view: ProfileView?
    var networkService: NetworkServiceProtocol?
    var response: Response?
    
    init(view: ProfileView?, networkService: NetworkServiceProtocol?) {
        self.view = view
        self.networkService = networkService
        getUser()
    }
    
    func getUser() {
        networkService?.getData { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.response = response
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
