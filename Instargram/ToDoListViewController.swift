//
//  ToDoListViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/12.
//

import UIKit

class ToDoListViewController: UIViewController {

    private let dataManager = DataManager.shared
    private let tableView = UITableView()
    
    private var addListButton = UIBarButtonItem(barButtonSystemItem: .add, target: ToDoListViewController.self, action: #selector(addListButtonTapped))



    override func viewDidLoad() {
           super.viewDidLoad()
           tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: "ToDoListCell")

           view.backgroundColor = .white

           tableView.delegate = self
           tableView.dataSource = self
        
        addListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListButtonTapped))
        navigationItem.rightBarButtonItem = addListButton
        
           setUpUI()
       }

    func setUpUI() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = addListButton
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationItem.title = "ToDoList"
        navigationController?.navigationBar.titleTextAttributes = [
            
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }

       @objc func addListButtonTapped() {
           let alertController = UIAlertController(title: "새 항목 추가", message: "원하는 List 추가", preferredStyle: .alert)

           alertController.addTextField {
               textField in
               textField.placeholder = "텍스트를 입력하시오."
           }

           let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
           alertController.addAction(cancelAction)

           let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
               if let textFields = alertController.textFields, let inputText = textFields[0].text, !inputText.isEmpty {
                   let listTitle = inputText
                   
                   let currentDate = Date()
                   
                   let list = List(title: listTitle, date: currentDate, isCompleted: false)
                   var lists = self.dataManager.loadList() ?? []
                   lists.append(list)
                   self.dataManager.saveList(lists)
                   
                   print("저장된 값: \(listTitle), 날짜: \(currentDate)")
                   self.tableView.reloadData()
               }
           }
           alertController.addAction(saveAction)

           present(alertController, animated: true, completion: nil)
       }
   }

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 70
        
        return self.dataManager.loadList()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListTableViewCell
        
        if let list = self.dataManager.loadList()?[indexPath.row] {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "수정", message: "항목 수정", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "수정할 내용을 입력하세요."
            textField.text = self.dataManager.loadList()?[indexPath.row].title
        }
        
        let updateAction = UIAlertAction(title: "수정", style: .default) { _ in
            if let textFields = alertController.textFields, let inputText = textFields[0].text, !inputText.isEmpty {
                var updatedList = self.dataManager.loadList()?[indexPath.row]
                updatedList?.title = inputText
                updatedList?.date = Date()
                self.dataManager.updateList(at: indexPath.row, with: updatedList!)
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        alertController.addAction(updateAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.deleteList(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
