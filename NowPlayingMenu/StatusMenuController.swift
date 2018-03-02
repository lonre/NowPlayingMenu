//
//  StatusMenuController.swift
//  NowPlayingMenu
//
//  Created by Lonre Wang on 2018/3/1.
//  Copyright © 2018 Lonre Wang. All rights reserved.
//

import Cocoa
import MediaPlayer

class StatusMenuController: NSObject {
    static let O_NX_KEYTYPE_PLAY     = 16
    static let O_NX_KEYTYPE_NEXT     = 17
    static let O_NX_KEYTYPE_PREVIOUS = 18
    
    @IBOutlet weak var mainMenu: NSMenu!
    @IBOutlet weak var menuQuit: NSMenuItem!
    @IBOutlet weak var menuCurrentTrack: NSMenuItem!
    
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    @IBAction func prevClicked(_ sender: NSMenuItem) {
        doAction(key: StatusMenuController.O_NX_KEYTYPE_PREVIOUS)
    }
    
    @IBAction func playClicked(_ sender: NSMenuItem) {
        doAction(key: StatusMenuController.O_NX_KEYTYPE_PLAY)
    }
    
    @IBAction func nextClicked(_ sender: NSMenuItem) {
        doAction(key: StatusMenuController.O_NX_KEYTYPE_NEXT)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func doAction(key: Int) {
        fireKeyEvent(key: key, down: true)
        fireKeyEvent(key: key, down: false)
    }
    
    func fireKeyEvent(key: Int, down: Bool) {
        let e = NSEvent.otherEvent(
            with: NSEvent.EventType.systemDefined,
            location: NSPoint.zero,
            modifierFlags: NSEvent.ModifierFlags.init(rawValue: (down ? 0xa00 : 0xb00)),
            timestamp: 0 as TimeInterval,
            windowNumber: 0,
            context: nil,
            subtype: 8,
            data1: (key << 16 ) | ((down ? 0xa : 0xb) << 8),
            data2: -1
        )
        e?.cgEvent?.post(tap: CGEventTapLocation.cghidEventTap)
    }
}
