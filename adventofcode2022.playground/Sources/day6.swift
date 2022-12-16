import Foundation

func getIndexOfUnique(input: String, count: Int) -> Int {
    var index = 0
    
    for i in 0...(input.count - count) {
        let start = input.index(input.startIndex, offsetBy: i)
        let end = input.index(start, offsetBy: count)
        let range = start..<end
        
        let set = Set(input[range])

        if (set.count == count) {
            index = i + count
            break
        }
    }

    return index
}

public func day6() {
    let input = load(file:"day6/input")!
    
    print("part1:", getIndexOfUnique(input: input, count: 4))
}

public func day6part2() {
    let input = load(file:"day6/input")!
    
    print("part2:", getIndexOfUnique(input: input, count: 14))
}
