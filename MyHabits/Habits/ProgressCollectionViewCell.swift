//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 28.11.2020.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameHabit: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        label.text = "Все получится!"
        label.font = .FootNoteStatus
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var habitSlider: UISlider = {
        let slider = UISlider()
        slider.toAutoLayout()
        slider.isEnabled = false
        slider.setThumbImage(nil, for: .normal)
        
        slider.setValue(HabitsStore.shared.todayProgress, animated: true)
        slider.tintColor = .CustomPurple
        
        
        return slider
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .FootNote
        label.textColor = .systemGray
        label.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.roundCornerWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        contentView.addSubview(nameHabit)
        contentView.backgroundColor = .white
        contentView.addSubview(habitSlider)
        contentView.addSubview(statusLabel)
        
        let constraints = [
            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            habitSlider.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 10),
            habitSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            habitSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            habitSlider.heightAnchor.constraint(equalToConstant: 7),
            habitSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            statusLabel.topAnchor.constraint(equalTo: nameHabit.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: habitSlider.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
