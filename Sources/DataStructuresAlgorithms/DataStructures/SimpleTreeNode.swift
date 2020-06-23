//
//  SimpleTreeNode.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class SimpleTreeNode<T: Comparable> {
    
    public var left: SimpleTreeNode<T>?
    public var right: SimpleTreeNode<T>?
    public var value: T
    
    public init(value: T) {
        self.value = value
    }
}
