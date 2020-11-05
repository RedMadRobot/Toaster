//
//  NotificationView.swift
//  Toaster
//
//  Created by Andrei Nedov on 25/09/2019.
//

import UIKit

final class NotificationView: UIView {
    
    
    // MARK: - Private Properties
    public var isBlurView: Bool
    
    private lazy var roundCornersView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///Лейбл текста в нотификации
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 16)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textColor = .white
        textLabel.accessibilityIdentifier = "notification_text"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    
    // MARK: - Initializers
    
    init(type: UINotificationFeedbackGenerator.FeedbackType,
         color: UIColor?,
         text: String) {
        
        self.isBlurView = color == nil
        super.init(frame: .zero)

        self.commonInit()
        self.textLabel.text = text
        
        if isEdgeToEdgeEnabled {
            backgroundColor = color == nil ? .clear : color
        } else {
            roundCornersView.backgroundColor = color
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        accessibilityIdentifier = "notification_view"
        
        ///В стандартной реализации есть отображение нотификации с цветами в зависимости от DefaultFeedbackType или темный блюр
        if isBlurView {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(blurView)
            NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: blurView.topAnchor),
            self.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: blurView.leadingAnchor)])

            blurView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 16, right: 24)
            
            let topAnchor = textLabel.topAnchor.constraint(equalTo: blurView.layoutMarginsGuide.topAnchor)
            topAnchor.priority = .defaultHigh
            blurView.contentView.addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                topAnchor,
                textLabel.topAnchor.constraint(greaterThanOrEqualTo: blurView.topAnchor, constant: 16),
                textLabel.bottomAnchor.constraint(equalTo: blurView.layoutMarginsGuide.bottomAnchor),
                textLabel.leadingAnchor.constraint(equalTo: blurView.layoutMarginsGuide.leadingAnchor),
                textLabel.trailingAnchor.constraint(equalTo: blurView.layoutMarginsGuide.trailingAnchor)])

        } else if isEdgeToEdgeEnabled {
            addSubview(textLabel)
            
            NSLayoutConstraint.activate([
                textLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                textLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
                textLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                textLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)])
        } else {
            addSubview(roundCornersView)
            
            roundCornersView.addSubview(textLabel)
            
            NSLayoutConstraint.activate([
                textLabel.topAnchor.constraint(equalTo: roundCornersView.topAnchor, constant: 16),
                textLabel.bottomAnchor.constraint(equalTo: roundCornersView.bottomAnchor, constant: -12),
                textLabel.leadingAnchor.constraint(equalTo: roundCornersView.leadingAnchor, constant: 16),
                textLabel.trailingAnchor.constraint(equalTo: roundCornersView.trailingAnchor, constant: -16),
                
                roundCornersView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
                roundCornersView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
                roundCornersView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
                roundCornersView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}
