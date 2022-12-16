import Foundation

public func day4() {
    let input = load(file:"day4/input")!
    
    var sum = 0
    
    input.enumerateLines { (line, _) in
        let elves = line.components(separatedBy: ",")
        let elf1 = elves[0].components(separatedBy: "-")
        let a = Int(elf1[0])!
        let b = Int(elf1[1])!
        let elf2 = elves[1].components(separatedBy: "-")
        let c = Int(elf2[0])!
        let d = Int(elf2[1])!
        
        if (a >= c && b <= d) {
            sum += 1
        } else if (c >= a && d <= b) {
            sum += 1
        }
    }
    
    print("day4 part1:", sum)
}

public func day4part2() {
    let input = load(file:"day4/input")!
    
    var sum = 0
    
    input.enumerateLines { (line, _) in
        let elves = line.components(separatedBy: ",")
        let elf1 = elves[0].components(separatedBy: "-")
        let a = Int(elf1[0])!
        let b = Int(elf1[1])!
        let elf2 = elves[1].components(separatedBy: "-")
        let c = Int(elf2[0])!
        let d = Int(elf2[1])!
        
        // ПЕРЕСЕКАЮЩИЕСЯ
        if (c - b <= 0 && a - d <= 0) {
            sum += 1
        }
    }
    
    print("day4 part2:", sum)
    
}
