//
//  PlayerViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/27/25.
//

import UIKit
import AVFoundation

final class PlayerViewController: UIViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var songs: [Song] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicPlayerService.shared.onSongChanged = { [weak self] song in
            self?.updateUI(song: song)
        }
        
        MusicPlayerService.shared.onProgressUpdate = { [weak self] current, duration in
            self?.progressSlider.maximumValue = Float(duration)
            self?.progressSlider.value = Float(current)
            self?.currentTimeLabel.text = self?.formatTime(current)
            self?.durationTimeLabel.text = self?.formatTime(duration)
        }
        
        MusicPlayerService.shared.setPlaylist(songs, startAt: currentIndex)
    }
    
    private func updateUI(song: Song) {
        titleLabel.text = song.title
        artistLabel.text = song.artist
        coverImageView.image = UIImage(named: song.imageName)
        
        let isPlaying = MusicPlayerService.shared.isPlaying()
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
        
        let isSaved = SongRepository.shared.isSaved(song: song)
        favoriteButton.setImage(UIImage(systemName: isSaved ? "heart.fill" : "heart"), for: .normal)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        MusicPlayerService.shared.playPause()
        let isPlaying = MusicPlayerService.shared.isPlaying()
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        MusicPlayerService.shared.seek(to: sender.value)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        MusicPlayerService.shared.next()
    }
    
    @IBAction func prevTapped(_ sender: UIButton) {
        MusicPlayerService.shared.prev()
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let currentSong = MusicPlayerService.shared.getCurrentSong() else { return }
        
        SongRepository.shared.toggleSave(song: currentSong)
        
        updateUI(song: currentSong)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicPlayerService.shared.stop()
    }
}
