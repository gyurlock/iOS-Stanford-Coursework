//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Gyurme on 7/09/17.
//  Copyright © 2017 Gyurme. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}

func multiply(first: Double, second: Double) -> Double {
    return first * second
}

struct CalculatorBrain : CustomStringConvertible {
    
    private var accumulator: Double?
    
    mutating func addOperation(named symbol:String, _ operation: @escaping (Double) -> Double) {
        operations[symbol] = Operation.unaryOperation(operation)
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations : Dictionary<String, Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "e" : Operation.constant(M_E),
            "√" : Operation.unaryOperation(sqrt),
            "cos" : Operation.unaryOperation(cos),
            "±": Operation.unaryOperation({-$0}),
            "×": Operation.binaryOperation({$0 * $1}),
            "÷": Operation.binaryOperation({$0 / $1}),
            "+": Operation.binaryOperation({$0 + $1}),
            "-": Operation.binaryOperation({$0 - $1}),
            "=": Operation.equals
            
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value) :
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function) :
                
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
                break
            }
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
   mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand;
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    public var description: String { return "A Brain" }

    
}
