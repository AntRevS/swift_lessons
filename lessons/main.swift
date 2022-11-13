//
//  main.swift
//  lessons
//
//  Created by Антон Ревякин on 13.11.2022.
//

//Infix to postfix
let infixToPostfixMapper = InfixToPostfixMapper(infix: "x * y / (5 * z) + 10")
print(infixToPostfixMapper.map())
