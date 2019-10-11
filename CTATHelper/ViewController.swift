//
//  ViewController.swift
//  CTATHelper
//
//  Created by Paul on 9/27/19.
//  Copyright © 2019 Mathemusician.net. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var stackView: NSStackView!

    var allControls: [NSButton : (CommandType, NSTextField?)] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        populateControls(commands: allCommands)
    }

    @IBAction func toggleDisplay(_ sender: NSButton) {
        if sender.state == .on {
            self.view.window?.level = .floating
        } else {
            self.view.window?.level = .normal
        }
    }

    func populateControls(commands: [CommandType]) {
        assert(allControls.isEmpty)

        for command in commands {
            if let command = command as? OneParameterCommand {
                // Initiate button and text field
                let button = NSButton(title: command.name, target: nil, action: #selector(commandButtonClicked(sender:)))
                let textField = NSTextField(string: command.parameter)

                // Layout
                let width: CGFloat = command.parameter.count > 2 ? 80 : 40
                textField.addConstraint(textField.widthAnchor.constraint(equalToConstant: width))
                let rowStackView = NSStackView(views: [button, textField])
                rowStackView.setHuggingPriority(.init(rawValue: 749), for: .vertical)

                // Add
                stackView.addArrangedSubview(rowStackView)
                allControls[button] = (command, textField)
            } else {
                // Initiate button
                let button = NSButton(title: command.name, target: nil, action: #selector(commandButtonClicked(sender:)))

                // Add
                stackView.addArrangedSubview(button)
                allControls[button] = (command, nil)
            }
        }
    }

    @objc func commandButtonClicked(sender: NSButton) {
        let controls = allControls[sender]!
        let command: String
        let prompt: String

        if var control = controls.0 as? OneParameterCommand {
            control.parameter = controls.1!.stringValue
            command = control.command
            prompt = "\(control.name) \(control.parameter):"
        } else {
            command = controls.0.command
            prompt = "\(controls.0.name):"
        }
        runCommand(command, prompt: prompt)
    }

    func runCommand(_ command: String, prompt: String? = nil) {
        let jsScript = (prompt.map({"console.log(\\\"\($0)\\\");"}) ?? "") + command
        let rawScript = """
        tell application "Safari"
            tell current tab of window 1
                do JavaScript "\(jsScript)"
            end tell
        end tell
        """

//        print(rawScript)

        var error: NSDictionary? = nil
        NSAppleScript(source: rawScript)?.executeAndReturnError(&error)
        if let error = error {
            print(error)
        }
    }

}

