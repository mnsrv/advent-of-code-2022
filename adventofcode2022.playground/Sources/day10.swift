import Foundation

func isInterestingCycle(_ cycle: Int) -> Bool {
    //  For now, consider the signal strength (the cycle number multiplied by the value of the X register) during the 20th cycle and every 40 cycles after that (that is, during the 20th, 60th, 100th, 140th, 180th, and 220th cycles).
    if ((cycle - 20) % 40 == 0) {
        return true
    }
    return false
}

func draw(_ cycle: Int, X: Int) -> String {
    let c = (cycle - 1) % 40
    if (c == (X - 1)
        || c == X
        || c == (X + 1)) {
        return "#"
    }
    return " "
}

public func day10() {
    let input = load(file:"day10/input")!
    
    var X = 1
    var cycles = 0
    var signalStrengths = [Int]()

    input.enumerateLines { (line, _) in
        cycles += 1
        
        if (isInterestingCycle(cycles)) {
            signalStrengths.append(cycles * X)
        }
        
        let commands = line.components(separatedBy: " ")
        print("begin", "cycle", cycles, "X", X, "command", commands)

        if (commands[0] == "noop") {
            // do nothing
        } else if (commands[0] == "addx") {
            cycles += 1
            if (isInterestingCycle(cycles)) {
                signalStrengths.append(cycles * X)
            }
            X += Int(commands[1])!
        }
        print("end", "cycle", cycles, "X", X)
    }
    
    print(signalStrengths)
    print("day 10:", signalStrengths.reduce(0, +))
}

public func day10part2() {
    let input = load(file:"day10/input")!
    
    var X = 1
    var cycles = 0
    var row = ""

    input.enumerateLines { (line, _) in
        cycles += 1
        
        row.append(draw(cycles, X: X))
        if (cycles % 40 == 0) {
            print(row)
            row = ""
        }
        
        let commands = line.components(separatedBy: " ")
//        print("begin", "cycle", cycles, "X", X, "command", commands)

        if (commands[0] == "noop") {
            // do nothing
        } else if (commands[0] == "addx") {
            cycles += 1
            row.append(draw(cycles, X: X))
            if (cycles % 40 == 0) {
                print(row)
                row = ""
            }
            X += Int(commands[1])!
        }
//        print("end", "cycle", cycles, "X", X)
    }
    
//    print(signalStrengths)
//    print("day 10 part 2:", signalStrengths.reduce(0, +))
}
