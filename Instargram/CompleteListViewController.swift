//
//  CompleteListViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//

import UIKit
import SnapKit
import Then

class CompleteListViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    private let completedListTableView = UITableView()
    private var completeLists: [CompleteList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completedListTableView.register(CompleteListTableViewCell.self, forCellReuseIdentifier: "CompleteCell")

        view.backgroundColor = .white
        
        setUpUI()
        
        completedListTableView.delegate = self
        completedListTableView.dataSource = self
        
        completeLists = dataManager.loadCompleteList()
        
        navigationItem.title = "CompleteList"
        navigationController?.navigationBar.titleTextAttributes = [
            
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func setUpUI() {
        view.addSubview(completedListTableView)
        
        completedListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
extension CompleteListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 70
        return completeLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! CompleteListTableViewCell
        
        let completedItem = completeLists[indexPath.row]
        
        cell.titleLabel.text = completedItem.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd HH:mm"
        if let date = completedItem.date {
            let formattedDate = dateFormatter.string(from: date)
            cell.dateLabel.text = formattedDate
        } else {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
}
