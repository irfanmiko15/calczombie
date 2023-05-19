//
//  SoundControl.swift
//  Calculator vs Zombie
//
//  Created by Irfan Dary Sujatmiko on 17/04/23.
//

import Foundation
import AVFoundation
var backSongPlayer: AVAudioPlayer!
class Sounds {
    
  static var audioPlayer:AVAudioPlayer?

  static func playSounds(soundfile: String) {

      if let path = Bundle.main.path(forResource: soundfile, ofType: nil){

          do{

              audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
              audioPlayer?.prepareToPlay()
              audioPlayer?.play()

          }catch {
              print("Error")
          }
      }
   }
}
class SoundControl{
    func playHelp(){
        Sounds.playSounds(soundfile: "help.mp3")
    }
    func playWin(){
        Sounds.playSounds(soundfile: "win.wav")
    }
    func playLose(){
        Sounds.playSounds(soundfile: "lose.wav")
    }
    func playCorrect(){
        Sounds.playSounds(soundfile: "correctAnswer.mp3")
    }
    func playBacksong(){
        let url = Bundle.main.url(forResource: "backsong", withExtension: "mp3")
                
                guard url != nil else {
                    return
                }
                
                do {
                    backSongPlayer = try AVAudioPlayer(contentsOf: url!)
                    backSongPlayer?.play()
                    backSongPlayer?.numberOfLoops = -1
                    backSongPlayer.volume = 0.5
                } catch {
                    print("\(error)")
                }
    }
    func stopBacksong(){
        let url = Bundle.main.url(forResource: "backsong", withExtension: "mp3")
                
                guard url != nil else {
                    return
                }
                
                do {
                    backSongPlayer = try AVAudioPlayer(contentsOf: url!)
                    backSongPlayer?.stop()
                } catch {
                    print("\(error)")
                }
    }
}
