//
//  ViewController.swift
//  CalculatorV2
//
//  Created by Wadee Sami on 10/2/17.
//  Copyright © 2017 Wadee AbuZant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTyping = false
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text =  digit
            userInTheMiddleOfTyping = true
        }
    }
    
    
    var displayValue: Double{
        
        get{
            return Double(display.text!)!
        }
        
        set{
            display.text = String(newValue)
        }
    }
    
    private var calculatorBrain = CalculatorBrain()
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userInTheMiddleOfTyping{
            calculatorBrain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        if let operation = sender.currentTitle {
            calculatorBrain.setOperation(operation)
        }
        
        if let result = calculatorBrain.result {
            displayValue = result
        }
    }
    
}











