import Foundation

func canAppend(grid: [[Int]], p: Point, from: Point) -> Bool {
    if (grid.indices.contains(p.y) && grid[p.y].indices.contains(p.x)) {
        let f = grid[from.y][from.x]
        let to = grid[p.y][p.x]

        if (to - f >= -1) {
            return true
        }
    }
    return false
}
func getNeighbours(grid: [[Int]], from: Point) -> [Point] {
    var neighbours = [Point]()
    
    let top = Point(x: from.x, y: from.y - 1)
    if (canAppend(grid: grid, p: top, from: from)) {
        neighbours.append(top)
    }
    let right = Point(x: from.x + 1, y: from.y)
    if (canAppend(grid: grid, p: right, from: from)) {
        neighbours.append(right)
    }
    let bottom = Point(x: from.x, y: from.y + 1)
    if (canAppend(grid: grid, p: bottom, from: from)) {
        neighbours.append(bottom)
    }
    let left = Point(x: from.x - 1, y: from.y)
    if (canAppend(grid: grid, p: left, from: from)) {
        neighbours.append(left)
    }

    return neighbours
}

public func day12() {
    let input = load(file:"day12/input")!
    
    var grid = [[Int]]()
    var S = Point()
    var E = Point()
    var y = 0
    
    input.enumerateLines { (line, _) in
        var row = [Int]()
        Array(line).enumerated().forEach { (index, char) in
            if (char == "S") {
                S = Point(x: index, y: y)
                row.append(Int("a".unicodeScalars.first!.value) - 97 + 1)
            } else if (char == "E") {
                E = Point(x: index, y: y)
                row.append(Int("z".unicodeScalars.first!.value) - 97 + 1)
            } else {
                row.append(Int(char.unicodeScalars.first!.value) - 97 + 1)
            }
        }
        grid.append(row)
        y += 1
    }
    print("S", S)
    print("E", E)
    
    
    var queue = [Point]()
    queue.append(E)
    var visited: Set<Point> = Set()
    var parents = [Point: Point]()
    var count = 0

    while queue.count > 0 {
        let current = queue.removeFirst()

        if (grid[current.y][current.x] == 1) {
            print("Hooray")
            var check = current

            while check != E {
                if (parents[check] == nil) {
                    break
                }
                check = parents[check]!
                count += 1
            }
            break
        }

        let neighbourEdges = getNeighbours(grid: grid, from: current)

        for edge in neighbourEdges {
            if (!visited.contains(edge)) {
                parents[edge] = current
                visited.insert(edge)
                queue.append(edge)
            }
        }
    }
    
    print("day 12", count)
}
