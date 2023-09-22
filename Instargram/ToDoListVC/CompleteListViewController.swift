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
    private var sectionCompleteLists: [Section: [CompleteList]] = [:]

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
        
        Section.allCases.forEach { section in
            let listsInSection = completeLists.filter { $0.section == section.rawValue }
            sectionCompleteLists[section] = listsInSection
        }
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
        let section = Section.allCases[section]
        return sectionCompleteLists[section]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! CompleteListTableViewCell

        let section = Section.allCases[indexPath.section]

        if let listsInSection = sectionCompleteLists[section], indexPath.row < listsInSection.count {
            let list = listsInSection[indexPath.row]
            cell.titleLabel.text = list.title

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd HH:mm"
            if let date = list.date {
                cell.dateLabel.text = dateFormatter.string(from: date)
            } else {
                cell.dateLabel.text = ""
            }
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue

        let headerLabel = UILabel()
        headerLabel.text = Section.allCases[section].rawValue
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.textColor = .white
        headerView.addSubview(headerLabel)

        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }


}
