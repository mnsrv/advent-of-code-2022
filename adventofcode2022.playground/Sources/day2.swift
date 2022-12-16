import Foundation

enum Shape {
    case Rock
    case Paper
    case Scissors
}
enum Result {
    case Win
    case Draw
    case Lose
}
var myScore: [Shape: Int] = [
    .Rock: 1,
    .Paper: 2,
    .Scissors: 3
]
var scoreForResult: [Result: Int] = [
    .Win: 6,
    .Draw: 3,
    .Lose: 0,
]
func game(a: Shape, b: Shape) -> Int {
    if (a == b) {
        return scoreForResult[.Draw]!
    }
    if (a == .Rock && b == .Scissors) {
        return scoreForResult[.Win]!
    }
    if (a == .Rock && b == .Paper) {
        return scoreForResult[.Lose]!
    }
    if (a == .Scissors && b == .Rock) {
        return scoreForResult[.Lose]!
    }
    if (a == .Scissors && b == .Paper) {
        return scoreForResult[.Win]!
    }
    if (a == .Paper && b == .Rock) {
        return scoreForResult[.Win]!
    }
    if (a == .Paper && b == .Scissors) {
        return scoreForResult[.Lose]!
    }
    return 0
}
func getShape(a: Shape, result: Result) -> Shape {
    if (result == .Draw) {
        return a
    }
    if (a == .Rock) {
        if (result == .Win) {
            return .Paper
        } else {
            return .Scissors
        }
    }
    if (a == .Paper) {
        if (result == .Win) {
            return .Scissors
        } else {
            return .Rock
        }
    }
    if (a == .Scissors) {
        if (result == .Win) {
            return .Rock
        } else {
            return .Paper
        }
    }
    // should never go here
    return .Rock
}
var dict: [String: Shape] = [
    "A": .Rock,
    "B": .Paper,
    "C": .Scissors,
]
var dictSecond: [String: Result] = [
    "X": .Lose,
    "Y": .Draw,
    "Z": .Win,
]

public func day2() {
    let input = load(file:"day2/input")!
    var sum = 0
        
    // X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win.
    input.enumerateLines { (line, _) in
        let players = line.components(separatedBy: " ")
        let result = dictSecond[players[1]]!
        let opp = dict[players[0]]!
        let me = getShape(a: opp, result: result)
        let score = myScore[me]! + scoreForResult[result]!
        sum += score
    }
    
    print("sum:", sum)
}
