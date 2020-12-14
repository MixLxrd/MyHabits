//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 17.11.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    let habitsVC = HabitsViewController()
    
    private let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
                         date: Date(),
                         color: .systemRed)
    
    
    
    
    @IBAction func actionCancelButton(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSaveButton(_ sender: Any) {
        newHabit.name = nameTextField.text ?? ""
        
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        dismiss(animated: true, completion: nil)
        habitsVC.habitsCollecionView.reloadData()
    }
    
    let habitHeaderView = HabitHeaderView()
    
    
    
    private lazy var datepicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .wheels
        dp.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return dp
    }()
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        newHabit.date = datepicker.date
        habitTimeLabel.text = "\(newHabit.dateString)"
        
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
    
    private lazy var habitTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "\(newHabit.dateString)"
        label.font = .FootNoteBold
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    private func setupLayout() {
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        //view.addSubview(colorWell)
        view.addSubview(colorPickerView)
        view.addSubview(timeLabel)
        view.addSubview(habitTimeLabel)
        view.addSubview(datepicker)
        datepicker.toAutoLayout()
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
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
            /*
             
             colorWell.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
             colorWell.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
             colorWell.heightAnchor.constraint(equalToConstant: 30),
             colorWell.widthAnchor.constraint(equalToConstant: 30),
             */
            
            timeLabel.topAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            habitTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            habitTimeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            datepicker.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 15),
            datepicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datepicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    /*
     private lazy var colorWell: UIColorWell = {
     let color = UIColorWell(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
     color.toAutoLayout()
     color.addTarget(self, action: #selector(colorWellValueChanged(_:)), for: .valueChanged)
     return color
     }()
     
     
     @objc func colorWellValueChanged(_ sender: Any) {
     colorWell.backgroundColor = colorWell.selectedColor
     }
     */
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        newHabit.color = colorPickerViewController.selectedColor
        colorPickerView.backgroundColor = colorPickerViewController.selectedColor
    }
}


