//
//  HabitHeaderView.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 25.11.2020.
//

import UIKit

class HabitHeaderView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Название"
        label.font = .FootNoteBold
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = .FootNote
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Цвет"
        label.font = .FootNoteBold
        return label
    }()
    
    private lazy var colorPickerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.roundCornerWithRadius(15)
        view.backgroundColor = .CustomOrange
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Время"
        label.font = .FootNoteBold
        return label
    }()
    
    private lazy var habitTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Каждый день в "
        label.font = .FootNoteBold
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(colorLabel)
        addSubview(colorPickerView)
        addSubview(timeLabel)
        addSubview(habitTimeLabel)
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorPickerView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerView.heightAnchor.constraint(equalToConstant: 30),
            colorPickerView.widthAnchor.constraint(equalToConstant: 30),
            colorPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            habitTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            habitTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            habitTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            habitTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
