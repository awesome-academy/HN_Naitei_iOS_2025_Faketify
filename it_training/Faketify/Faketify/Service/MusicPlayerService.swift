//
//  MusicPlayerService.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/27/25.
//

import AVFoundation

final class MusicPlayerService {
    static let shared = MusicPlayerService()
    
    private var player: AVAudioPlayer?
    private var songs: [Song] = []
    private var currentIndex = 0
    private var timer: Timer?
    
    var onProgressUpdate: ((_ currentTime: TimeInterval, _ duration: TimeInterval) -> Void)?
    var onSongChanged: ((_ song: Song) -> Void)?
    
    private init() {}
    
    func setPlaylist(_ songs: [Song], startAt index: Int) {
        self.songs = songs
        self.currentIndex = index
        playCurrentSong()
    }
    
    func playCurrentSong() {
        guard !songs.isEmpty else { return }
        let song = songs[currentIndex]
        
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            
            onSongChanged?(song)
            startTimer()
        } catch {

        }
    }
    
    func playPause() {
        guard let player = player else { return }
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func next() {
        guard !songs.isEmpty else { return }
        currentIndex = (currentIndex + 1) % songs.count
        playCurrentSong()
    }
    
    func prev() {
        guard !songs.isEmpty else { return }
        currentIndex = (currentIndex - 1 + songs.count) % songs.count
        playCurrentSong()
    }
    
    func seek(to value: Float) {
        player?.currentTime = TimeInterval(value)
    }
    
    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
    
    func getCurrentSong() -> Song? {
        return songs.isEmpty ? nil : songs[currentIndex]
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            self.onProgressUpdate?(player.currentTime, player.duration)
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    
    func stop() {
        player?.stop()
        timer?.invalidate()
    }
}
