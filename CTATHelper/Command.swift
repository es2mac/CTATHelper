//
//  Command.swift
//  CTATHelper
//
//  Created by Paul on 10/10/19.
//  Copyright © 2019 Mathemusician.net. All rights reserved.
//

import Foundation

protocol CommandType {
    var name: String { get }
    var command: String { get }
}

struct SimpleCommand: CommandType {
    let name: String
    let command: String
}

struct OneParameterCommand: CommandType {
    let name: String
    var parameter: String
    let composeCommand: (String) -> String
    var command: String {
        return composeCommand(parameter)
    }
}

let allCommands: [CommandType] = [
    SimpleCommand(name: "Agenda", command: "printAgenda()"),
    SimpleCommand(name: "Rules", command: "printRules()"),
    OneParameterCommand(name: "Why not",
                        parameter: "ruleName",
                        composeCommand: { "whyNot(\\\"\($0)\\\")" }),
    OneParameterCommand(name: "Fact",
                        parameter: "7",
                        composeCommand: { "printFact(\($0))" }),
    SimpleCommand(name: "All Facts", command: "printFacts()"),
    SimpleCommand(name: "Conflict Tree", command: "printConflictTree()"),
    OneParameterCommand(name: "Match",
                        parameter: "1",
                        composeCommand: { "printMatch(\($0))" }),
    SimpleCommand(name: "Take a step", command: "takeSteps()")
]
