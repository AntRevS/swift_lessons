//
//  Stack.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

import Foundation

struct Stack<T> {
    
    fileprivate var array: [T] = []
    
    mutating func push(element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T {
        return array.popLast()!
    }
    
    func peek() -> T {
        return array.last!
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}
