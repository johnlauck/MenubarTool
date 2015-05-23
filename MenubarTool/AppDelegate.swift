//
//  AppDelegate.swift
//  MenubarTool
//
//  Created by John Lauck on 5/23/15.
//  Copyright (c) 2015 John Lauck. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        
        // Insert code here to initialize your application
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        
        statusBarItem.image = icon
        
        //Add menuItem to menu
        menuItem.title = "Show hidden files"
        menuItem.action = Selector("menuClicked:")
        menu.addItem(menuItem)
    }

    @IBAction func menuClicked(sender: NSMenuItem) {
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        
        if(sender.state == NSOnState) {
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "no"]
        }else{
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "yes"]
        }
        
        task.launch()
        task.waitUntilExit()
        
        let killtask = NSTask()
        killtask.launchPath = "/usr/bin/killall"
        
        killtask.arguments = ["Finder"]
        killtask.launch()
    }

}

