import Foundation

enum MyError: Error {
    case runtimeError(String)
}

open class Node<T> {
    var next: Node?
    var val: T
    var prev: Node?
    
    init(val: T, next: Node? = nil, prev: Node? = nil) {
        self.val = val
        self.next = next
        self.prev = prev
    }
}

open class LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    var count: Int = 0
    
    func add(node: Node<T>) {
        if count == 0 {
            head = node
            tail = node
        } else {
            let temp = tail
            tail = node
            temp?.next = tail
            tail?.prev = temp
        }
        count += 1
    }
    
    func removeLast() throws {
        if count == 0 {
            throw MyError.runtimeError("Invalid call")
        }
        
        if count == 1 {
            head = nil; tail = nil
        } else {
            tail?.prev?.next = nil
            tail = tail?.prev
        }
        count -= 1
    }
    
    func removeByKey(val: Int) {
        var current = head
        
        while current != nil {
            if let cur = current, let curVal = current?.val as? Int, curVal == val, let headVal = head?.val as? Int, let tailVal = tail?.val as? Int {
                if count == 1 {
                    head = nil; tail = nil;
                } else if curVal == headVal {
                    head?.next?.prev = nil
                    head = head?.next
                } else if curVal == tailVal {
                    tail?.prev?.next = nil
                    tail = tail?.prev
                } else {
                    if let prev = cur.prev {
                        prev.next = cur.next
                    }
                    if let next = cur.next {
                        next.prev = cur.prev
                    }
                }
                
                if headVal == tailVal {
                    head = tail
                }
                
                count -= 1
                
                return
            }
            
            current = current?.next
        }
    }
}
