//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 28.11.2020.
//

import UIKit


class HabitCollectionViewCell: UICollectionViewCell {
    
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком",
                      date: Date(),
                      color: .systemRed)
    
    private lazy var nameHabitLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .HeadLine
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .FootNote
        label.toAutoLayout()
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var trackerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .Caption
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.roundCornerWithRadius(18, top: true, bottom: true, shadowEnabled: false)
        button.toAutoLayout()
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checkBoxButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func checkBoxButtonPressed() {
        if habit.isAlreadyTakenToday {
            print("Привычка")
        } else {
            HabitsStore.shared.track(habit)
            checkBoxButton.backgroundColor = habit.color
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.roundCornerWithRadius(6, top: true, bottom: true, shadowEnabled: true)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func configure(habit: Habit) {
        self.habit = habit
        nameHabitLabel.textColor = self.habit.color
        nameHabitLabel.text = self.habit.name
        dateLabel.text = self.habit.dateString
        trackerLabel.text = "Подряд: \(Int.random(in: 0...10))"
        checkBoxButton.layer.borderColor = habit.color.cgColor
        
        
        if habit.isAlreadyTakenToday {
            checkBoxButton.backgroundColor = habit.color
        } else {
            checkBoxButton.backgroundColor = .white
        }
         
    }
    
    private func setupLayout() {
        contentView.addSubview(nameHabitLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(trackerLabel)
        contentView.addSubview(checkBoxButton)
        contentView.backgroundColor = .white
        let constraints = [
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: nameHabitLabel.leadingAnchor),
            
            trackerLabel.leadingAnchor.constraint(equalTo: nameHabitLabel.leadingAnchor),
            trackerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 36),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 36),
            checkBoxButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
