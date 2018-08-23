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

//let merged = mergeTwoLists(listOne, listTwo)
//printList(merged)

// Problem: Return all root to leaf paths of a binary tree. Example.
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

// For those who had to look it up like me. the `inout` keyword will allow you to modify the parameter.
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

// Problem: You are climbing a staircase. It takes n steps to reach to the top.
// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
// Node: Given n will be a positive integer.
func climbStairs(_ n: Int) -> Int {
    //Think about this problem in steps
    // This numbers of ways to get to n steps is the number of ways to get to n - 1 plus the number of ways to get to n - 2 steps since
    // those are the sumer of steps we can take. We also know. That there is 1 way to get to 1 step. and 2 ways to get to 2 steps. so we can see this is similar to the fibonacci sequence.
    if n <= 2 {
        return n
    }
    
    var dpArray = Array(repeating: 0, count: 2)
    dpArray[0] = 2
    dpArray[1] = 1
    
    for _ in 3...n {
        let current = dpArray[0] + dpArray[1]
        dpArray[1] = dpArray[0]
        dpArray[0] = current
    }
    return dpArray[0]
}

// Problem: Pascals Triangle. Given a non-negative integer numRows, generate the first numRows of Pascal's triangle.
func generate(_ numRows: Int) -> [[Int]] {
    if numRows == 0 {
        return []
    }
    var rows = [[Int]]()
    rows.append([1])

    for i in 1..<numRows {
        rows.append([])
        for j in 0...i {
            let previous = rows[i-1]
            var current = 0
            if j < previous.count {
                current += previous[j]
            }
            if j - 1 >= 0 {
                current += previous[j-1]
            }
            rows[i].append(current)
        }

    }
    return rows
}

// Problem: Two sum. Given an array of integers, return indices of the two numebrs such that they add up to a specific target. You may assume that each input would have exactly one solution, and you may not user the same element twice.
// Eample. given nums = [2, 7, 11, 15], target = 9 return [0,1] because nums[0] + nums[1] = 9
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = Dictionary<Int, Int>()
    var components = [Int]()
    
    for (index, num) in nums.enumerated() {
        let complement = target - num
        
        if let complementIndex = dict[complement] {
            components.append(complementIndex)
            components.append(index)
        }
        dict[num] = index
    }
    
    return components
}

// Problem: Implement strStr().
// Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
// s/o https://leetcode.com/yy929058/ for the clean sollution after my crazy one.
func strStr(_ haystack: String, _ needle: String) -> Int {
    guard needle.count != 0 else { return 0 }
    if let range = haystack.range(of: needle) {
        return haystack.distance(from: haystack.startIndex, to: range.lowerBound)
    }
    return -1
}

// Problem: Implement int sqrt(int x) https://leetcode.com/problems/sqrtx/description/
func mySqrt(_ x: Int) -> Int {
    // binary search for i where i = x/i
    guard x != 0 else { return 0 }
    var start = 1
    var end = x
    while start + 1 < end {
        let middle = start + (end - start)/2
        if middle == x/middle {
            return middle
        }
        
        if middle < x/middle {
            start = middle
        } else {
            end = middle
        }
    }
    return start
}

// Problem: product of array except self https://leetcode.com/problems/product-of-array-except-self/description/
func productExceptSelf(_ nums: [Int]) -> [Int] {
    let count = nums.count
    var result = [Int]()
    result.append(1)
    
    for i in 1..<count {
        result.append(result[i-1] * nums[i-1])
    }
    
    var right = 1
    for i in stride(from: count - 1, to: -1, by: -1) {
        print(i)
        result[i] *= right
        right *= nums[i]
    }
    return result
}

// Problem: https://leetcode.com/problems/max-increase-to-keep-city-skyline/description/
func maxIncreaseKeepingSkyline(_ grid: [[Int]]) -> Int {
    var increased = 0
    var topBottomSkyline = Array(repeating: 0, count: grid.count)
    var leftRightSkyline = Array(repeating: 0, count: grid[0].count)

    for i in 0...(grid.count - 1) {
        var leftRightMax = 0
        var topBottomMax = 0

        for j in 0...(grid[i].count - 1) {
            let leftRightTemp = grid[i][j]
            if leftRightTemp > leftRightMax  {
                leftRightMax = leftRightTemp
            }

            let topBottomTemp = grid[j][i]
            if topBottomTemp > topBottomMax {
                topBottomMax = topBottomTemp
            }
        }
        leftRightSkyline[i] = leftRightMax
        topBottomSkyline[i] = topBottomMax
    }
    
    // At this point we have the skyling. Loop through again, checking for the difference
    // between grid[i][i] and the min of leftRightSkyline[i] and topBottomSkyline[i]
    var count = 0
    for i in 0...(grid.count - 1) {
        for j in 0...(grid[i].count - 1) {
            let temp = grid[i][j]
            let increase = min(leftRightSkyline[i], topBottomSkyline[j]) - temp
            if increase > 0 {
                count += increase
            }
        }
    }
    
    return count
}














