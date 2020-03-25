import Foundation

class TreeNode {
    
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
        if let left = parent?.left, left.value == self.value {
            return parent?.right
        }
        return parent?.left
    }
}

extension TreeNode : Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
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
            let nIsLeft = node.parent?.left == node.parent
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
        
        debugPrint("parent: " + String(curNode!.parent!.value))
        
        return curNode!
    }
    
    private func recolor(node: TreeNode?) {
        guard node != nil else {
            return
        }
        
        let p = node?.parent; let u = node?.uncle(); let g = p?.parent;
        p?.color = .black
        u?.color = .black
        g?.color = .red
        recolor(node: g)
    }
    
    private func rightRotate(n: TreeNode?) {
        let p = n?.parent
        p?.left = n?.right; p?.left?.parent = p
        n?.right = p;
        n?.parent = p?.parent
        p?.parent = n
        p?.color = .red
        n?.color = .black
    }
    
    private func leftRotate(n: TreeNode?) {
        let p = n?.parent
        p?.right = n?.left; p?.right?.parent = p
        n?.left = p
        p?.parent = n
        n?.color = .black
        p?.color = .red
    }
    
    func test() {
        debugPrint("RedBlackTree")
        
        let rootValue = 10
        let tree = RedBlackTree()

        tree.insert(value: rootValue)
        tree.insert(value: 5)
        tree.insert(value: 20)

        tree.insert(value: 2)

        debugPrint("RedBlackTree")
        debugPrint(tree.root?.value as Any)
        debugPrint(tree.root?.color as Any)

        debugPrint(tree.root?.left?.value as Any)
        debugPrint(tree.root?.left?.color as Any)

        debugPrint(tree.root?.right?.value as Any)
        debugPrint(tree.root?.right?.color as Any)

        debugPrint(tree.root?.left?.left?.value as Any)
        debugPrint(tree.root?.left?.left?.color as Any)

    }
}
