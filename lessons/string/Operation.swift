//
//  Operation.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

enum Operation: Character, CaseIterable {
    
    case BraceLeft = "("
    case BraceRight = ")"
    case Addition = "+"
    case Substraction = "-"
    case Multiplication = "*"
    case Division = "/"
    case Nothing = " "
    
    static func getOperation(oper: Character) -> Operation {
        var operation: Operation = Nothing
        self.allCases.forEach {
            if $0.rawValue == oper {
                operation = $0
            }
        }
        return operation
    }
}
