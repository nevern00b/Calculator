//
//  ViewController.swift
//  Calculator
//
//  Created by Reyana Fayyaz on 11/7/15.
//  Copyright (c) 2015 Reyana Fayyaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//class classname: superclass {code}
    
//instance variable that points to the "0" label
    
    @IBOutlet weak var display: UILabel! //@IBOutlet is from Xcode (circle on left shows you what this is connected to), Swift - all objects live in the heap, memory is managed for you - not garbage collection, it's reference counting - all automatic. var = variable, display = variable name, UILabel = type.
    //exclamation mark says - always automatically unwrap this object so you don't have to unwrap it when your reference it later in the code

    var userIsInTheMiddleofTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) { //method where the argument is the button, func - method, name of argument: type, if it returned something it would look like "-> String" or whatever Type was being returned
        
        let digit = sender.currentTitle! //create local var of the digit on button that was pressed. let is a CONSTANT, value cannot be changed.
        
        if userIsInTheMiddleofTypingANumber { //check to see if user is in the middle of typing a number
            display.text = display.text! + digit //append number to display label
        } else {
            display.text = digit
            userIsInTheMiddleofTypingANumber = true
        }
        println("digit equals \(digit)") //\(var-name) allows you to reference a variable in a string
        
    }
    
   // var operandStack: Array<Double> = Array<Double>()
    var operandStack = Array<Double>() //create stack, initialize variable (type) could also include arguments
    @IBAction func enter() { //does not need an argument because only one key
        userIsInTheMiddleofTypingANumber = false
        operandStack.append(displayValue) //need to convert string to double so we can put it on stack
        
        println("operandStack = \(operandStack)") //print out stack
        
    }
    
    var displayValue: Double { //curly braces here means this value will always be computed
        get { //return the new value
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set { //set the new value
            display.text = "\(newValue)" //converts what's inside to string
            userIsInTheMiddleofTypingANumber = false
        }
        
        
    }
    
    
    @IBAction func operate(sender: UIButton) { //want argument to be operator
        let operation = sender.currentTitle! //set operation to title of the button so we know which operator to use
        if userIsInTheMiddleofTypingANumber {
            enter()
        }
        switch operation {//switch on string
        case "✖️": performOperation {$0 * $1} //last argument does not need to be within parentheses, don't even need parentheses if there is only one argument
        case "➗": performOperation {$1 / $0}
        case "➕": performOperation {$0 + $1}
        case "➖": performOperation {$1 - $0}
        case "✔️": performOperationOneArg {sqrt($0)}
        default: break //catchall case
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast()) //remove last 2 values and apply operation
            enter()
        }
    }

    func performOperationOneArg(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast()) //remove last 2 values and apply operation
            enter()
        }
    }
    

}

