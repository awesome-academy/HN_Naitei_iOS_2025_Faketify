//
//  HomeViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let featuredSongs = Array(SongRepository.shared.allSongs.prefix(6))
    private let songs = Array(SongRepository.shared.allSongs.suffix(6))
  
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
    
    private func setupTableView() {
        let songNib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableView.register(songNib, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        let imageNib = UINib(nibName: "ImageTableViewCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: "ImageTableViewCell")
        
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
    }
}

// MARK: - DataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            let items = featuredSongs.map { CoverItem(imageName: $0.imageName, title: $0.title) }
            cell.configure(items: items)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as! SongTableViewCell
            let song = songs[indexPath.row]
            cell.configure(with: song)
            return cell
        }
    }
}

// MARK: - Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView else {
            return nil
        }
        header.configure(with: section == 0 ? "Featured Albums" : "Songs")
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController {
                playerVC.songs = songs
                playerVC.currentIndex = indexPath.row
                navigationController?.pushViewController(playerVC, animated: true)
            }
        }
    }
}

// MARK: - ImageTableViewCellDelegate
extension HomeViewController: ImageTableViewCellDelegate {
    func imageTableViewCell(_ cell: ImageTableViewCell, didSelectItemAt index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController {
            playerVC.songs = featuredSongs
            playerVC.currentIndex = index
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}
