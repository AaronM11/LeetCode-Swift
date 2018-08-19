//: Playground - noun: a place where people can play

import UIKit
import Foundation

// This is a Playground of leetcode problems done in Swift. This is mostly for fun and to stay somewhat sharp
// for technical interviews. Do with it what you will.

// MARK: - LeetCode defined data structures.

// ListNode for a singly linked list
class ListNode {
    var val: Int
    var next: ListNode? = nil
    init(_ val: Int) {
        self.val = val
    }
}

//TreeNode for a binary tree
class TreeNode {
    var val: Int
    var left: TreeNode? = nil
    var right: TreeNode? = nil
    init(_ val: Int) {
        self.val = val
    }
}

// MARK: - Convience Methods
// Methods for printing arrays and lists and trees or whatever else comes up.
func printList(_ list: ListNode?) {
    var list = list
    if list == nil {
        print("List is nil")
    }
    
    while let node = list {
        print("Value: \(node.val)")
        list = list?.next
    }
}

// MARK: - Convience Constants
var listOne: ListNode? = ListNode(1)
listOne?.next = ListNode(2)
listOne?.next?.next = ListNode(3)

var listTwo: ListNode? = ListNode(1)
listTwo?.next = ListNode(3)
listTwo?.next?.next = ListNode(4)

// MARK: - Problems

// Problem: Reverse a singly linked List. Return the new head of the list.
func reverseList(_ head: ListNode?) -> ListNode? {
    var previous: ListNode? = nil
    var current = head
    
    while current != nil {
        let next = current?.next
        current?.next = previous
        previous = current
        current = next
    }
    
    return previous
}

// Problem: Can you create a ransom note string from a bank of characters found in magazine (string). Return true/false
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    
    var dictionary = [Character: Int]()
    
    for char in magazine {
        let count = dictionary.removeValue(forKey: char) ?? 0
        dictionary[char] = count + 1
    }
    
    for char in ransomNote {
        let count = dictionary[char] ?? 0
        if count <= 0 {
            return false
        }
        dictionary.removeValue(forKey: char)
        dictionary[char] = count - 1
    }
    
    return true
}

// Problem: Merge Two Sorted Single Linked Lists. Return the head of the new list.
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    var listOne = l1
    var listTwo = l2
    let dummyHead = ListNode(Int.min)
    var current: ListNode? = dummyHead
    
    while let nodeOne = listOne, let nodeTwo = listTwo {
        if nodeOne.val < nodeTwo.val {
            current?.next = nodeOne
            listOne = nodeOne.next
        } else {
            current?.next = nodeTwo
            listTwo = nodeTwo.next
        }
        current = current?.next
    }
    
    if listOne != nil {
        current?.next = listOne
    }
    
    if listTwo != nil {
        current?.next = listTwo
    }
    
    return dummyHead.next
}

let merged = mergeTwoLists(listOne, listTwo)
printList(merged)

// Return all root to leaf paths of a binary tree. Example.
//         1
//        / \
//       2   3
//        \
//         5
// Returns ["1->2->5", "1->3"]
func binaryTreePaths(_ root: TreeNode?) -> [String] {
    var paths = [String]()
    binaryTreePathsHelper(root, path: "", paths: &paths)
    return paths
}

func binaryTreePathsHelper(_ node: TreeNode?, path: String, paths: inout [String]) {
    guard let current = node else { return }
    let currentPath = "\(path)\(current.val)"
    
    // If leaf, append path to paths.
    if current.left == nil && current.right == nil {
        paths.append(currentPath)
    }
    // Check children.
    binaryTreePathsHelper(current.left, path: currentPath + "->", paths: &paths)
    binaryTreePathsHelper(current.right, path: currentPath + "->", paths: &paths)
}


