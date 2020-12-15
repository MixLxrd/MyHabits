//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 03.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var store = HabitsStore.shared
    
    
    lazy var habitsCollecionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    @IBOutlet var testButton: UIButton!
    
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitsCollecionView.reloadData()
        
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        habitsCollecionView.reloadData()
        
    }
    
    
    private func setupLayout() {
        view.addSubview(habitsCollecionView)
        //view.addSubview(createHabitButton)
        view.addSubview(todayLabel)
        testButton.toAutoLayout()
        habitsCollecionView.backgroundColor = .lightGray
        let constraints = [

            testButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            testButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            habitsCollecionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            habitsCollecionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollecionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollecionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            todayLabel.bottomAnchor.constraint(equalTo: habitsCollecionView.topAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func actionTestButton(_ sender: Any) {
        
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return store.habits.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            
            cell.delegate = self
            
            let habit = store.habits[indexPath.item]
            cell.configure(habit: habit)
            
            return cell
        }
        
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: (UIScreen.main.bounds.width - 32), height: 60)
        }
        else {
            return .init(width: (UIScreen.main.bounds.width - 32), height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 6, right: 16)
            
        }
        else {
            return UIEdgeInsets(top: 18, left: 16, bottom: 12, right: 16)
        }
        
    }
    
    
}

extension HabitsViewController: MyCollectionViewCellDelegate {
    func refreshSmth() {
        
        habitsCollecionView.reloadData()
        
    }
    
}
