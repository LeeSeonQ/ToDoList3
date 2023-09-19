//
//  ToDoListViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/12.
//

import UIKit

class ToDoListViewController: UIViewController {

    private let dataManager = DataManager.shared
    private let toDoListTableView = UITableView()
    private var addListButton = UIBarButtonItem(barButtonSystemItem: .add, target: ToDoListViewController.self, action: #selector(addListButtonTapped))
    
    private var selectedSection: Section = .none
    private var sectionLists: [Section: [List]] = [:]

    override func viewDidLoad() {
           super.viewDidLoad()
        
        Section.allCases.forEach { section in
            let listsInSection = dataManager.loadList()?.filter { $0.section == section.rawValue }
            sectionLists[section] = listsInSection
        }
        
        
        toDoListTableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: "ToDoListCell")

           view.backgroundColor = .white

        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        addListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListButtonTapped))
        navigationItem.rightBarButtonItem = addListButton
        
           setUpUI()
        
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 뷰가 나타날 때마다 유저 디폴트에서 데이터를 불러와서 셀에 적용
        loadListFromUserDefaults()
        toDoListTableView.reloadData()
    }

    func setUpUI() {
        
        view.addSubview(toDoListTableView)
        navigationItem.rightBarButtonItem = addListButton
        
        toDoListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationItem.title = "ToDoList"
        navigationController?.navigationBar.titleTextAttributes = [
            
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func loadListFromUserDefaults() {
        for section in Section.allCases {
            for row in 0..<(sectionLists[section]?.count ?? 0) {
                if let title = UserDefaults.standard.string(forKey: "listTitle_\(section.rawValue)_\(row)") {
                    sectionLists[section]?[row].title = title
                }
            }
        }
    }
    
    @objc func addListButtonTapped() {
        let categoryAlert = UIAlertController(title: "카테고리 선택", message: nil, preferredStyle: .alert)
        
        let categories: [Section] = [.none, .study, .hobby] // 섹션 목록을 정의
        
        for category in categories {
            let action = UIAlertAction(title: category.rawValue, style: .default) { _ in
                if let selectedSection = Section(rawValue: category.rawValue) {
                    self.selectedSection = selectedSection
                    // 새 항목 추가
                    self.showAddListAlert()
                    
                    UserDefaults.standard.set(category.rawValue, forKey: "selectedSection")
                }
            }
            categoryAlert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        categoryAlert.addAction(cancelAction)
        
        present(categoryAlert, animated: true, completion: nil)
    }

    func showAddListAlert() {
        let alertController = UIAlertController(title: "새 항목 추가", message: "원하는 List 추가", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "텍스트를 입력하세요."
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            if let textFields = alertController.textFields, let inputText = textFields[0].text, !inputText.isEmpty {
                let listTitle = inputText
                let currentDate = Date()
                
                // 저장할 때 선택한 섹션을 사용합니다.
                if let selectedSection = self?.selectedSection {
                    let list = List(title: listTitle, date: currentDate, isCompleted: false, section: selectedSection.rawValue)
                    var lists = self?.dataManager.loadList() ?? []
                    lists.append(list)
                    self?.dataManager.saveList(lists)
                    
                    print("저장된 값: \(listTitle), 날짜: \(currentDate), 섹션: \(selectedSection.rawValue)")
                    
                    if var sectionLists = self?.sectionLists {
                        if var listsInSection = sectionLists[selectedSection] {
                            listsInSection.append(list)
                            sectionLists[selectedSection] = listsInSection
                            self?.sectionLists = sectionLists
                        }
                    }
                    self?.toDoListTableView.reloadData()
                }
            }
        }
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 70
        let section = Section.allCases[section]
        return sectionLists[section]?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 선택된 섹션에 따라 해당 섹션의 데이터를 사용하여 셀을 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListTableViewCell
        
        // 각 셀에 indexPath 값을 설정합니다.
        cell.indexPath = indexPath
        
        let section = Section.allCases[indexPath.section]
        
        if let listsInSection = sectionLists[section], indexPath.row < listsInSection.count {
            let list = listsInSection[indexPath.row]
            cell.titleLabel.text = list.title
            cell.isCompletedSwitch.isOn = list.isCompleted
            
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "수정", message: "항목 수정", preferredStyle: .alert)
       
        alertController.addTextField { textField in
            textField.placeholder = "수정할 내용을 입력하세요."
            // 선택한 셀의 데이터를 가져와서 표시
            if let list = self.sectionLists[Section.allCases[indexPath.section]]?[indexPath.row] {
                textField.text = list.title
            }
        }
        let updateAction = UIAlertAction(title: "수정", style: .default) { _ in
            if let textFields = alertController.textFields, let inputText = textFields[0].text, !inputText.isEmpty {
                let section = Section.allCases[indexPath.section]
                let row = indexPath.row
                
                UserDefaults.standard.set(inputText, forKey: "listTitle_\(section.rawValue)_\(row)")
                
                self.sectionLists[section]?[row].title = inputText
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        alertController.addAction(updateAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.deleteList(at: indexPath.row)
            
            let section = Section.allCases[indexPath.section]
            if var listsInSection = sectionLists[section], indexPath.row < listsInSection.count {
                listsInSection.remove(at: indexPath.row)
                sectionLists[section] = listsInSection
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
