//
//  ViewController.swift
//  demiurg
//
//  Created by Beymamat Rakhmatov on 13.08.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellManager = MainModelManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavTitle()
        configureTableView()
        createButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupGradientBackground(firstColor: UIColor.black.cgColor,
                                     secongColor: UIColor(named: "mainPurple")!.cgColor)
    }
    
    private func configureNavTitle() {
        title = "Клеточное наполнение"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 32)
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainLightPurple")
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }
    
    private func createButton() {
        let createButton = UIButton(type: .system)
        createButton.setTitle("СОТВОРИТЬ", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = UIColor(named: "mainLightPurple")
        createButton.layer.cornerRadius = 8
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createButton.addTarget(self, action: #selector(addCell), for: .touchUpInside)

        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    
    @objc private func addCell() {
        cellManager.addCell()
        let indexPath = IndexPath(row: cellManager.cells.count - 1, section: 0)
        tableView.performBatchUpdates({
            tableView.insertRows(at: [indexPath], with: .automatic)
        }, completion: { _ in
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        })
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellManager.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainViewTableViewCell
        
        let item = cellManager.cells[indexPath.row]
        cell.configure(model: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

extension ViewController {
    func setupGradientBackground(firstColor: CGColor, secongColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            firstColor,
            secongColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
