//
//  ViewController.swift
//  Pretty Audio Player
//
//  Created by admin on 11/02/2020.
//  Copyright © 2020 AM Kirsch. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player = AVAudioPlayer()
    var timer =  Timer()
    
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBAction func progressSliderMoved(_ sender: Any) {
            player.currentTime = TimeInterval(progressSlider.value)
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil ,repeats: true)

        
    }
    
    @IBAction func volumeSliderChanged(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @objc func updateProgress() {
        progressSlider.value = Float(player.currentTime)
    }
    
    @IBAction func play(_ sender: Any) {
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil ,repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: Any) {
        player.stop()
        timer.invalidate()
        player.currentTime = 0.00
        progressSlider.value = 0.00
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let audioPath = Bundle.main.path(forResource: "fur-elise", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            progressSlider.maximumValue = Float(player.duration)
            
            
        } catch  {
            print("AVPlayer Error")
        }
    }


}

