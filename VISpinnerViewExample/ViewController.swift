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

    private let spinnerButton = UIButton()
    private let toastViewButton = UIButton()

    func spinnerButtonTouchUpInside(sender: UIButton) {
        let time = CFAbsoluteTimeGetCurrent()
        let timeString = String(describing: time)
        VISpinnerView.show(text: timeString, in: self.view)
    }

    func toastViewButtonTouchUpInside(sender: UIButton) {
        let time = CFAbsoluteTimeGetCurrent()
        let timeString = String(describing: time)
        VIToastView.show(text: timeString, in: self.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.spinnerButton.translatesAutoresizingMaskIntoConstraints = false
        self.spinnerButton.setTitle("Show spinner", for: .normal)
        self.spinnerButton.setTitleColor(UIColor.blue, for: .normal)
        self.spinnerButton.addTarget(self, action: #selector(spinnerButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.spinnerButton)

        self.toastViewButton.translatesAutoresizingMaskIntoConstraints = false
        self.toastViewButton.setTitle("Show toast", for: .normal)
        self.toastViewButton.setTitleColor(UIColor.blue, for: .normal)
        self.toastViewButton.addTarget(self, action: #selector(toastViewButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.toastViewButton)

        self.setupConstraints()
    }

    private func setupConstraints() {
        self.spinnerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinnerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.toastViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.toastViewButton.bottomAnchor.constraint(equalTo: self.spinnerButton.topAnchor).isActive = true
    }

}

