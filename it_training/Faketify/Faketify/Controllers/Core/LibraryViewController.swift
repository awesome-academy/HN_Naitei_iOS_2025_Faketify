//
//  LibraryViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

class LibraryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var savedSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedSongs = SongRepository.shared.savedSongs
        print("Library willAppear - savedSongs: \(savedSongs.count)")
        tableView.reloadData()
    }


}

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Library rows = \(savedSongs.count)")
        return savedSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SongTableViewCell.identifier,
            for: indexPath
        ) as? SongTableViewCell else {
            return UITableViewCell()
        }
        let song = savedSongs[indexPath.row]
        print("Config cell with song: \(song.title) - \(song.artist)")
        cell.configure(with: song)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController {
            playerVC.songs = savedSongs
            playerVC.currentIndex = indexPath.row
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}
