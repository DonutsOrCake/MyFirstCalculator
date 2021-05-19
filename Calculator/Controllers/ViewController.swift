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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }
    
    //MARK: - Properties
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NULL

    
    //MARK: - Functions and Methods
    func setupViews() {
        let subStackView1 = setupRows(array: Button.buttonRow1)
        let subStackView2 = setupRows(array: Button.buttonRow2)
        let subStackView3 = setupRows(array: Button.buttonRow3)
        let subStackView4 = setupRows(array: Button.buttonRow4)
        let subStackView5 = setupRows(array: Button.buttonRow5)
        
        let stackView = UIStackView(arrangedSubviews: [inputTextView, subStackView1, subStackView2, subStackView3, subStackView4, subStackView5])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
//        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: CGFloat(350)).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: CGFloat(450)).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    @objc func numberButtonTapped(_ sender: UIButton!) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.titleLabel!.text!)"
            inputTextView.text = runningNumber
        }
    }
    
    @objc func allClearButtonTapped(_ sender: UIButton!) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        inputTextView.text = "0"
    }
    
    @objc func dotButtonTapped(_ sender: UIButton!) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            inputTextView.text = runningNumber
        }
    }
    
    @objc func equalsButtonTapped(_ sender: UIButton!) {
        operation(operation: currentOperation)
    }
    
    @objc func addButtonTapped(_ sender: UIButton!) {
        operation(operation: .Add)
    }
    
    @objc func subtractButtonTapped(_ sender: UIButton!) {
        operation(operation: .Subtract)
    }
    
    @objc func multiplyButtonTapped(_ sender: UIButton!) {
        operation(operation: .Multiply)
    }
    
    @objc func divideButtonTapped(_ sender: UIButton!) {
        operation(operation: .Divide)
    }
    
    func operation(operation: Operation) {
        
        if currentOperation != .NULL {
            
            if runningNumber != "" {
                
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add && leftValue != "" {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                    
                } else if currentOperation == .Subtract && leftValue != "" {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                    
                } else if currentOperation == .Multiply && leftValue != "" {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                    
                } else if currentOperation == .Divide && leftValue != "" {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                    
                }
                print("Result: \(result)")
                
                leftValue = result
                
                if (result != "" && Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                inputTextView.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    //MARK: - Views
    let inputTextView: UILabel = {
        let textView = UILabel()
        textView.text = "0"
        textView.textAlignment = .right
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.black
        textView.frame.size = CGSize(width: 70, height: 80)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func setupRows(array: Dictionary<Int, Array<Any>>) -> UIStackView {
        var buttonArray = [UIButton]()
        var width = 0
        let sortedArray = array.sorted(by: {$0.key < $1.key})
        var alphaValue = 0.4
        
        for (key, value) in sortedArray {
            if array.count == 2 && key == 1 {
                width = 260
                alphaValue = 1.0
            } else if array.count == 3 && key == 15 {
                width = 165
            } else {
                width = 80
            }
            
            if key == 2 || key == 6 || key == 10 || key == 14 || key == 17 {
                alphaValue = 1
            }
            
            let button = UIButton()
            button.backgroundColor = (value[1] as? UIColor)?.withAlphaComponent(CGFloat(alphaValue))
            button.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
            button.heightAnchor.constraint(equalToConstant: CGFloat(80)).isActive = true
            button.layer.cornerRadius = CGFloat(0.4 * Double(80))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            
            if String(describing: value[0]) == "AC" {
                button.addTarget(self, action: #selector(allClearButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "/" {
                button.addTarget(self, action: #selector(divideButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "+" {
                button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "-" {
                button.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "*" {
                button.addTarget(self, action: #selector(multiplyButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "." {
                button.addTarget(self, action: #selector(dotButtonTapped), for: .touchUpInside)
                
            }else if String(describing: value[0]) == "=" {
                button.addTarget(self, action: #selector(equalsButtonTapped), for: .touchUpInside)
                
            }else {
                button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
            }
            
            button.setTitle(String(describing: value[0]), for: .normal)
            buttonArray += [button]
        }
        
        let subStackView = UIStackView(arrangedSubviews: buttonArray)
        subStackView.axis = .horizontal
        subStackView.distribution = .equalSpacing
        subStackView.alignment = .fill
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.spacing = 5
        return subStackView
    }
}//End class
