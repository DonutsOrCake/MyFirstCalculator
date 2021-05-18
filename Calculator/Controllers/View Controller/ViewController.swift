//
//  ViewController.swift
//  Calculator
//
//  Created by Bryson Jones on 5/17/21.
//

import UIKit

enum Operation: String {
    
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    case NULL = "Null"
}

class ViewController: UIViewController {

    //MARK: - Properties
    var runningNumber = ""
    var result = ""
    var currentOperation: Operation = .NULL
    var rightValue = ""
    var leftValue = ""
    
    //MARK: - Outlets
    @IBOutlet weak var outputLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
    }
    
    //MARK: - Actions
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        
        if runningNumber.count <= 9 {
            
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    
    @IBAction func dotButtonTapped(_ sender: roundButton) {
        if runningNumber.count <= 8 {
            runningNumber += "."
            outputLabel.text = runningNumber
        }
    }
    
    @IBAction func allClearButtonTapped(_ sender: roundButton) {
        outputLabel.text = "0"
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        currentOperation = .NULL
    }
    
    @IBAction func equalsButtonTapped(_ sender: roundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func plusButtonTapped(_ sender: roundButton) {
        operation(operation: .Add)
    }
    
    @IBAction func minusButtonTapped(_ sender: roundButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: roundButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func divideButtonTapped(_ sender: roundButton) {
        operation(operation: .Divide)
    }
    
    //MARK: - Functions
    func operation(operation: Operation) {
        
        if currentOperation != .NULL {
            
            if runningNumber != "" {
                
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                    
                } else if currentOperation == .Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                    
                } else if currentOperation == .Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                    
                } else if currentOperation == .Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                    
                }
                
                leftValue = result
                
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}//End class
