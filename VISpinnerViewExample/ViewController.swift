//
//  ViewController.swift
//  VISpinnerViewExample
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit

import Spinner

class ViewController: UIViewController {

    private let button = UIButton()

    func buttonTouchUpInside(sender: UIButton) {
        let time = CFAbsoluteTimeGetCurrent()
        let timeString = String(describing: time)
        VISpinnerView.show(text: timeString, in: self.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitle("Hit me!", for: .normal)
        self.button.setTitleColor(UIColor.blue, for: .normal)
        self.button.addTarget(self, action: #selector(buttonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.button)

        self.setupConstraints()
    }

    private func setupConstraints() {
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}

