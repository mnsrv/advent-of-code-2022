import Foundation

public func day1() {
    let input = load(file: "day1/input")!

    var sum = 0
    var array = Array<Int>()

    input.enumerateLines { (line, _) in
        if (line != "") {
            sum = sum + Int(line)!
        } else {
            array.append(sum)
            sum = 0
        }
    }

    array.append(sum)

    var total = 0
    for _ in 1...3 {
        let arrayMax = array.max()!
        total += arrayMax
        
        let index = array.firstIndex(of: arrayMax)
        array.remove(at: index!)
    }

    print(total)
}
