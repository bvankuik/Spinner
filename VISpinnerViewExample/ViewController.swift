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
    private let topView = UIView()
    private let bottomView = UIView()

    func spinnerButtonTouchUpInside(sender: UIButton) {
        let time = CFAbsoluteTimeGetCurrent()
        let timeString = String(describing: time)
        VISpinnerView.show(text: timeString, in: self.topView)
    }

    func toastViewButtonTouchUpInside(sender: UIButton) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let timeString = dateFormat.string(from: Date())
        VIToastView.show(text: timeString, in: self.bottomView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.96, alpha: 1.0)

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

        self.spinnerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinnerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.toastViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.toastViewButton.bottomAnchor.constraint(equalTo: self.spinnerButton.topAnchor).isActive = true

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(self.topView)
        stackView.addArrangedSubview(self.bottomView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.toastViewButton.topAnchor).isActive = true

    }

}

