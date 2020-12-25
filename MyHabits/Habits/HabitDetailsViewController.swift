//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 25.12.2020.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var habitTableView: UITableView = {
       let tableView = UITableView()
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
    
    @objc func actionEditButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout() {
        navigationController?.navigationItem.backBarButtonItem?.title = "Сегодня"
        navigationController?.navigationBar.tintColor = .CustomPurple
        
        view.addSubview(habitTableView)
        let constraints = [
            habitTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.trackDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailViewCell.self), for: indexPath) as! HabitDetailViewCell
        return cell
    }
    
    
}
