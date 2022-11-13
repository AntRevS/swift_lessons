//
//  OperationsUtils.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

import Foundation

private let DOT: Character = "."

extension Character {
    
    func isBrace() -> Bool {
        var isBrace = false
        switch self {
        case Operation.BraceLeft.rawValue:
            isBrace = true
        case Operation.BraceRight.rawValue:
            isBrace = true
        default:
            isBrace = false
        }
        return isBrace
    }
    
    func isOperation() -> Bool {
        return Operation.getOperation(oper: self) != Operation.Nothing
    }
    
    func isDot() -> Bool {
        return self == DOT
    }
}
