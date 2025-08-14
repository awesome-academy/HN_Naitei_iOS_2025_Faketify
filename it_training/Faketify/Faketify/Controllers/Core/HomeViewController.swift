//
//  HomeViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

final class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private let mockSongs: [Song] = [
        Song(title: "Síguelo", artist: "Wisin & Yandel", imageName: "siguelocover"),
        Song(title: "Hold Me Close", artist: "Flux Pavilion", imageName: "holdmeclose"),
        Song(title: "Good Looking", artist: "Don Omar", imageName: "goodlooking"),
        Song(title: "Start Me Up - Remastered", artist: "The Rolling Stones", imageName: "startmeup"),
        Song(title: "Oh, Pretty Woman", artist: "Roy Orbison", imageName: "prettwoman"),
        Song(title: "Mother Knows Best", artist: "Donna Murphy", imageName: "motherknowsbest"),
        Song(title: "Just Around the Riverbend", artist: "Judy Kuhn", imageName: "riverbend"),
        Song(title: "Right In", artist: "Skrillex", imageName: "rightin"),
        Song(title: "This Land", artist: "Hans Zimmer", imageName: "thisland")
    ]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func setupTableView() {
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView() // Remove empty cells
    
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier) as? SongTableViewCell {
            let song = mockSongs[indexPath.row]
            cell.configure(with: song)
            return cell
        } else {
            let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier) as? SongTableViewCell {
                let song = mockSongs[indexPath.row]
                cell.configure(with: song)
                return cell
            } else {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "fallback")
                cell.textLabel?.text = "Failed to load cell"
                cell.detailTextLabel?.text = "Check console for errors"
                return cell
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = mockSongs[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
