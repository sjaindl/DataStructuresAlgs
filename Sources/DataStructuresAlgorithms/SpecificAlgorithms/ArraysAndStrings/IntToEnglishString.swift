//
//  IntToEnglishString.swift
//  
//
//  Created by Stefan Jaindl on 19.11.20.
//

import Foundation

open class IntToEnglishString {
    
    public init() { }
    
    private enum Config: CaseIterable {
        case ones
        case tens
        case hundred
        case thousand
        case tenthousand
        case hundredthousand
        case million
        case tenmillion
        case hundredmillion
        case billion
    }
    
    private let ones: [Int: String] = [
        0: "",
        1: "One",
        2: "Two",
        3: "Three",
        4: "Four",
        5: "Five",
        6: "Six",
        7: "Seven",
        8: "Eight",
        9: "Nine"
    ]
    
    private let tens: [Int: String] = [
        0: "",
        1: "Ten",
        2: "Twenty",
        3: "Thirty",
        4: "Fourty",
        5: "Fifty",
        6: "Sixty",
        7: "Seventy",
        8: "Eighty",
        9: "Ninety"
    ]
    
    private let specialTens: [Int: String] = [
        0: "Ten",
        1: "Eleven",
        2: "Twelve",
        3: "Thirteen",
        4: "Fourteen",
        5: "Fifteen",
        6: "Sixteen",
        7: "Seventeen",
        8: "Eighteen",
        9: "Nineteen"
    ]
    
    private let zero = "zero"
    private let hundred = "hundred"
    private let thousand = "thousand"
    private let million = "million"
    private let billion = "billion"
    
    open func convertToEnglishString(number: Int) throws -> String {
        let stack = Stack<String>()
        
        var convertedString = ""
        var curNumber = number
        let order = Config.allCases
        var orderIndex = 0
        var thousandAppended = false
        var millionAppended = false
        
        while curNumber > 0 {
            let currentDigit = curNumber % 10
            let place = order[orderIndex]
            var valueOfPlace: String
            
            switch place {
            case .ones:
                valueOfPlace = ones[currentDigit]!
            case .tens:
                valueOfPlace = try tens(with: "", stack: stack, currentDigit: currentDigit)
            case .hundred:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
            case .thousand:
                valueOfPlace = digit(with: thousand, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    thousandAppended = true
                }
            case .tenthousand:
                valueOfPlace = try tens(with: thousandAppended ? "" : thousand, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    thousandAppended = true
                }
            case .hundredthousand:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty, !thousandAppended {
                    valueOfPlace.append(" \(thousand)")
                }
            case .million:
                valueOfPlace = digit(with: million, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    millionAppended = true
                }
            case .tenmillion:
                valueOfPlace = try tens(with: millionAppended ? "" : million, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    millionAppended = true
                }
            case .hundredmillion:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty, !millionAppended {
                    valueOfPlace.append(" \(million)")
                }
            case .billion:
                valueOfPlace = digit(with: billion, stack: stack, currentDigit: currentDigit)
            }
            
            stack.push(val: valueOfPlace)
            convertedString += valueOfPlace
            
            orderIndex += 1
            curNumber %= 10
        }
        
        return convertedString.isEmpty ? zero : convertedString
    }
    
    private func tens(with appended: String, stack: Stack<String>, currentDigit: Int) throws -> String {
        var valueOfPlace = ""
        
        let onesPlace = try stack.pop()
        valueOfPlace = tens[currentDigit]!
        if valueOfPlace == ones[1]! {
            valueOfPlace = specialTens[Int(onesPlace)!]!
        }
        
        return valueOfPlace
    }
    
    private func digit(with appended: String, stack: Stack<String>, currentDigit: Int) -> String {
        var valueOfPlace = ""
        
        valueOfPlace = ones[currentDigit]!
        if !valueOfPlace.isEmpty, !appended.isEmpty {
            valueOfPlace.append(" \(appended)")
        }
        
        return valueOfPlace
    }
}
