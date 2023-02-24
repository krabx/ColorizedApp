//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Богдан Радченко on 23.02.2023.
//

import UIKit

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.colorView = view.backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}

