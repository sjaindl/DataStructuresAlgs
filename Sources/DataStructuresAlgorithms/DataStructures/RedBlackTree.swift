import Foundation

open class TreeNode {
    
    enum TreeColor {
        case red
        case black
    }
    
    var left: TreeNode?
    var right: TreeNode?
    var parent: TreeNode?
    var value: Int
    var color = TreeColor.red
    
    init(parent: TreeNode?, value: Int) {
        self.parent = parent
        self.value = value
    }
    
    func isRoot() -> Bool {
        return parent == nil
    }
    
    func uncle() -> TreeNode? {
        if let left = parent?.parent?.left, left.value == parent?.value {
            return parent?.parent?.right
        }
        return parent?.parent?.left
    }
}

extension TreeNode : Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.value == rhs.value
    }
}

open class RedBlackTree {
    var root: TreeNode?
    
    func insert(value: Int) {
        if root == nil {
            root = TreeNode(parent: nil, value: value)
            root?.color = .black
            return
        }
        
        let node = bstInsert(value: value)
        
        if node.parent?.color == .black {
            return //everything ok, no double red violation
        }
        
        //else: Double red violation!
        
        if let uncle = node.uncle(), uncle.color == .red {
            //try to recolor: parent and uncle are both red!
            recolor(node: node)
        } else {
            let nIsLeft = node.parent?.left == node
            let pIsLeft = node.parent?.parent?.left == node.parent
            
            if nIsLeft && pIsLeft {
                rightRotate(n: node.parent)
            } else if !nIsLeft && pIsLeft {
                leftRotate(n: node)
                rightRotate(n: node)
            } else if nIsLeft && !pIsLeft {
                leftRotate(n: node)
            } else { //both right
                leftRotate(n: node.parent)
            }
        }
    }
    
    private func bstInsert(value: Int) -> TreeNode { //assumption: no equal value nodes, root exists
        var curNode = root
        
        while true {
            if curNode!.value > value {
                if curNode?.left != nil {
                    curNode = curNode?.left
                } else {
                    curNode?.left = TreeNode(parent: curNode, value: value)
                    curNode = curNode?.left
                    break
                }
            } else {
                if curNode?.right != nil {
                    curNode = curNode?.right
                } else {
                    curNode?.right = TreeNode(parent: curNode, value: value)
                    curNode = curNode?.right
                    break
                }
            }
        }
        
        return curNode!
    }
    
    private func recolor(node: TreeNode?) {
        guard node != nil else {
            return
        }
        
        let p = node?.parent
        let u = node?.uncle()
        let g = p?.parent
        
        p?.color = .black
        u?.color = .black
        g?.color = .red
        
        if g?.parent == nil {
            g?.color = .black //paint root always black
        }
        
        recolor(node: g)
    }
    
    private func rightRotate(n: TreeNode?) {
        let p = n?.parent
        p?.left = n?.right
        p?.left?.parent = p
        
        n?.right = p
        n?.parent = p?.parent
        p?.parent = n
        if n?.parent == nil {
            root = n
        }
        
        p?.color = .red
        n?.color = .black
    }
    
    private func leftRotate(n: TreeNode?) {
        let p = n?.parent
        p?.right = n?.left
        p?.right?.parent = p
        
        n?.left = p
        n?.parent = p?.parent
        p?.parent = n
        if n?.parent == nil {
            root = n
        }
        
        n?.color = .black
        p?.color = .red
    }
}
