//
//  SearchViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var allSongs: [Song] = []
    private var filteredSongs: [Song] = []
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        let songNib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableView.register(songNib, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        allSongs = SongRepository.shared.allSongs
        filteredSongs = allSongs
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        let searchTextField = searchController.searchBar.searchTextField
        searchTextField.autocorrectionType = .default      // để iOS tự xử lý VN/EN
        searchTextField.spellCheckingType = .no
        searchTextField.autocapitalizationType = .sentences // Viết hoa đầu câu
        searchTextField.keyboardType = .default
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredSongs = allSongs
            tableView.reloadData()
            return
        }
        filteredSongs = allSongs.filter {
            $0.title.localizedCaseInsensitiveContains(text) ||
            $0.artist.localizedCaseInsensitiveContains(text)
        }
        tableView.reloadData()
    }
}

// MARK: - TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SongTableViewCell.identifier,
            for: indexPath
        ) as! SongTableViewCell
        cell.configure(with: filteredSongs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let song = filteredSongs[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerVC = storyboard.instantiateViewController(
            withIdentifier: "PlayerViewController"
        ) as? PlayerViewController {
            playerVC.songs = filteredSongs
            playerVC.currentIndex = indexPath.row
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}
