//
//  ViewController.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        LinkedList<Int>().test()
        RedBlackTree().test()
        Trie().test()
        Stack<Int>().test()
        Queue<Int>().test()
        MinHeap<Int>().test()
        HashTable.test()
        GraphSearch.testBFS()
        GraphSearch.testDFS()
        MergeSort<Int>.test()
        QuickSort<Int>.test()
        TopologicalSort.test()
        Djikstra.test()
        RabinKarpSubstringSearch.test()
        AVLTree<Int>.test()
    }


}

