//
//  AVPlayer.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/14.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import AVFoundation

public extension AVPlayer {
    /// 快进到指定时间进行播放
    @objc func seekToTime(_ time: Double, complete: ((Bool) ->Void)?) {
        var timeScale = CMTimeScale(1 * NSEC_PER_SEC)
        if let currentItem = self.currentItem {
            currentItem.cancelPendingSeeks()
            timeScale = currentItem.currentTime().timescale
        }
        let seekTime = CMTime(seconds: time, preferredTimescale: timeScale)
        self.seek(to: seekTime, toleranceBefore: CMTime(value: 0, timescale: timeScale), toleranceAfter: CMTime(value: 0, timescale: timeScale)) { (success) in
            DispatchQueue.main.async {
                complete?(success)
            }
        }
    }
}
