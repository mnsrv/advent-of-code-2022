import Foundation

func getPosition(of: Character) -> Int {
    let a = of.isUppercase ? "A" : "a"
    let add = of.isUppercase ? 27 : 1
    
    return Int(of.unicodeScalars.first!.value) - Int(UnicodeScalar(a)!.value) + add
}

public func day3() {
    let input = load(file:"day3/input")!
    
    var sum = 0
    
    input.enumerateLines { (line, _) in
        let first = line.prefix(line.count / 2)
        let second = line.suffix(line.count / 2)
        let set1 = Set(first)
        let set2 = Set(second)
        
        let char = set1.intersection(set2).first
        let position = getPosition(of: char!)
        
        sum += position
    }
    print("part1:", sum)
}

public func day3part2() {
    let input = load(file:"day3/input")!
    
    var sum = 0
    var inter = Set<Character>()
    var count = 0
    
    input.enumerateLines { (line, _) in
        count = count + 1

        if (inter.isEmpty) {
            inter = Set(line)
        } else {
            inter = Set(line).intersection(inter)
        }

        if (count % 3 == 0) {
            let char = inter.first!
            let position = getPosition(of: char)
            sum = sum + position
            inter = Set()
        }
    }
    
    print("part2:", sum)
}
