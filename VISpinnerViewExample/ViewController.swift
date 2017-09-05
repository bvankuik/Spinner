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

    private let spinnerShowButton = UIButton()
    private let spinnerHideButton = UIButton()
    private let simpleSpinnerShowButton = UIButton()
    private let simpleSpinnerHideButton = UIButton()
    private let toastViewButton = UIButton()
    private let topView = UIView()
    private let centerView = UIView()
    private let bottomView = UIView()
    private var spinnerText = "a"
    private let simpleSpinnerView = VISimpleSpinnerView()

    func spinnerShowButtonTouchUpInside(sender: UIButton) {
        self.spinnerText += "a"
        VISpinnerView.show(text: self.spinnerText, in: self.topView)
    }

    func spinnerHideButtonTouchUpInside(sender: UIButton) {
        VISpinnerView.hide()
    }

    func simpleSpinnerShowButtonTouchUpInside(sender: UIButton) {
        self.spinnerText += "a"
        self.simpleSpinnerView.show(text: self.spinnerText, in: self.centerView)
    }

    func simpleSpinnerHideButtonTouchUpInside(sender: UIButton) {
        self.simpleSpinnerView.hide()
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

        self.spinnerShowButton.translatesAutoresizingMaskIntoConstraints = false
        self.spinnerShowButton.setTitle("Show spinner", for: .normal)
        self.spinnerShowButton.setTitleColor(UIColor.blue, for: .normal)
        self.spinnerShowButton.addTarget(self, action: #selector(spinnerShowButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.spinnerShowButton)

        self.spinnerHideButton.translatesAutoresizingMaskIntoConstraints = false
        self.spinnerHideButton.setTitle("Hide spinner", for: .normal)
        self.spinnerHideButton.setTitleColor(UIColor.blue, for: .normal)
        self.spinnerHideButton.addTarget(self, action: #selector(spinnerHideButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.spinnerHideButton)
        
        self.simpleSpinnerShowButton.translatesAutoresizingMaskIntoConstraints = false
        self.simpleSpinnerShowButton.setTitle("Show simple spinner", for: .normal)
        self.simpleSpinnerShowButton.setTitleColor(UIColor.blue, for: .normal)
        self.simpleSpinnerShowButton.addTarget(self, action: #selector(simpleSpinnerShowButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.simpleSpinnerShowButton)

        self.simpleSpinnerHideButton.translatesAutoresizingMaskIntoConstraints = false
        self.simpleSpinnerHideButton.setTitle("Hide simple spinner", for: .normal)
        self.simpleSpinnerHideButton.setTitleColor(UIColor.blue, for: .normal)
        self.simpleSpinnerHideButton.addTarget(self, action: #selector(simpleSpinnerHideButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.simpleSpinnerHideButton)
        
        self.toastViewButton.translatesAutoresizingMaskIntoConstraints = false
        self.toastViewButton.setTitle("Show toast", for: .normal)
        self.toastViewButton.setTitleColor(UIColor.blue, for: .normal)
        self.toastViewButton.addTarget(self, action: #selector(toastViewButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(self.toastViewButton)

        self.toastViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.toastViewButton.bottomAnchor.constraint(equalTo: self.simpleSpinnerShowButton.topAnchor).isActive = true
        self.simpleSpinnerShowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.simpleSpinnerShowButton.bottomAnchor.constraint(equalTo: self.simpleSpinnerHideButton.topAnchor).isActive = true
        self.simpleSpinnerHideButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.simpleSpinnerHideButton.bottomAnchor.constraint(equalTo: self.spinnerShowButton.topAnchor).isActive = true
        self.spinnerShowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinnerShowButton.bottomAnchor.constraint(equalTo: self.spinnerHideButton.topAnchor).isActive = true
        self.spinnerHideButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinnerHideButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(self.topView)
        stackView.addArrangedSubview(self.centerView)
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

