//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Богдан Радченко on 23.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelValue()
        
        setTFValue()
        
        setSliderValue()

    }
    
    
    @IBAction func redSliderAction() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        redValueTF.text = String(format: "%.2f", redSlider.value)
    }
    
    @IBAction func greenSliderAction() {
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        greenValueTF.text = String(format: "%.2f", greenSlider.value)
    }
    
    @IBAction func blueSlideraction() {
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        blueValueTF.text = String(format: "%.2f", blueSlider.value)
    }
    

}

extension SettingsViewController {
    /*
    func definitionOf(color colorObject: UIColor) -> [String: CGFloat] {
        var colors: [String: CGFloat] = [: ]
        let color = CIColor(color: colorObject)
        let redColor = color.red
        let greenColor = color.green
        let blueColor = color.blue
        
        colors["red"] = redColor
        colors["green"] = greenColor
        colors["blue"] = blueColor
        
        return colors
    }
     */
    func definitionOf(color colorObject: UIColor) -> [CGFloat] {
        var colors: [CGFloat] = []
        let color = CIColor(color: colorObject)
        let redColor = color.red
        let greenColor = color.green
        let blueColor = color.blue
        
        colors.append(redColor)
        colors.append(greenColor)
        colors.append(blueColor)
        
        print(colors)
        
        return colors
    }
    
    func setLabelValue() {
        redValueLabel.text = String(format: "%.2f", definitionOf(color: colorView)[0])
        greenValueLabel.text = String(format: "%.2f", definitionOf(color: colorView)[1])
        blueValueLabel.text = String(format: "%.2f", definitionOf(color: colorView)[2])
    }
    
    func setTFValue() {
        redValueTF.text = String(format: "%.2f", definitionOf(color: colorView)[0])
        greenValueTF.text = String(format: "%.2f", definitionOf(color: colorView)[1])
        blueValueTF.text = String(format: "%.2f", definitionOf(color: colorView)[2])
    }
    
    func setSliderValue() {
        redSlider.value = Float(definitionOf(color: colorView)[0])
        greenSlider.value = Float(definitionOf(color: colorView)[1])
        blueSlider.value = Float(definitionOf(color: colorView)[2])
    }
    
    
    
}
