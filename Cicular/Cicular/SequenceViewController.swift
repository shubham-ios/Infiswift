//
//  SequenceViewController.swift
//  Cicular
//
//  Created by Sourabh on 24/08/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation
import UIKit

class SequenceViewController: UIViewController {

    var sequence : [Int] = []
    @IBOutlet weak var textField: UITextField! //to take inputs
    @IBOutlet weak var textView: UITextView!   //to display progress
    @IBOutlet weak var textLabel: UILabel!     //to display the result

    override func viewDidLoad() {
        super.viewDidLoad()
        //adding a button to reset
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reset))
        textView.text = "\(sequence)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// taking inputs when submit is pressed
    @IBAction func didPressedSubmit() {
        if let text = textField.text, !text.isEmpty { //discarding the empty values
            sequence.append(Int(text)!)               //appending the valid values
        }
        textField.text = nil                          //clear the input field
        textView.text = "\(sequence)"                 //displaying the sequence
    }
    
    /// resetting everything
    func reset() {
        sequence.removeAll()                          //clear the sequence
        textView.text = "\(sequence)"                 //clear displayed sequence
        textLabel.text = nil                          //clear result
    }
    
    /// finding out the missing element
    @IBAction func findFirstMissingNumber() {
        var str = "\(sequence)\n"                    //to display the queue
        for i in 0..<sequence.count {                //to itrate
            let number = abs(sequence[i])            //absolute value
            if number <= sequence.count {            //to check the value is less than bounds
                if sequence[number-1] > 0 {          //to avoid repeated elements
                    sequence[number-1] = -sequence[number-1] //changing the sign to take into the account again
                }
            } else {
                sequence[i] = -number               //changing the sign of out of bounds number to ignore
            }
            str += "After \(i) = \(sequence)\n"     //showing every step to user
        }
        textView.text = str                         //finally showing all the steps
        
        for i in 0..<sequence.count {               //determining the missing element by index
            if sequence[i] > 0 {                    //if number is positive then the index is element which is missed
                textLabel.text = "Missing = \(i+1)" //displaying the result
                break
            } else if i == (sequence.count - 1) {   //if the last number is missing
                textLabel.text = "Missing = \(i+2)" //displaying the result
            }
        }
    }
}

