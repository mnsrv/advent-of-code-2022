import Foundation

final class Node {
    var name: String
    var size: Int
    var isDirectory: Bool
    var level: Int
    var children: [Node] = []
    weak var parent: Node?
    
    init(_ name: String) {
        self.name = name
        self.size = 0
        self.level = 0
        self.isDirectory = true
        self.children = []
    }
    
    init(_ name: String, _ size: Int) {
        self.name = name
        self.size = size
        self.level = 0
        self.isDirectory = false
        self.children = []
    }
    
    func add(_ child: Node) {
        child.parent = self
        child.level = self.level + 1
        children.append(child)
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var text = ""
        let levelSpace = String(repeating: "  ", count: level)
        if (isDirectory) {
            text = "\(levelSpace)- \(name) (dir)\n"
        } else {
            text = "\(levelSpace)- \(name) (file, size=\(size))\n"
        }
        
        if !children.isEmpty {
            for child in children {
                text += child.description
            }
        }

        return text
    }
}

extension Node {
    func get(name: String) -> Node? {
        if name == self.name {
            return self
        }
        for child in children {
            if child.name == name {
                return child
            }
        }
        return nil
    }
}

extension Node {
    func lsAllDirectories() -> [Node] {
        var nodes: [Node] = []
        
        if (isDirectory) {
            nodes.append(self)
            
            for child in children {
                nodes.append(contentsOf: child.lsAllDirectories())
            }
        }
        
        return nodes
    }
    
    func sizeOfDirectory() -> Int {
        var sizeOfDirectory = 0
        
        if (!isDirectory) {
            sizeOfDirectory = size
        }
        
        if (isDirectory) {
            for child in children {
                sizeOfDirectory += child.sizeOfDirectory()
            }
        }
        
        return sizeOfDirectory
    }
}

func load(file named: String) -> String? {
    guard let filePath = Bundle.main.url(forResource: named, withExtension: "txt") else {
        return nil
    }
    guard let content = try? String(contentsOf: filePath, encoding: .utf8) else {
        return nil
    }
    return content
}
