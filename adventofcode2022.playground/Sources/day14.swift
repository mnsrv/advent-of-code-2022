import Foundation

// 500,0

// # - rock
// . - air
// + - source

// down
// down and left
// down and right
// rest


public func day14() {
    let input = load(file:"day14/input")!
    
    let start = Point(x: 500, y: 0)
    var minX = 500
    var maxX = 0
    var minY = 0
    var maxY = 0
    var cave = [Point: String]()
    
//    cave[start] = "+"
    
    input.enumerateLines { (line, _) in
        let paths = line.components(separatedBy: " -> ")
        
        var previous: Point? = nil
        
        for path in paths {
            let dot = path.components(separatedBy: ",")
            let x = Int(dot[0])!
            let y = Int(dot[1])!
            
            if let prev = previous {
                if (prev.x == x) {
                    let minY = min(prev.y, y)
                    let maxY = max(prev.y, y)
                    for y in minY...maxY {
                        cave[Point(x: x, y: y)] = "#"
                    }
                } else if (prev.y == y) {
                    let minX = min(prev.x, x)
                    let maxX = max(prev.x, x)
                    for x in minX...maxX {
                        cave[Point(x: x, y: y)] = "#"
                    }
                }
            }
            
            previous = Point(x: x, y: y)
            
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
        }
    }
    
    // floor
    let floorY = maxY + 2
    
//    for y in (minY...floorY) {
//        var line = ""
//        for x in minX...maxX {
//            if (cave[Point(x: x,y: y)] != nil) {
//                line += cave[Point(x: x,y: y)]!
//            } else if y == floorY {
//                line += "#"
//            } else if x == start.x && y == start.y {
//                line += "+"
//            } else {
//                line += " "
//            }
//        }
//        print(line)
//    }
    
    var sand = start
    var sum = 0
    var restOnStart = false
    
//    print("")
    
    while restOnStart == false {
        sand = start

        for y in start.y...floorY {
            if (y == floorY) {
                // rest
                cave[sand] = "o"
                sum += 1
                break
            } else if (cave[Point(x: sand.x, y: y)] == nil) {
                // check down
                sand = Point(x: sand.x, y: y)
            } else if (cave[Point(x: sand.x - 1, y: y)] == nil) {
                // check left down
                sand = Point(x: sand.x - 1, y: y)
            } else if (cave[Point(x: sand.x + 1, y: y)] == nil) {
                // check right down
                sand = Point(x: sand.x + 1, y: y)
            } else {
                // rest
                cave[sand] = "o"
                sum += 1
                break
            }
            
//            for y in (minY...floorY) {
//                var line = ""
//                for x in (minX - 10)...(maxX + 10) {
//                    if (cave[Point(x: x,y: y)] != nil) {
//                        line += cave[Point(x: x,y: y)]!
//                    } else if y == floorY {
//                        line += "#"
//                    } else if x == sand.x && y == sand.y {
//                        line += "*"
//                    } else if x == start.x && y == start.y {
//                        line += "+"
//                    } else {
//                        line += " "
//                    }
//                }
//                print(line)
//            }
        }
        
        if sand == start {
            restOnStart = true
        }
    }

    minX = cave.reduce(into: maxX) { m, rock in
        m = min(m, rock.key.x)
    }
    maxX = cave.reduce(into: Int()) { m, rock in
        m = max(m, rock.key.x)
    }
        
    
    for y in (minY...floorY) {
        var line = ""
        for x in minX...maxX {
            if (cave[Point(x: x,y: y)] != nil) {
                line += cave[Point(x: x,y: y)]!
            } else if y == floorY {
                line += "#"
            } else if x == start.x && y == start.y {
                line += "+"
            } else {
                line += " "
            }
        }
        print(line)
    }
    
    print("")
    print("day 14:", sum)
}
