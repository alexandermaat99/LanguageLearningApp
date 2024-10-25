//
//  SoundPlayer.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/25/24.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    private var player: AVAudioPlayer?

    mutating func playSound(named soundName: String) async {
        guard let path = Bundle.main.path(forResource: soundName, ofType: nil) else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        } catch {
            // Ignore -- the sound just won’t play
        }
    }
}