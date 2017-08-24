//
//  CircularViewController.swift
//  Cicular
//
//  Created by Sourabh on 24/08/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation
import UIKit

class Node: NSObject {
    var object: String
    var next: Node?
    init(obj:String) {
        object = obj
    }
}

class Queue: NSObject {
    var head : Node?
    var tail: Node?
    override init() {
    }
    func enqueue(obj:Node) {
        if head == nil {
            head = obj
            tail = head
        } else {
            tail?.next = obj
            tail = obj
        }
    }
    func dequeue() -> Node? {
        let node = head
        if head?.next == nil {
            head = nil
            tail = nil
        } else {
            head = head?.next
        }
        node?.next = nil
        return node
    }
}

class CircularViewController: UIViewController {
    var queue = Queue()
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating a queue
        createQueue()
        
        //finding the loop
        findLoop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Utility
    /// to create a queue
    func createQueue() {
        //creating a queue
        for i in 1...11 {
            queue.enqueue(obj: Node(obj: "\(i)"))
        }
        //displaying a queue
        displayQueue()
        
        //making the queue to be ciruclar
        queue.tail?.next = queue.head?.next?.next?.next?.next?.next?.next
    }
    func findLoop() {
        //detetmining the circular
        var str = "Not Circular"         //to print the result
        var t1 = queue.head              //will move to next node
        var t2 = queue.head              //will move to next node by skipping one node
        
        while (t1 != nil && t2 != nil) { //will be true if not circular
            t1 = t1?.next                //moving to next node
            t2 = t2?.next?.next          //moving to next node by skipping one
            if t1 == t2 {                //nodes meet if it is circular
                str = "Circular"
                break
            }
        }
        textView.text = "\n" + (textView.text ?? "") + str  + "\n" //printing the result
    }
    
    
    /// to display the queue
    func displayQueue() {
        var str = "head"
        var temp = queue.head
        while temp != nil {
            str += " -> "
            str += temp?.object ?? "Invalid Object"
            temp = temp?.next
        }
        str += " <- tail"
        if str == "head <- tail" {
            textView.text = (textView.text ?? "") + "Empty" + "\n"
        } else {
            textView.text = (textView.text ?? "") + str + "\n"
        }
    }
}

