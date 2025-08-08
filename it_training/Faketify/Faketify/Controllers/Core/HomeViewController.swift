//
//  ViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()

    private let songs: [Song] = [
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
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        tableView.rowHeight = 70
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: songs[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: Push to SongDetailViewController
    }
}
