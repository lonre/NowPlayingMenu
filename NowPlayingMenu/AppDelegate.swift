//
//  AppDelegate.swift
//  NowPlayingMenu
//
//  Created by Lonre Wang on 2018/3/1.
//  Copyright © 2018 Lonre Wang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    @IBOutlet weak var statusMenuController: StatusMenuController!
    @IBOutlet weak var mainMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("statusIcon"))
            button.image?.isTemplate = true
            button.setButtonType(.multiLevelAccelerator)
            button.maxAcceleratorLevel = 2
            button.action = #selector(self.statusBarClicked(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    @objc func statusBarClicked(sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent else {
            return
        }
        
//        print("click event", event.description)
        
        switch event.type {
        case NSEvent.EventType.leftMouseUp:
            statusMenuController.doAction(key: StatusMenuController.O_NX_KEYTYPE_NEXT)
        case NSEvent.EventType.rightMouseUp:
            if(event.locationInWindow.x > 20 && event.locationInWindow.y > 15) {
                statusItem.popUpMenu(mainMenu)
            } else {
                statusMenuController.doAction(key: StatusMenuController.O_NX_KEYTYPE_PLAY)
            }
        default:
            break
        }
    }
}
