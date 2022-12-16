import Foundation

public func day5() {
    let input = load(file:"day5/input")!
    
    var dict: [Int: [Character]] = [:]
    
    input.enumerateLines { (line, _) in
        if (line.contains("[")) {
            // сохраняем буквы в словарь
            for (i, char) in line.enumerated() {
                if (i % 4 == 1 && char != " ") {
                    let index = Int(i / 4) + 1
                    
                    // проверяем
                    if (dict.keys.contains(index)) {
                        // вставляем в начало массива
                        dict[index]?.insert(char, at: 0)
                    } else {
                        // создаем массив из одного символа
                        dict[index] = [char]
                    }
                }
            }
        } else if (line.contains("move")) {
            // двигаем буквы
            let move = line.components(separatedBy: " ")
            let howMany = Int(move[1])!
            let from = Int(move[3])!
            let to = Int(move[5])!

            for _ in 1...howMany {
                // добавляем
                dict[to]!.append((dict[from]?.last!)!)
                // удаляем
                dict[from]?.removeLast()
            }
        }
    }
    
    print(dict)
    
    var answer = ""
    
    for i in 1...dict.count {
        answer.append((dict[i]?.last!)!)
    }
    
    print("part1:", answer)
}

public func day5part2() {
    let input = load(file:"day5/input")!
    
    var dict: [Int: [Character]] = [:]
    
    input.enumerateLines { (line, _) in
        if (line.contains("[")) {
            // сохраняем буквы в словарь
            for (i, char) in line.enumerated() {
                if (i % 4 == 1 && char != " ") {
                    let index = Int(i / 4) + 1
                    
                    // проверяем
                    if (dict.keys.contains(index)) {
                        // вставляем в начало массива
                        dict[index]?.insert(char, at: 0)
                    } else {
                        // создаем массив из одного символа
                        dict[index] = [char]
                    }
                }
            }
        } else if (line.contains("move")) {
            // двигаем буквы
            let move = line.components(separatedBy: " ")
            let howMany = Int(move[1])!
            let from = Int(move[3])!
            let to = Int(move[5])!

            // добавляем
            dict[to]!.append(contentsOf: (dict[from]?.suffix(howMany))!)
            // удаляем
            dict[from] = dict[from]!.dropLast(howMany)
        }
    }
    
    print(dict)
    
    var answer = ""
    
    for i in 1...dict.count {
        answer.append((dict[i]?.last!)!)
    }
    
    print("part1:", answer)
}
