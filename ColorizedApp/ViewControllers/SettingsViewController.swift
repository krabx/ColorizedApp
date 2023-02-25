//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Богдан Радченко on 23.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        setToolBar()
        setStartValue()
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
        guard let currentColor = viewColor.backgroundColor else { return }
        delegate.setNewBackgroundColor(from: currentColor)
        dismiss(animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    private func definitionOf(color colorObject: UIColor) -> [Float] {
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
    
    private func string(from color: Float) -> String {
        String(format: "%.2f", color)
    }
    
    private func setSliderValue(for sliders: UISlider...) {
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
    
    private func setLabelValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: redSlider.value)
            case greenValueLabel:
                greenValueLabel.text = string(from: greenSlider.value)
            default:
                blueValueLabel.text = string(from: blueSlider.value)
            }
        }
    }
    
    private func setTFValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF:
                redValueTF.text = string(from: redSlider.value)
            case greenValueTF:
                greenValueTF.text = string(from: greenSlider.value)
            default:
                blueValueTF.text = string(from: blueSlider.value)
            }
        }
    }
    
    private func setViewColor() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setStartValue() {
        setSliderValue(for: redSlider, greenSlider, blueSlider)
        setLabelValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setTFValue(for: redValueTF, greenValueTF, blueValueTF)
        setViewColor()
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let doneKeyboardButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneKeyboardPressed))
        toolBar.items = [flexibleSpace, doneKeyboardButton]
        
        redValueTF.inputAccessoryView = toolBar
        greenValueTF.inputAccessoryView = toolBar
        blueValueTF.inputAccessoryView = toolBar
    }
    
    @objc private func doneKeyboardPressed() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let defaultSliderValue: Float = 1
        
        guard let textFieldText = textField.text else { return }
        
        if let textFieldFloat = Float(textFieldText) {
            refreshSliderValue(from: textField, textFieldFloat)
            
        } else {
            showAlert(
                withTitle: "Warning",
                andMessage: "You entered an invalid value. The field should not contain letters and value must be between 0 and 1.",
                textField: textField,
                sliderValue: defaultSliderValue
            )
            refreshSliderValue(from: textField, defaultSliderValue)
        }
        
        func refreshSliderValue(from textField: UITextField, _ sliderValue: Float) {
            switch textField {
            case redValueTF:
                redSlider.setValue(sliderValue, animated: true)
            case greenValueTF:
                greenSlider.setValue(sliderValue, animated: true)
            default:
                blueSlider.setValue(sliderValue, animated: true)
            }
        }
        
        setLabelValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setViewColor()
    }
    
    
    private func showAlert(withTitle: String, andMessage: String, textField: UITextField, sliderValue: Float) {
        let alert = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = String(format: "%.2f", sliderValue)
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
