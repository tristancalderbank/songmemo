//
//  Audio.swift
//  songmemo
//
//  Created by testuser1 on 2018-12-12.
//  Copyright © 2018 songmemo. All rights reserved.
//

import Foundation
import AVFoundation

func getAudioFileDuration(url: URL) -> (Int, Int) {
    let asset = AVURLAsset(url: url)
    let seconds = Int(CMTimeGetSeconds(asset.duration)) % 60
    let minutes = Int(CMTimeGetSeconds(asset.duration)) / 60
    
    return (minutes, seconds)
}
