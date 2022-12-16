import Foundation

public func day7() {
    let input = load(file:"day7/input")!

    let root = Node("/")
    var currentNode = root
    
    input.enumerateLines { (line, _) in
        let split = line.components(separatedBy: " ")

        if (split[0] == "$") {
            if (split[1] == "cd") {
                // change directory
                if (split[2] == "..") {
                    let curr = currentNode.parent
                    if (curr != nil) {
                        currentNode = curr!
                    } else {
                        // already root
                        // currentNode = roo
                    }
                } else if (split[2] == "/") {
                    currentNode = root
                } else {
                    let curr = currentNode.get(name: split[2])
                    if (curr != nil) {
                        currentNode = curr!
                    } else {
                        let dir = Node(split[2])
                        currentNode.add(dir)
                        currentNode = dir
                    }
                }
            } else if (split[1] == "ls") {
                // list content of directory
            }
        } else {
            if (split[0] == "dir") {
                let dir = Node(split[1])
                currentNode.add(dir)
            } else if (Int(split[0]) != nil) {
                let file = Node(split[1], Int(split[0])!)
                currentNode.add(file)
            }
        }
        
    }
    
    
    let allDirectories = root.lsAllDirectories()
    let sizes = allDirectories.map { $0.sizeOfDirectory() }
    var answer = 0
    for size in sizes {
        if (size <= 100000) {
            answer += size
        }
    }
    
    print("part1:", answer)
}

public func day7part2() {
    let input = load(file:"day7/input")!
    
    let total = 70000000
    let required = 30000000

    let root = Node("/")
    var currentNode = root
    
    var used = 0
    
    input.enumerateLines { (line, _) in
        let split = line.components(separatedBy: " ")

        if (split[0] == "$") {
            if (split[1] == "cd") {
                // change directory
                if (split[2] == "..") {
                    let curr = currentNode.parent
                    if (curr != nil) {
                        currentNode = curr!
                    } else {
                        // already root
                        // currentNode = roo
                    }
                } else if (split[2] == "/") {
                    currentNode = root
                } else {
                    let curr = currentNode.get(name: split[2])
                    if (curr != nil) {
                        currentNode = curr!
                    } else {
                        let dir = Node(split[2])
                        currentNode.add(dir)
                        currentNode = dir
                    }
                }
            } else if (split[1] == "ls") {
                // list content of directory
            }
        } else {
            if (split[0] == "dir") {
                let dir = Node(split[1])
                currentNode.add(dir)
            } else if (Int(split[0]) != nil) {
                let file = Node(split[1], Int(split[0])!)
                used += Int(split[0])!
                currentNode.add(file)
            }
        }
    }

    let unused = total - used
    let needToFree = required - unused
    
    let allDirectories = root.lsAllDirectories()
    let sizes = allDirectories.map { $0.sizeOfDirectory() }
    let sortedSizes = sizes.sorted()
    var answer = 0
    for size in sortedSizes {
        if (size >= needToFree) {
            answer = size
            break
        }
    }
    
    print("part2:", answer)
}
