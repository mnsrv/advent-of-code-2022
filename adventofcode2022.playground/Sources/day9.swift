import Foundation

struct Point: Hashable {
    var x = 0
    var y = 0
}
extension Point: CustomStringConvertible {
    var description: String {
        return "(x: \(x), y: \(y))"
    }
}
enum Dir: String {
    case U
    case R
    case D
    case L
}

func getTailPosition(head: Point, tail: Point) -> Point {
    // ...
    // .H. (H covers T)
    // ...
    if (head.x == tail.x && head.y == tail.y) {
        return tail
    }
    // .....    .....    .....
    // .TH.. -> .T.H. -> ..TH.
    // .....    .....    .....
    if (head.y == tail.y) {
        if (abs(head.x - tail.x) > 1) {
            if (head.x > tail.x) {
                // .T.H. -> ..TH.
                return Point(x: head.x - 1, y: head.y)
            } else {
                // .H.T. -> .HT..
                return Point(x: head.x + 1, y: head.y)
            }
        } else {
            // ..TH. -> ..TH.
            // .HT.. -> .HT..
            return tail
        }
    }


    
    // ...    ...
    // .T.    .T.    ...
    // .H. -> ... -> .T.
    // ...    .H.    .H.
    // ...    ...    ...
    if (head.x == tail.x) {
        if (abs(head.y - tail.y) > 1) {
            if (head.y > tail.y) {
                return Point(x: head.x, y: head.y - 1)
            } else {
                return Point(x: head.x, y: head.y + 1)
            }
        } else {
            return tail
        }
    }
    
    // ..4..   ..4..
    // ...3.   .....
    // .....   ....3
    if (abs(head.x - tail.x) > 1 && abs(head.y - tail.y) > 1) {
        if (head.x > tail.x) {
            if (head.y > tail.y) {
                return Point(x: head.x - 1, y: head.y - 1)
            } else {
                return Point(x: head.x - 1, y: head.y + 1)
            }
        } else {
            if (head.y > tail.y) {
                return Point(x: head.x + 1, y: head.y - 1)
            } else {
                return Point(x: head.x + 1, y: head.y + 1)
            }
        }
    }
    
    // .....    .....    .....
    // .....    ..H..    ..H..
    // ..H.. -> ..... -> ..T..
    // .T...    .T...    .....
    // .....    .....    .....
    if (abs(head.y - tail.y) > 1) {
        if (head.y > tail.y) {
            return Point(x: head.x, y: head.y - 1)
        } else {
            return Point(x: head.x, y: head.y + 1)
        }
    }
    // .....    .....    .....
    // .....    .....    .....
    // ..H.. -> ...H. -> ..TH.
    // .T...    .T...    .....
    // .....    .....    .....
    
    // ......    ......    ......
    // ......    ...21.    ....1.
    // ..21.. -> ...... ?? ..2...
    if (abs(head.x - tail.x) > 1) {
        if (head.x > tail.x) {
            // .T.H. -> ..TH.
            return Point(x: head.x - 1, y: head.y)
        } else {
            // .H.T. -> .HT..
            return Point(x: head.x + 1, y: head.y)
        }
    }
    return tail
}

public func day9() {
    let input = load(file:"day9/input")!
    
    var x = 0
    var y = 0
    var tail = Point(x: x, y: y)
    var tailPositions = Set<Point>()
    
    input.enumerateLines { (line, _) in
        let command = line.components(separatedBy: " ")
        
        for _ in 1...Int(command[1])! {
            switch Dir(rawValue: command[0])! {
                case .U:
                    y += 1
                case .D:
                    y -= 1
                case .L:
                    x -= 1
                case .R:
                    x += 1
            }
            tail = getTailPosition(head: Point(x: x, y: y), tail: tail)
            tailPositions.insert(tail)
        }
    }
    
    print("day 9 part 1:", tailPositions.count)
}

public func day9part2() {
    let input = load(file:"day9/input")!
    
    var x = 0
    var y = 0
    var minX = 100
    var maxX = 0
    var minY = 100
    var maxY = 0
    var t1 = Point(x: x, y: y)
    var t2 = Point(x: x, y: y)
    var t3 = Point(x: x, y: y)
    var t4 = Point(x: x, y: y)
    var t5 = Point(x: x, y: y)
    var t6 = Point(x: x, y: y)
    var t7 = Point(x: x, y: y)
    var t8 = Point(x: x, y: y)
    var t9 = Point(x: x, y: y)
    var tailPositions = Set<Point>()
    
    input.enumerateLines { (line, stop) in
        let command = line.components(separatedBy: " ")
        
        for _ in 1...Int(command[1])! {
            switch Dir(rawValue: command[0])! {
                case .U:
                    y += 1
                case .D:
                    y -= 1
                case .L:
                    x -= 1
                case .R:
                    x += 1
            }
            if (x < minX) {
                minX = x
            }
            if (y < minY) {
                minY = y
            }
            if (x > maxX) {
                maxX = x
            }
            if (y > maxY) {
                maxY = y
            }

            t1 = getTailPosition(head: Point(x: x, y: y), tail: t1)
            t2 = getTailPosition(head: t1, tail: t2)
            t3 = getTailPosition(head: t2, tail: t3)
            t4 = getTailPosition(head: t3, tail: t4)
            t5 = getTailPosition(head: t4, tail: t5)
            t6 = getTailPosition(head: t5, tail: t6)
            t7 = getTailPosition(head: t6, tail: t7)
            t8 = getTailPosition(head: t7, tail: t8)
            t9 = getTailPosition(head: t8, tail: t9)
            tailPositions.insert(t9)
        }
    }
    
    for y in (minY...maxY).reversed() {
        var line = ""
        for x in minX...maxX {
            if (x == 0 && y == 0) {
                line += "s"
            } else {
                line += tailPositions.contains(Point(x: x, y: y)) ? "#" : "."
            }
        }
        print(line)
    }

    print("day 9 part 2:", tailPositions.count)
}
