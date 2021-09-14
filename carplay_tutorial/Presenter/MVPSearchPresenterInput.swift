//
//  MVPSearchPresenterInput.swift
//  carplay_tutorial
//
//  Created by 小柳智之 on 2021/09/13.
//

import Foundation

protocol  MVPSearchPresenterInput {
    var numberOfItems: Int {get}
    func item(index: Int) -> GithubModel
    func search(param: String?)
    func didSelect(index: Int)
}

protocol MVPSearchPresenterOutput: AnyObject {
    func update(loading: Bool)
    func update(githubModels: [GithubModel])
    func validation(error: ParameterValidationError)
    func get(error: Error)
    func showWeb(url: URL)
}

//Modelをほじする
final class MVPSearchPresenter {
    private weak var output: MVPSearchPresenterOutput!
    private var api: GithubAPIProtocol!
    
    private var githubModels: [GithubModel]
    
    init(output:MVPSearchPresenterOutput, api: GithubAPIPrototcol = GithubAPI.shared){
        self.output = output
        self.api = api
        self.githubModels = []
    }
}

extension MVPSearchPresenter: MVPSearchPresenterInput {
    var numberOfItems: Int {
        githubModels.count
    }
    
    func item(index: Int) -> GithubModel {
        githubModels[index]
    }
    
    func search(param: String?) {
        if let validationError = ParametetValidationError(param: param){
            output.validation(error: validationError)
            return
        }
        guard let searchText = param else {return}
        output.update(loading: true)
        
        self.api.get(searchText:searchText){[weak self] (result)
            guard let self = self else{ return }
            switch result {
            case .success(let githubModels):
                self.output.update(loading: false)
                
                if githubModels.isEmpty {
                    self.output.get(error: AppError.emptyApiResponce.error)
                    return
                }
                self.githubModels = githubModels
                self.output.update(githubModels: githubModels)
                
            case .failure(let error):
                self.output.update(loading: false)
                self.output.get(error: error)
            }
        }
    }
    
    func didSelect(index: Int) {
        guard let githubUrl = URL(string: githubModles[index].urlStr) else {
            
            output.get(error: AppError.getApiData.error)
            return
        }
        output.showWeb(url: githubUrl)
    }
}
