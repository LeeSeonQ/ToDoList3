//
//  ToDoListTableViewCell.swift
//  Instargram
//
//  Created by Lee on 2023/09/12.
//

import UIKit
import SnapKit
import Then

class ToDoListTableViewCell: UITableViewCell {
    static let identifier = "ToDoListCell"
    private let dataManager = DataManager.shared
    var indexPath: IndexPath?

    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 23)
    }
    let isCompletedSwitch = UISwitch().then{
        $0.isOn = false
        $0.tag = 0
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()

        isCompletedSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        
        addSubview(titleLabel)
        contentView.addSubview(isCompletedSwitch) // 뷰 위치에따라서 버튼이 안눌림
        addSubview(dateLabel)


        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview().offset(-100)
        }
        dateLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(5)
            $0.left.equalTo(titleLabel.snp.right).offset(5)
            $0.bottom.equalTo(isCompletedSwitch.snp.top).offset(-10)
            $0.height.equalTo(20)
        }
        isCompletedSwitch.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
            
        }
        isCompletedSwitch.isUserInteractionEnabled = true

    }

    @objc func switchValueChanged(_ sender: UISwitch) {
        let isOn = sender.isOn
        
        // indexPath를 사용하여 셀을 식별합니다.
        if let indexPath = self.indexPath {
            if var list = self.dataManager.loadList()?[indexPath.row] {
                let section = Section.allCases[indexPath.section] // 해당 셀의 섹션을 가져옵니다.
                
                list.isCompleted = isOn
                self.dataManager.updateList(at: indexPath.row, with: list)
                let completeList = CompleteList(title: list.title, date: list.date, section: section.rawValue) // 섹션 정보를 CompleteList에 추가합니다.

                if isOn {
                    self.dataManager.saveCompleteList(completeList)
                } else {
                    self.dataManager.deleteCompleteList(completeList)
                }
                
                print("스위치 값이 변경되었습니다. 새로운 값: \(isOn), 섹션: \(section.rawValue)")
            }
        }
    }
//    @objc func switchValueChanged(_ sender: UISwitch) {
//        let isOn = sender.isOn
//        if let indexPath = self.toDoListTableView.indexPath(for: self) {
//            if var list = self.dataManager.loadList()?[indexPath.row] {
//                list.isCompleted = isOn
//                self.dataManager.updateList(at: indexPath.row, with: list)
//                let completeList = CompleteList(title: list.title, date: list.date, section: Section.none.rawValue)
//
//                if isOn {
//                    self.dataManager.saveCompleteList(completeList)
//                } else {
//                    self.dataManager.deleteCompleteList(completeList)
//                }
//                
//                print("스위치 값이 변경되었습니다. 새로운 값: \(isOn)")
//            }
//        }
//    }
    
    
    
}
