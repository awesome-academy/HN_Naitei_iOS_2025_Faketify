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

    private var player: AVAudioPlayer?
    private var timer: Timer?
        
        var songs: [Song] = []
        var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        prepareSong()
    }

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           timer?.invalidate()
           player?.stop()
       }

       private func setupUI() {
           let song = songs[currentIndex]
           titleLabel.text = song.title
           artistLabel.text = song.artist
           coverImageView.image = UIImage(named: song.imageName)
       }
    
    private func prepareSong() {
           let song = songs[currentIndex]
           
           guard let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") else {
               return
           }
           
           do {
               player = try AVAudioPlayer(contentsOf: url)
               player?.prepareToPlay()
               durationTimeLabel.text = formatTime(player?.duration ?? 0)
               progressSlider.maximumValue = Float(player?.duration ?? 0)
               progressSlider.value = 0
               startTimer()
           } catch {
           }
       }

       private func startTimer() {
           timer?.invalidate()
           timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
               guard let self = self, let player = self.player else { return }
               self.progressSlider.value = Float(player.currentTime)
               self.currentTimeLabel.text = self.formatTime(player.currentTime)
           }
       }

       private func formatTime(_ time: TimeInterval) -> String {
           let minutes = Int(time) / 60
           let seconds = Int(time) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }

       @IBAction func playPauseTapped(_ sender: UIButton) {
           guard let player = player else { return }
           
           if player.isPlaying {
               player.pause()
               playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
           } else {
               player.play()
               playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
           }
       }

       @IBAction func sliderChanged(_ sender: UISlider) {
           player?.currentTime = TimeInterval(sender.value)
           currentTimeLabel.text = formatTime(player?.currentTime ?? 0)
       }

       @IBAction func nextTapped(_ sender: UIButton) {
           currentIndex = (currentIndex + 1) % songs.count
           setupUI()
           prepareSong()
           player?.play()
           playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
       }

       @IBAction func prevTapped(_ sender: UIButton) {
           currentIndex = (currentIndex - 1 + songs.count) % songs.count
           setupUI()
           prepareSong()
           player?.play()
           playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
       }
   }
