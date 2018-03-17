//
//  CPSearchController.swift
//  CPM
//
//  Created by CJ Gehin-Scott on 3/10/18.
//  Copyright © 2018 CJGehinScott. All rights reserved.
//

import UIKit

class CPSearchController: NSObject {
    
    private var repositories: [CPRepository]?
    private var languages: [(String,Int)]?{
        guard let repos = repositories else { return nil }
        var languages = [(String,Int)]()
        for repo in repos{
            if let language = repo.language{
                if languages.filter({$0.0 == language}).count == 0{
                    languages.append((language,repos.filter({ $0.language == language }).count))
                }
            }
        }
        return languages.sorted(by: {$0.1 > $1.1})
    }
    private var view: CPSearchVC?
    
    convenience init?(view: CPSearchVC?) {
        self.init()
        self.view = view
    }
    
    func fetchRepositoriesFor(_ searchTerm: String?){
        view?.setNetworkActivityIndicator(true)
        APIManager.shared.searchForReposWith(username: searchTerm) { [weak self] (repos, error) in
            self?.view?.setNetworkActivityIndicator(false)
            if error != nil{
                /* We ignore 422 erorrs because the gitHub API returns this when, either the repos returned we do not have access to or they do not exist
                 * We also ignore cancelled data task responses because that is the response from the Data Task when we cancel an inflight request to start a new one and we don't need to tell the user about it
                 */
                if error?.code != 422 && error?.message != "cancelled"{
                    self?.view?.showAlert(title: "\(error?.title ?? "") \(error?.code ?? 0)", message: error?.message)
                }
                
            }
            self?.repositories = repos
            self?.view?.reloadTableView()
        }
    }
    
    func repositoriesByLanguageSortedByStars(language:String)->[CPRepository]?{
        return repositories?.filter({ $0.language ?? "" == language}).sorted(by: { $0.stars ?? 0 > $1.stars ?? 0})
    }
}

extension CPSearchController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return languages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages?[section].1 ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRepositoryCellReuseId) as? CPRepositoryCell
        let sortedRepos = repositoriesByLanguageSortedByStars(language: languages?[indexPath.section].0 ?? "")
        cell?.setupWith(name: sortedRepos?[indexPath.row].name, description: sortedRepos?[indexPath.row].mDescription, stars: sortedRepos?[indexPath.row].stars, updatedDate: CPDateHelper.tableViewCellStringForDate(date: sortedRepos?[indexPath.row].updatedAt))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kSearchHeaderViewReuseId) as? CPSearchHeaderView{
            headerView.setupWith(title: languages?[section].0, count:languages?[section].1)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cell.contentView.layer.shadowOpacity = 0.1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view?.searchBar?.resignFirstResponder()
    }
}

extension CPSearchController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchRepositoriesFor(searchBar.text)
        searchBar.resignFirstResponder()
    }
}
