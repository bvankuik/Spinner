//
//  VIToastView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//


public class VIToastView: VIStatusBaseView {

    static let shared = VIToastView()

    private let label = UILabel()
    private var constraintsInstalled = false
    private let minimumHeight: CGFloat = 50.0
    private let minimumWidth: CGFloat = 150.0
    private let margin: CGFloat = 20.0

    // MARK: - Public functions

    public static func show(text: String, in containingView: UIView) {
        let toastView = VIToastView.shared
        toastView.label.text = text

        VIStatusBaseView.showBaseView(baseView: toastView, in: containingView)
    }
    // MARK: - Layout

    override public func layoutSubviews() {
        if !self.constraintsInstalled {
            self.constraintsInstalled = true

            let constraints = [
                self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minimumWidth),
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumHeight),
                self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.margin),
                self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.margin),
                self.heightAnchor.constraint(greaterThanOrEqualTo: self.label.heightAnchor, multiplier: 1.0, constant: self.margin)
            ]
            self.addConstraints(constraints)
        }

        super.layoutSubviews()
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        super.init(frame: frame)
        self.addSubview(label)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
}
