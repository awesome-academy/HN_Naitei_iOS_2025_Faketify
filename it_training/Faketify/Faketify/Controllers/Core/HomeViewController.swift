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
        // Register the XIB file for the custom cell
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        // Set table view properties
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView() // Remove empty cells
        
        // Debug: Print registered cell identifiers
        print("Registered cell identifier: \(SongTableViewCell.identifier)")
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\n--- cellForRowAt: \(indexPath.row) ---")
        
        // 1. Debug: Print available reuse identifiers
        if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier) as? SongTableViewCell {
            print("Successfully dequeued cell with identifier: \(SongTableViewCell.identifier)")
            let song = mockSongs[indexPath.row]
            print("Configuring cell with song: \(song.title)")
            cell.configure(with: song)
            return cell
        } else {
            // 2. Debug: Print all registered cell classes and their identifiers
            print("Failed to dequeue cell with identifier: \(SongTableViewCell.identifier)")
            print("Registered cell classes: \(String(describing: tableView.value(forKey: "_cellClassDict")))")
            
            // 3. Try to force register the cell again as a fallback
            let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier) as? SongTableViewCell {
                print("Successfully dequeued after re-registering")
                let song = mockSongs[indexPath.row]
                cell.configure(with: song)
                return cell
            } else {
                // 4. Last resort: return a basic cell with error info
                print("Falling back to basic cell")
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
        print("Selected song: \(song.title)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
