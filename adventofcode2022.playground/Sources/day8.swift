import Foundation

enum Direction {
    case Top
    case Right
    case Bottom
    case Left
}

func isVisible(_ tree: Int, trees: [Int]) -> Bool {
    return trees.reduce(true) { $0 && $1 < tree }
}

func getTrees(grid: [[Int]], direction: Direction, x: Int, y: Int) -> [Int] {
    var trees = [Int]()
    
    switch direction {
    case .Top:
        for j in 0...y-1 {
            trees.insert(grid[j][x], at: 0)
        }
    case .Right:
        for i in x+1...grid[0].count-1 {
            trees.append(grid[y][i])
        }
    case .Bottom:
        for j in y+1...grid.count-1 {
            trees.append(grid[j][x])
        }
    case .Left:
        for i in 0...x-1 {
            trees.insert(grid[y][i], at: 0)
        }
    }
    
    return trees
}

func getViewingDistance(height: Int, trees: [Int]) -> Int {
    var count = 0
    for tree in trees {
        count += 1
        if (tree >= height) {
            break
        }
    }
    return count
}

public func day8() {
    let input = load(file:"day8/input")!
    
    var grid = [[Int]]()
    
    input.enumerateLines { (line, _) in
        grid.append(line.compactMap { Int(String($0)) })
    }
    
    var answer = 0
    
    for (x, row) in grid.enumerated() {
        for (y, tree) in row.enumerated() {
            if (x == 0 || y == 0 || x == row.count - 1 || y == grid.count - 1) {
                answer += 1
            } else if (
                isVisible(tree, trees: getTrees(grid: grid, direction: .Top, x: x, y: y))
                || isVisible(tree, trees: getTrees(grid: grid, direction: .Right, x: x, y: y))
                || isVisible(tree, trees: getTrees(grid: grid, direction: .Bottom, x: x, y: y))
                || isVisible(tree, trees: getTrees(grid: grid, direction: .Left, x: x, y: y))) {
                answer += 1
            }
        }
    }
    
    print("part1:", answer)
}

public func day8part2() {
    let input = load(file:"day8/input")!
    
    var grid = [[Int]]()
    
    input.enumerateLines { (line, _) in
        grid.append(line.compactMap { Int(String($0)) })
    }
    
    var answer = 0
    
    for (y, row) in grid.enumerated() {
        for (x, tree) in row.enumerated() {
            if (x == 0 || y == 0 || x == row.count - 1 || y == grid.count - 1) {
                // 0
            } else {
                let top = getViewingDistance(height: tree, trees: getTrees(grid: grid, direction: .Top, x: x, y: y))
                let right = getViewingDistance(height: tree, trees: getTrees(grid: grid, direction: .Right, x: x, y: y))
                let bottom = getViewingDistance(height: tree, trees: getTrees(grid: grid, direction: .Bottom, x: x, y: y))
                let left = getViewingDistance(height: tree, trees: getTrees(grid: grid, direction: .Left, x: x, y: y))
                let score = top * right * bottom * left
//                print("tree:",tree, "else:",top,right,bottom,left,"=", score)

                
                if (score > answer) {
                    answer = score
                }
            }
        }
    }
    
    print("part2:", answer)
}
