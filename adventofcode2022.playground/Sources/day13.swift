import Foundation

func compareLR(_ left: Any, _ right: Any) -> Int {
//    print("Compare", left, "vs", right)
    if let lNumber = left as? Int,
       let rNumber = right as? Int {
//        print("both integers")
        if (lNumber < rNumber) {
            return 1
        } else if (lNumber > rNumber) {
            return -1
        } else {
            return 0
        }
    } else if let lArray = left as? Array<Any>,
              let rArray = right as? Array<Any> {
//        print("both arrays")
        
        let maxCount = max(lArray.count, rArray.count)
        
        if (lArray.count == 0 && rArray.count == 0) {
//            print("If the lists are the same length and no comparison makes a decision about the order, continue checking the next part of the input.")
            return 0
        }
        
        for i in 0...(maxCount - 1) {
            if !lArray.indices.contains(i) {
//                print("Left side ran out of items")
                return 1
            } else if !rArray.indices.contains(i) {
//                print("Right side ran out of items")
                return -1
            }
            let l = lArray[i]
            let r = rArray[i]
            
            let result = compareLR(l, r)
            if (result != 0) {
//                print("NOT EQUAL")
                return result
            }
        }
        return 0
    } else if (left is NSNumber || right is NSNumber) {
//        print("exactly one integer")
        if let lNumber = left as? Int {
            return compareLR([lNumber], right)
        } else if let rNumber = right as? Int {
            return compareLR(left, [rNumber])
        }
//        print("WTF??")
        return 0
    }
//    print("NO NO NO")
    return 0
}

func backward(_ left: Any, _ right: Any) -> Bool {
    return compareLR(left, right) > 0
}

public func day13() {
    let input = load(file:"day13/input")!
    
    var packed1 = ""
    var packed2 = ""
    var index = 1
    var rightIndices = [Int]()
    
    input.enumerateLines { (line, _) in
        if line == "" {
            print("")
        } else if (packed1 == "") {
            packed1 = line
        } else {
            packed2 = line
            
            let data1 = Data(packed1.utf8)
            let data2 = Data(packed2.utf8)
            var result = 0
            
            do {
                // make sure this JSON is in the format we expect
                if let json1 = try JSONSerialization.jsonObject(with: data1, options: []) as?   [Any],
                   let json2 = try JSONSerialization.jsonObject(with: data2, options: []) as? [Any] {
                    // try to read out a string array
//                    print("index", index)
//                    print(packed1)
//                    print(packed2)
                    
                    result = compareLR(json1, json2)
                    print("result", index, result)
                    if result == 1 {
                        rightIndices.append(index)
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }

            // reset
            packed1 = ""
            packed2 = ""
            index += 1
            result = 0
        }
    }
    
    print("")
    print("day 13:", rightIndices.reduce(0, +))
}

public func day13part2() {
    let input = load(file:"day13/input")!
    
    let dividerPacket1 = [[2]]
    let dividerPacket2 = [[6]]
    var packets: Array<Any> = [dividerPacket1, dividerPacket2]
    
    input.enumerateLines { (line, _) in
        if line == "" {
//            print("")
        } else {
            let data = Data(line.utf8)
            
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                    // try to read out a string array
                    packets.append(json)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    let ordered = packets.sorted(by: backward)
    var index1 = 0
    var index2 = 0
    
    for i in 0...(ordered.count - 1) {
        if (ordered[i] as? [[Int]] == dividerPacket1) {
            index1 = i + 1
        }
        if (ordered[i] as? [[Int]] == dividerPacket2) {
            index2 = i + 1
        }
    }
//    print("")
    print("day 13 part 2:", index1, index2, index1 * index2)
}
