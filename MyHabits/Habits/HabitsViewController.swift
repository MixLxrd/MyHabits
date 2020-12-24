//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 03.11.2020.
//

protocol UpdateCollectionViewProtocol {
    func reloadSlider()
}

import UIKit

class HabitsViewController: UIViewController, UpdateCollectionViewProtocol {
    
    private lazy var store = HabitsStore.shared
    
    lazy var habitsCollectionView: UICollectionView = {
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
    
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.sizeToFit()
        button.imageView?.tintColor = .CustomPurple
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return button
    } ()
    
    @objc func tapAddButton() {
        let vc = HabitViewController()
        vc.delegate = self
        //vc.modalPresentationStyle = .currentContext
        
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
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
        //HabitsStore.shared.habits.removeAll()
        habitsCollectionView.reloadData()
        setupLayout()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        habitsCollectionView.reloadData()
        setupLayout()
        navigationController?.navigationBar.isHidden = true
    }
    private func setupLayout() {
        view.addSubview(habitsCollectionView)
        view.addSubview(todayLabel)
        view.addSubview(addButton)
        habitsCollectionView.backgroundColor = .AlmostWhite
        let constraints = [
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            todayLabel.bottomAnchor.constraint(equalTo: habitsCollectionView.topAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func reloadSlider() {
        habitsCollectionView.reloadData()
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
            let cellProgress = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            cellProgress.setupUI()
            return cellProgress
        } else {
            let cellHabit = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            let habit = store.habits[indexPath.item]
            cellHabit.configure(habit: habit)
            cellHabit.didTapOnCell = { [weak self] in
                self?.habitsCollectionView.reloadData()
            }
            return cellHabit
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

