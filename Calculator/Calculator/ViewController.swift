//
//  ViewController.swift
//  Calculator
//
//  Created by Gyurme on 5/09/17.
//  Copyright © 2017 Gyurme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle
        {
            switch mathematicalSymbol {
            case "π" :
                displayValue = Double.pi
                break;
            case "√" :
                let operand = Double(display.text!)
                displayValue = sqrt(operand!)
                break
            default:
                break
            }
        }
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
}
