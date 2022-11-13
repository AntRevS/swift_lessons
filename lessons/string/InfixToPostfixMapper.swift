//
//  InfixToPostfixMapper.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

import Foundation

private let WHITESPACE = " "
private let EMPTY = ""

class InfixToPostfixMapper {
    
    private var infix: String
    private var priority: Priority = Priority.Nothing
    private var infixSymbols: Array<Character>
    private var oper: Stack<Character> = Stack()
    private var postfix: String = ""
    
    private var tempOperand = EMPTY
    
    init(infix: String) {
        let newInfix = infix + WHITESPACE
        self.infix = newInfix
        self.infixSymbols = newInfix.map { $0 }
    }
    
    func map() -> String {
        infixSymbols.enumerated().forEach { (index, it) in
            if !it.isHexDigit && !it.isDot() {
                if !tempOperand.isEmpty {
                    tempOperand.forEach {
                        postfix.append($0)
                    }
                    tempOperand = EMPTY
                    postfix += WHITESPACE
                }
            }
            if it.isLetter {
                postfix.append(it)
                postfix += WHITESPACE
            } else if it.isHexDigit || it.isDot() {
                tempOperand.append(it)
            } else if it.isOperation() {
                processOperation(operation: Operation.getOperation(oper: it))
            }
        }
        while !oper.isEmpty() {
            postfix.append(oper.pop())
            postfix += WHITESPACE
        }
        return postfix
    }
    
    private func processOperation(operation: Operation) {
        switch operation {
        case Operation.Addition, Operation.Substraction:
            processComputationSign(
                operation: operation,
                operPriority: Priority.AddSub
            )
            
        case Operation.Multiplication, Operation.Division:
            processComputationSign(
                operation: operation,
                operPriority: Priority.Muldiv
            )
        case Operation.BraceLeft, Operation.BraceRight:
            processBrace(operation: operation)
        default: break
        }
    }
    
    private func processBrace(operation: Operation) {
        switch operation {
        case Operation.BraceLeft:
            oper.push(element: operation.rawValue)
            priority = Priority.Brace
        case Operation.BraceRight:
            while (oper.peek() != Operation.BraceLeft.rawValue || oper.isEmpty()) {
                postfix.append(oper.pop())
                postfix += WHITESPACE
            }
            oper.pop()
            if (oper.isEmpty()) {
                priority = Priority.Nothing
            } else {
                let peek = Operation.getOperation(oper: oper.peek())
                switch peek {
                case Operation.Addition, Operation.Substraction:
                    priority = Priority.AddSub
                case Operation.Multiplication, Operation.Division:
                    priority = Priority.Muldiv
                case Operation.BraceLeft:
                    priority = Priority.Brace
                default: break
                }
            }
        default:
            break
        }
    }
    
    private func processComputationSign(
        operation: Operation,
        operPriority: Priority
    ) {
        if (operPriority.number > priority.number) {
            oper.push(element: operation.rawValue)
            priority = operPriority
        } else {
            while operPriority.number <= priority.number {
                let isProcessed = processPeek(operPriority: operPriority)
                if !isProcessed {
                    priority = Priority.Nothing
                    oper.push(element: operation.rawValue)
                }
            }
        }
    }
    
    private func processPeek(operPriority: Priority) -> Bool {
        var isProcessed: Bool = false
        if !oper.isEmpty() {
            let take = Operation.getOperation(oper: oper.peek())
            switch take {
            case Operation.Addition, Operation.Substraction:
                let peekPriopity = Priority.AddSub
                if peekPriopity.number >= operPriority.number {
                    oper.pop()
                    postfix.append(take.rawValue)
                    postfix += WHITESPACE
                    isProcessed = true
                }
            case Operation.Multiplication, Operation.Division:
                let peekPriority = Priority.Muldiv
                if peekPriority.number >= operPriority.number {
                    oper.pop()
                    postfix.append(take.rawValue)
                    postfix += WHITESPACE
                    isProcessed = true
                }
            case Operation.BraceLeft:
                priority = Priority.Brace
                isProcessed = true
            default:
                break
            }
        }
        return isProcessed
    }
}
