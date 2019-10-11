//
//  ViewController.swift
//  CTATHelper
//
//  Created by Paul on 9/27/19.
//  Copyright © 2019 Mathemusician.net. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var ruleNameField: NSTextField!
    @IBOutlet var factNumberField: NSTextField!
    @IBOutlet var matchNumberField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func factNumberChanged(_ sender: NSTextField) {
//        print("Fact number: \(sender.stringValue)")
        // Maybe put it in user default...
    }

//    @IBAction func clearConsole(_ sender: NSButton) {
//        runCommand("clear()")
//    }

    @IBAction func printAgenda(_ sender: NSButton) {
        runCommand("printAgenda()", prompt: "Agenda:")
    }

    @IBAction func printWhyNot(_ sender: NSButton) {
        let ruleName = ruleNameField.stringValue
        runCommand("whyNot(\\\"\(ruleName)\\\")", prompt: "Why not \\\\\\\"\(ruleName)\\\\\\\":")
    }

    @IBAction func printRules(_ sender: NSButton) {
        runCommand("printRules()", prompt: "Rules:")
    }

    @IBAction func printAllFacts(_ sender: NSButton) {
        runCommand("printFacts()", prompt: "All Facts:")
    }

    @IBAction func printNumberedFact(_ sender: NSButton) {
        let numberString = factNumberField.stringValue
        runCommand("printFact(\(numberString))", prompt: "Fact \(numberString):")
    }

    @IBAction func getProblemFact(_ sender: NSButton) {
        runCommand("console.log(getFact(\\\"problem\\\"))", prompt: "Problem Fact:")
    }

    @IBAction func printConflictTree(_ sender: NSButton) {
        runCommand("printConflictTree()", prompt: "Conflict Tree:")
    }

    @IBAction func printNumberedMatch(_ sender: NSButton) {
        let numberString = matchNumberField.stringValue
        runCommand("printMatch(\(numberString))", prompt: "Match \(numberString):")
    }

    @IBAction func takeStep(_ sender: NSButton) {
        runCommand("takeSteps()", prompt: "Take a step:")
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

        print(rawScript)

        var error: NSDictionary? = nil
        NSAppleScript(source: rawScript)?.executeAndReturnError(&error)
        if let error = error {
            print(error)
        }
    }

}

