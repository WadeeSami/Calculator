//
//  CalculatorBrain.swift
//  CalculatorV2
//
//  Created by Wadee Sami on 10/6/17.
//  Copyright © 2017 Wadee AbuZant. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    enum symbolType{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operationMap  : [String: symbolType] = [
        "π" : symbolType.constant(Double.pi),
        "√" : symbolType.unaryOperation(sqrt),
        "cos" : symbolType.unaryOperation(cos),
        "+" : symbolType.binaryOperation({$0 + $1}),
        "-" : symbolType.binaryOperation({$0 - $1}),
        "*" : symbolType.binaryOperation({$0 * $1}),
        "/" : symbolType.binaryOperation({$0 / $1}),
        "=" : symbolType.equals
        
    ]
    private var accumulator: Double?
    
    mutating func setOperand(_ operand:Double) {
        self.accumulator = operand
    }
    
    mutating func setOperation(_ symbol:String) {
        if let operation = operationMap[symbol] {
            switch operation {
            case .constant(let val):
                
                accumulator = val
            case .unaryOperation(let op):
                accumulator = op(accumulator!)
            case .binaryOperation(let op):
                self.pendingBinaryOperation = PendingBinaryOperation(firstValue: accumulator!, operation: op)
            case .equals:
                self.performBinaryOperation(accumulator!)
            default:
                break
            }
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    struct PendingBinaryOperation {
        
        let firstValue: Double
        let operation : (Double,Double) -> Double
        
    }
    
    mutating private func performBinaryOperation(_ secondValue:Double){
        if self.pendingBinaryOperation != nil && secondValue != nil {
            let operation = self.pendingBinaryOperation!.operation
            accumulator = operation(pendingBinaryOperation!.firstValue, secondValue)
        }
    }
    
    // This value is optional, as accumulator is options and we do want the result to be optional
    var result : Double?{
        get{
            return self.accumulator
        }
    }
}
