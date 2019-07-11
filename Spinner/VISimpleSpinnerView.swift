//
//  VISimpleSpinnerView.swift
//  Spinner
//
//  Created by Bart van Kuik on 05/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit


public class VISimpleSpinnerView: UIView {

    internal let label = UILabel()
    private let stackView = UIStackView()
    private let activityIndicatorView: UIActivityIndicatorView
    private var constraintsInstalled = false
    private let minimumDimension: CGFloat = 150.0
    private let margin: CGFloat = 20.0

    // MARK: - Public functions

    public func show(text: String, in containingView: UIView) {
        self.label.text = text

        self.centerView(in: containingView)
        self.isHidden = false
    }

    public func hide() {
        self.isHidden = true
    }

    // MARK: - Private functions

    private func centerView(in containingView: UIView) {
        if containingView != self.superview {
            self.removeFromSuperview()
            containingView.addSubview(self)
            let constraints = [
                self.centerXAnchor.constraint(equalTo: containingView.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: containingView.centerYAnchor),
                self.widthAnchor.constraint(lessThanOrEqualTo: containingView.widthAnchor, multiplier: 1.0, constant: -10)
            ]
            containingView.addConstraints(constraints)
        }

        containingView.bringSubviewToFront(self)
    }

    // MARK: - Layout

    override public func layoutSubviews() {
        if !self.constraintsInstalled {
            self.constraintsInstalled = true

            let constraints = [
                self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.margin),
                self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.margin),
                self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.margin),
                self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.margin),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
                ]
            self.addConstraints(constraints)
        }

        super.layoutSubviews()
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.lineBreakMode = .byTruncatingTail
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.startAnimating()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = self.margin
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(label)

        super.init(frame: frame)
        self.addSubview(stackView)
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 5.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
}

