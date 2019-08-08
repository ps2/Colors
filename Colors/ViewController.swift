//
//  ViewController.swift
//  Colors
//
//  Created by Pete Schwamb on 8/8/19.
//  Copyright © 2019 Pete Schwamb. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .blue
        stackView.spacing = UIStackView.spacingUseSystem

        let pluginManager = PluginManager.init()

        for plugin in pluginManager.availablePlugins {
            os_log("Found plugin %@", plugin.name)
            os_log("Class = %@", String(describing: plugin.bundle.principalClass))
            if let pluginClass = plugin.bundle.principalClass as? NSObject.Type {
                let instance = pluginClass.init()
                os_log("Instance = %@", String(describing: instance))

                let label = UILabel()
                label.text = String(format: "%@: %@", plugin.name, String(describing: instance))
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(label)
            }
        }
    }
}

