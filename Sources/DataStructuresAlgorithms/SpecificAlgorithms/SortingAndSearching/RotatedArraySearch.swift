//
//  RotatedArraySearch.swift
//  
//
//  Created by Stefan Jaindl on 21.09.20.
//

import Foundation

private enum SearchDirection {
    case start
    case left
    case right
}

open class RotatedArraySearch<T: Comparable> {
    public init() { }
    
    open func search(array: [T], searched: T) -> Int? {
        guard !array.isEmpty  else {
            return nil
        }
        return search(array: array, searched: searched, low: 0, high: array.count - 1, lastValue: array[0] /* It doesn't matter! */, direction: .start)
    }
    
    private func search(array: [T], searched: T, low: Int, high: Int, lastValue: T, direction: SearchDirection) -> Int? {
        let center = low + (high - low) / 2
        let curValue = array[center]
        if curValue == searched {
            return center
        }
        
        if high <= low {
            return nil
        }
        
        let rotated = isRotated(direction: direction, lastValue: lastValue, curValue: curValue)
        
        switch direction {
        case .start:
            if let index = search(array: array, searched: searched, low: low, high: center - 1, lastValue: curValue, direction: .left) {
                return index
            }
            return search(array: array, searched: searched, low: center + 1, high: high, lastValue: curValue, direction: .right)
        case .left:
            if (rotated && searched < lastValue || searched > curValue) || (!rotated && searched > curValue) {
                return search(array: array, searched: searched, low: center + 1, high: high, lastValue: curValue, direction: .right)
            } else {
                return search(array: array, searched: searched, low: low, high: center - 1, lastValue: curValue, direction: .left)
            }
        case .right:
            if (rotated && searched < curValue || searched > lastValue) || (!rotated && searched < curValue) {
                return search(array: array, searched: searched, low: low, high: center - 1, lastValue: curValue, direction: .left)
            } else {
                return search(array: array, searched: searched, low: center + 1, high: high, lastValue: curValue, direction: .right)
            }
        }
    }
    
    private func isRotated(direction: SearchDirection, lastValue: T, curValue: T) -> Bool {
        switch direction {
        case .left:
            return lastValue < curValue
        case .right:
            return lastValue > curValue
        case .start:
            return false //It doesn't matter!
        }
    }
}
