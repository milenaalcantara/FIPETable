//
//  DetailCell.swift
//  FIPETable
//
//  Created by Milena Lima de Alcântara on 23/10/22.
//

import UIKit

class DetailCell: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayoutView()
    }
}

extension DetailCell: SettingsView {
    func setupSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            self.valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}

/*
 import UIKit
 import SwiftUI

 final class SportsDetailAboutView: UIView {

     
     lazy var sportDescriptionLabel: UILabel = {
         let label = UILabel()
         label.text = "Field hockey is a team game of the hockey family. The earliest origins."
         label.numberOfLines = 0
         label.textColor = UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1)
         label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     override func layoutSubviews() {
         super.layoutSubviews()
         self.buildLayout()

     }

 }

 extension SportsDetailAboutView: ViewCoding {

     func setupView() {
         self.backgroundColor = .clear
     }

     func setupHierarchy() {
         self.addSubview(sportAboutLabel)
         self.addSubview(sportGreenIcon)
         self.addSubview(sportFormatLabel)
         self.addSubview(sportDescriptionLabel)
     }

     func setupConstraints() {
         NSLayoutConstraint.activate([
             self.sportAboutLabel.topAnchor.constraint(equalTo: self.topAnchor),
             self.sportAboutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             self.sportAboutLabel.widthAnchor.constraint(equalToConstant: 153),
             self.sportAboutLabel.heightAnchor.constraint(equalToConstant: 27),

             self.sportGreenIcon.centerYAnchor.constraint(equalTo: sportAboutLabel.centerYAnchor),
             self.sportGreenIcon.leadingAnchor.constraint(equalTo: sportAboutLabel.trailingAnchor, constant: 6),
             self.sportGreenIcon.heightAnchor.constraint(equalToConstant: 17),
             self.sportGreenIcon.widthAnchor.constraint(equalToConstant: 17),

             self.sportFormatLabel.topAnchor.constraint(equalTo: sportAboutLabel.bottomAnchor),
             self.sportFormatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             self.sportFormatLabel.heightAnchor.constraint(equalToConstant: 19),

             self.sportDescriptionLabel.topAnchor.constraint(equalTo: sportFormatLabel.bottomAnchor, constant: 19),
             self.sportDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             self.sportDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             self.sportDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)

         ])
     }

 }

 */
