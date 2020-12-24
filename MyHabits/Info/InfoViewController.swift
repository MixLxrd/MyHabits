//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Михаил Ильченко on 03.11.2020.
//

import UIKit

class InfoViewController: UIViewController, UIScrollViewDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .Title3
        label.numberOfLines = 1
        label.text = InfoAboutHabits.label
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = .Body
        label.numberOfLines = 0
        label.text = InfoAboutHabits.information
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Информация"
        setupLayout()
    }
    
    private func setupLayout() {
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(informationLabel)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            informationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            informationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            informationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            informationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
