//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Богдан Радченко on 23.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setNewBackgroundColor(from color: UIColor)
}

final class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.colorView = view.backgroundColor
        settingVC.delegate = self
    }
}

extension StartViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(from color: UIColor) {
        view.backgroundColor = color
    }
}

