//
//  MainViewTableViewCell.swift
//  demiurg
//
//  Created by Beymamat Rakhmatov on 14.08.24.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {
    
    private let emojiView = UIView()
    private let emojiLabel = UILabel()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let cellStackView = UIStackView()
    
    private var viewState: MainModelState = .alive
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientBackground()
        emojiView.layer.cornerRadius = 20

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        cellStackView.layer.cornerRadius = 8
        clipsToBounds = true
        
        emojiLabel.font = UIFont.systemFont(ofSize: 22)
        emojiLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiView.addSubview(emojiLabel)
        emojiView.layer.cornerRadius = 20
        emojiView.clipsToBounds = true
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = .gray
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        
        cellStackView.axis = .horizontal
        cellStackView.spacing = 16
        cellStackView.alignment = .center
        cellStackView.addArrangedSubview(emojiView)
        cellStackView.addArrangedSubview(textStackView)
        cellStackView.backgroundColor = .white
        cellStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        cellStackView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(cellStackView)
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            emojiView.widthAnchor.constraint(equalToConstant: 40),
            emojiView.heightAnchor.constraint(equalToConstant: 40),
            
            emojiLabel.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor)
        ])
    }
    
    func configure(model: MainModel) {
        titleLabel.text = model.text
        detailLabel.text = model.detailText
        emojiLabel.text = model.emoji
        viewState = model.state
        
        updateGradientBackground()
    }
    
    private func updateGradientBackground() {
        emojiView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = emojiView.bounds
        gradientLayer.colors = viewState == .alive
        ? [UIColor(named:"aliveViewStartColor")!.cgColor, UIColor(named:"aliveViewEndColor")!.cgColor]
        : [UIColor(named:"deadViewStartColor")!.cgColor, UIColor(named: "deadViewEndColor")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        emojiView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
