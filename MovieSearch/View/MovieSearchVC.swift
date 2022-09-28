//
//  MovieSearchVC.swift
//  MovieSearch
//
//  Created by Eray on 25.09.2022.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    var films: [Film] = []
    var items: [Displayable] = []
    var selectedItem: Displayable?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView! {
      didSet {
        loadingView.layer.cornerRadius = 6
      }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
       
    }
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false

    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true

    }
}

extension MovieSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item.titleLabelText
        cell.detailTextLabel!.text = item.yearLabelText
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailsVC") as! DetailsVC
        vc.data = selectedItem
        vc.listData = items
        navigationController?.present(vc, animated: true)

    }
        
}
extension MovieSearchVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        items = films
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieTitle = searchBar.text else { return }
        searchBar.resignFirstResponder()
        searchBar.text = nil
        
        fetchFilm(title: movieTitle)
       

    }
    
}
    
extension MovieSearchVC {
        func fetchFilm(title: String) {
            showSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hideSpinner()

            }
            let vm = ViewModel()
            vm.getMovie(title) { (d, fetched) in
                if (fetched) {
                    self.films = d!.all
                    self.items = d!.all
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "An error occured. Please check your spelling or provide more information.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        
}
