//
//  Priority.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

import Foundation

enum Priority {
    
    case Nothing, Brace, AddSub, Muldiv
    
    var number: Int {
        switch self {
        case .Nothing: return -1
        case .Brace: return 0
        case .AddSub: return 1
        case .Muldiv: return 2
        }
    }
}
