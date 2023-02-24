//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Богдан Радченко on 23.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var viewColor: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    var colorView: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    var currentColor: UIColor!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.keyboardType = .decimalPad
        
        setLabelValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setTFValue(for: redValueTF, greenValueTF, blueValueTF)
        setSliderValue(for: redSlider, greenSlider, blueSlider)
        
        setViewColor()

    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        setViewColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider.value)
            redValueTF.text = string(from: redSlider.value)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider.value)
            greenValueTF.text = string(from: greenSlider.value)
        default:
            blueValueLabel.text = string(from: blueSlider.value)
            blueValueTF.text = string(from: blueSlider.value)
        }
    }
    
    
    @IBAction func doneButtonPressed() {
        currentColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        delegate.setNewBackgroundColor(from: currentColor)
        dismiss(animated: true)
    }
}

private extension SettingsViewController {

    func definitionOf(color colorObject: UIColor) -> [Float] {
        var colors: [Float] = []
        let color = CIColor(color: colorObject)
        let redColor = color.red
        let greenColor = color.green
        let blueColor = color.blue
        
        colors.append(Float(redColor))
        colors.append(Float(greenColor))
        colors.append(Float(blueColor))
        
        return colors
    }
    
    func string(from color: Float) -> String {
        String(format: "%.2f", color)
    }
    
    func setLabelValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: definitionOf(color: colorView)[0])
            case greenValueLabel:
                greenValueLabel.text = string(from: definitionOf(color: colorView)[1])
            default:
                blueValueLabel.text = string(from: definitionOf(color: colorView)[2])
            }
        }
    }
    
    func setTFValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF:
                redValueTF.text = string(from: definitionOf(color: colorView)[0])
            case greenValueTF:
                greenValueTF.text = string(from: definitionOf(color: colorView)[1])
            default:
                blueValueTF.text = string(from: definitionOf(color: colorView)[2])
            }
        }
    }
    
    func setSliderValue(for sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = definitionOf(color: colorView)[0]
            case greenSlider:
                greenSlider.value = definitionOf(color: colorView)[1]
            default:
                blueSlider.value = definitionOf(color: colorView)[2]
            }
        }
    }
    
    func setViewColor() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
}
