//
//  ViewController.swift
//  carplay_tutorial
//
//  Created by 小柳智之 on 2021/09/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: TableViewCell.className, bundle: nil), forCellReuseIdentifier: TableViewCell.className)
        }
    }
    
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    private var searchBar = UISearchBar()
    
    //presenter
    private var input: MVPSearchPresenterInput!
    func inject(input: MVPSearchPresenterInput) {
        self.input = input
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
}
    
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //send presenter
        input.search(param: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        input.numberOfItems
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.className, for: indexPath) as! TableViewCell
        let githubModel = input.item(index: indexPath.item)
        cell.configure(githubModel: githubModel)
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        input.didSelect(index: indexPath.row)
    }
}

extension ViewController: MVPSearchPresenterOutput {
    func update(loading: Bool) {
        //show loading indicator
        //koko presenterで作ってみよう
        indicator.animation(isStart: loading)
    }
    
    func update(githubModels: [GithubModel]) {
        DispatchQueue.main.async {
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
            self.tableView.reloadData()
        }
    }
    
    func validation(error: ParameterValidationError) {
        Alert.okAlert(vc: self, title: error.message, message:"")
    }
    
    func get(error: Error){
        Alert.okAlert(vc:self, title:error.localizedDescription, message:"")
    }
    
    func showWeb(url: URL) {
        Router.showWeb(url: url, from:self)
    }
    
}
