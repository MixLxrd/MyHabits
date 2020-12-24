//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 17.11.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    var delegate: UpdateCollectionViewProtocol?
    
    private let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
                                 date: Date(),
                                 color: .systemRed)
    
    
    
    private lazy var datepicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .wheels
        dp.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return dp
    }()
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        newHabit.date = datepicker.date
        habitTimeLabelTime.text = " \(dateFormatter.string(from: datepicker.date))"
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "НАЗВАНИЕ"
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
        label.text = "ЦВЕТ"
        label.font = .FootNoteBold
        return label
    }()
    
    private lazy var colorPickerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.roundCornerWithRadius(15, top: true, bottom: true, shadowEnabled: false)
        view.backgroundColor = newHabit.color
        let tapColor = UITapGestureRecognizer(target: self, action: #selector(tapColorPicker))
        view.addGestureRecognizer(tapColor)
        return view
    }()
    
    private lazy var colorPickerViewController: UIColorPickerViewController = {
        let cpvc = UIColorPickerViewController()
        cpvc.delegate = self
        return cpvc
    }()
    
    @objc func tapColorPicker() {
        present(colorPickerViewController, animated: true, completion: nil)
    }
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "ВРЕМЯ"
        label.font = .FootNoteBold
        return label
    }()
    
    private lazy var habitTimeLabelText: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        /*
         let templateAttributedText: NSMutableAttributedString = .init(string: "")
         templateAttributedText.append(.init(string: "Каждый день в", attributes: [.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black]))
         templateAttributedText.append(.init(string: " \(newHabit.date)", attributes: [.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.CustomPurple]))
         label.attributedText = templateAttributedText
         */
        label.text = "Каждый день в"
        return label
    }()
    private lazy var habitTimeLabelTime: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = " \(dateFormatter.string(from: datepicker.date))"
        label.tintColor = .CustomPurple
        label.textColor = .CustomPurple
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    @objc func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func actionSaveButton(_ sender: Any) {
        
        newHabit.name = nameTextField.text ?? ""
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        delegate?.reloadSlider()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        let navBar = UINavigationBar()
        navBar.toAutoLayout()
        view.addSubview(navBar)
        let const = [ navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                      navBar.heightAnchor.constraint(equalToConstant: 44),
                      navBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(const)
        let navItem = UINavigationItem()
        
        let leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionCancelButton))
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(actionSaveButton))
        leftBarButtonItem.tintColor = .CustomPurple
        rightBarButtonItem.tintColor = .CustomPurple
        navItem.rightBarButtonItem = rightBarButtonItem
        navItem.leftBarButtonItem = leftBarButtonItem
        navItem.title = "Создать"
        navBar.setItems([navItem], animated: true)
        navBar.backgroundColor = .systemGray
        
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorPickerView)
        view.addSubview(timeLabel)
        view.addSubview(habitTimeLabelText)
        view.addSubview(habitTimeLabelTime)
        view.addSubview(datepicker)
        datepicker.toAutoLayout()
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            
            colorPickerView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorPickerView.heightAnchor.constraint(equalToConstant: 30),
            colorPickerView.widthAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            habitTimeLabelText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            habitTimeLabelText.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            habitTimeLabelTime.topAnchor.constraint(equalTo: habitTimeLabelText.topAnchor),
            habitTimeLabelTime.leadingAnchor.constraint(equalTo: habitTimeLabelText.trailingAnchor),
            
            datepicker.topAnchor.constraint(equalTo: habitTimeLabelText.bottomAnchor, constant: 15),
            datepicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datepicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        newHabit.color = colorPickerViewController.selectedColor
        colorPickerView.backgroundColor = colorPickerViewController.selectedColor
    }
}

