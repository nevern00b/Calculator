//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Reyana Fayyaz on 11/14/15.
//  Copyright © 2015 Reyana Fayyaz. All rights reserved.
//

import Foundation //foundation is the core services layer, no UI - good because model is UI independent

class CalculatorBrain {
    
    
    private enum Op { //enums can have functions or computed properties
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
        
    }
    
    private var opStack = [Op]() //Array<Op>() //create empty array, first is usual syntax
    private var knownOps = [String: Op]() //Dictionary<String, Op>() //keys are strings, values are ops
    
    init() { //initializer!
        knownOps["✖️"] = Op.BinaryOperation("✖️", *)// {$0 * $1}
        knownOps["➗"] = Op.BinaryOperation("➗") {$1 / $0} //can't do this because the order is backwards
        knownOps["➕"] = Op.BinaryOperation("➕", +)// {$0 + $1}
        knownOps["➖"] = Op.BinaryOperation("➖") {$1 - $0}
        knownOps["✔️"] = Op.UnaryOperation("✔️", sqrt) //{sqrt($0)} //Unary Op
    }
    
    func evaluate() -> Double? { //has to be an optional in case someone uses calculator incorrectly, ? makes it an Optional
        
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand)) //Op. creates new enum
    }
    
    func performOperation(symbol: String) { //look up in known ops to find out what operation to put on the stack
        if let operation = knownOps[symbol] {//how you look up in a dictionary, type Optional because could not be in there
            opStack.append(operation) //if can find it put it on the stack
        }
    }
}
