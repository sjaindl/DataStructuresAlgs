import Foundation

open class TrieNode {
    let value: Character
    var terminates: Bool
    var childNodes: Dictionary<Character, TrieNode> = Dictionary()
    
    init(value: Character, terminates: Bool = false) {
        self.value = value
        self.terminates = terminates
    }
}

open class Trie {
    let root: TrieNode = TrieNode(value: " ")
    
    func insert(word: String) {
        insert(word: Array(word), node: root)
    }
    
    private func insert(word: [Character], node: TrieNode) {
        if word.count == 0 {
            return
        }
        
        var nextNode: TrieNode
        if let nextChildNode = node.childNodes[word[0]] {
            nextNode = nextChildNode
        } else {
            nextNode = TrieNode(value: word[0])
            node.childNodes[word[0]] = nextNode
        }
        
        if word.count == 1 {
            nextNode.terminates = true
        } else {
            let slice = word[1...]
            insert(word: Array(slice), node: nextNode)
        }
    }
    
    func search(word: String) -> Bool {
        var curNode: TrieNode? = root
        
        var chars = Array(word)
        
        if chars.count < 1 {
            return false
        }
        
        while curNode != nil && chars.count > 0 {
            let char = chars[0]
            curNode = curNode?.childNodes[char]
            chars = Array(chars[1...])
            if chars.count == 0, let curNode = curNode, curNode.terminates {
                return true
            }
        }
        
        return false
    }
    
    func test() {
        let trieValue = "Trie"
        let trie = Trie()

        trie.insert(word: trieValue)

        debugPrint("Trie")
        debugPrint(trie.search(word: "T"))
        debugPrint(trie.search(word: trieValue))
        debugPrint(trie.search(word: "Triex"))

    }
}
