//
//  BitVector.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class BitVector {
    
    private let numberOfBits: Int
    private var bitStorage: [UInt64]
    private var base = 64
    
    init(numberOfBits: Int) {
        self.numberOfBits = numberOfBits
        
        //storage has place for 64 bits per UInt64 array entry. Round up.
        let arraySize = (numberOfBits + base - 1) / base
        bitStorage = [UInt64] (repeating: 0, count: arraySize)
    }
    
    func setBit(index: Int) {
        let arrayIndex = index / 64
        let bitIndex = UInt64(index - arrayIndex * 64)
        let bit: UInt64 = 1 << bitIndex
        
        bitStorage[arrayIndex] |= bit
    }
    
    func unsetBit(index: Int) {
        let arrayIndex = index / 64
        let bitIndex = UInt64(index - arrayIndex * 64)
        let bit: UInt64 = UInt64.max & 0 << bitIndex
        
        bitStorage[arrayIndex] &= bit
    }
    
    func isBitSet(index: Int) -> Bool {
        let arrayIndex = index / 64
        let bitIndex = UInt64(index - arrayIndex * 64)
        let bit: UInt64 = 1 << bitIndex
        
        return bitStorage[arrayIndex] & bit > 0
    }
}
