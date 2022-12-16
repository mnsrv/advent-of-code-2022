import Foundation

func getWorryLevel(operation: String, worry: Int) -> Int {
    if (operation == "new = old * old") {
        // Operation: new = old + old
        return worry * worry
    } else if (operation.hasPrefix("new = old *")) {
        // Operation: new = old * 11
        let op = operation.components(separatedBy: "* ")
        return worry * Int(op[1])!
    } else if (operation.hasPrefix("new = old +")) {
        let op = operation.components(separatedBy: "+ ")
        // Operation: new = old + 1
        return worry + Int(op[1])!
    }
    return worry
}

public func day11() {
    let input = load(file:"day11/input")!
    
    var monkeys: [String] = []
    var monkeysItems: [String: [Int]] = [:]
    var monkeysOperations: [String: String] = [:]
    var monkeysTests: [String: Int] = [:]
    var monkeysTrue: [String: Int] = [:]
    var monkeysFalse: [String: Int] = [:]
    var monkeysInspects: [String: Int] = [:]
    var curr = ""
    var cycleLength = 1
    
    input.enumerateLines { (line, _) in
        let commands = line.components(separatedBy: ": ")
        
        if (commands[0].hasPrefix("Monkey")) {
            curr = commands[0]
            monkeys.append(curr)
            monkeysInspects[curr] = 0
        } else if (commands[0].hasSuffix("Starting items")) {
            let sep = commands[1].components(separatedBy: ", ")
            let items = sep.map { Int($0)! }
            monkeysItems[curr] = items
        } else if (commands[0].hasSuffix("Operation")) {
            monkeysOperations[curr] = commands[1]
        } else if (commands[0].hasSuffix("Test")) {
            // "divisible by 23"
            let op = commands[1].components(separatedBy: " by ")
            monkeysTests[curr] = Int(op[1])!
            cycleLength *= Int(op[1])!
        } else if (commands[0].hasSuffix("true")) {
            // "throw to monkey 2"
            let op = commands[1].components(separatedBy: " monkey ")
            monkeysTrue[curr] = Int(op[1])!
        } else if (commands[0].hasSuffix("false")) {
            // "throw to monkey 3"
            let op = commands[1].components(separatedBy: " monkey ")
            monkeysFalse[curr] = Int(op[1])!
        } else if (commands[0] == "") {
            curr = ""
        }
//        print("commands", commands)
    }
    
//    print("monkeys", monkeys)
//    print("monkeysItems", monkeysItems)
//    print("monkeysOperations", monkeysOperations)
//    print("monkeysTests", monkeysTests)
//    print("monkeysTrue", monkeysTrue)
//    print("monkeysFalse", monkeysFalse)
    
    for _ in 1...10000 {
        for monkey in monkeys {
            for item in monkeysItems[monkey]! {
                monkeysInspects[monkey]! += 1
                var worry = getWorryLevel(operation: monkeysOperations[monkey]!, worry: item)
//                worry = Int(worry / 3)
                worry = worry % cycleLength
                if (worry % monkeysTests[monkey]! == 0) {
                    monkeysItems["Monkey \(monkeysTrue[monkey]!):"]?.append(worry)
                } else {
                    monkeysItems["Monkey \(monkeysFalse[monkey]!):"]?.append(worry)
                }
            }
            monkeysItems[monkey] = []
        }
        
//        print("Round", i, monkeysItems)
    }
    
    let inspects = monkeysInspects.values.sorted { $0 > $1 }
    
    print("day 11:", inspects[0] * inspects[1])
}
