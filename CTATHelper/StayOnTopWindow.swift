//
//  StayOnTopWindow.swift
//  CTATHelper
//
//  Created by Paul on 9/27/19.
//  Copyright © 2019 Mathemusician.net. All rights reserved.
//

import Cocoa

class StayOnTopWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = .floating
    }
}
