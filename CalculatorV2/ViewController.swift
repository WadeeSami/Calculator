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
    @IBAction func performOperation(_ sender: UIButton) {
        userInTheMiddleOfTyping = false
        if let operation = sender.currentTitle {
            
            switch operation {
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
    
}

