//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 25.12.2020.
//


protocol Callback {
    func callback() 
}

import UIKit

class HabitDetailsViewController: UIViewController {
    
    
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var habitTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.register(HabitDetailViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        setupLayout()
    }
    
    @objc func editButtonPressed(_ sender: Any) {
        
        let vc = HabitViewController()
        vc.newHabit = habit
        vc.currentLastVC = .editHabit
        vc.nameTextField.text = habit.name
        vc.colorPickerView.backgroundColor = habit.color
        vc.datepicker.date = habit.date
        vc.nameTextField.textColor = habit.color
        vc.delegate2 = self
        navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    private func setupLayout() {
        
        navigationController?.navigationBar.tintColor = .CustomPurple
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editButtonPressed))
        navigationItem.title = habit.name
        
        view.addSubview(habitTableView)
        let constraints = [
            habitTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countDates: Int = 0
        for date in HabitsStore.shared.dates {
            if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                countDates += 1
            }
        }
        return countDates
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailViewCell.self), for: indexPath) as! HabitDetailViewCell
        
        let storeDates: [Date] = HabitsStore.shared.dates.reversed()
        
        if HabitsStore.shared.habit(habit, isTrackedIn: storeDates[indexPath.row]) {
            cell.textLabel?.text = dateFormatter.string(from: storeDates[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HabitDetailsViewController: Callback {
    func callback() {
        navigationController?.popToRootViewController(animated: true)
    }
}
