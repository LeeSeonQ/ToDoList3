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

    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 23)
    }
    let isCompletedSwitch = UISwitch().then{
        $0.isOn = false
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
        let indexPath = IndexPath(row: sender.tag, section: 0) // 스위치의 tag를 사용하여 indexPath를 구합니다.
        
        if var list = self.dataManager.loadList()?[indexPath.row] {
            list.isCompleted = isOn
            self.dataManager.updateList(at: indexPath.row, with: list)
            let completeList = CompleteList(title: list.title, date: list.date)

            if isOn {
                // 스위치가 On 상태로 변경되면 완료 목록에 추가
                self.dataManager.saveCompleteList(completeList)
            } else {
                // 스위치가 Off 상태로 변경되면 완료 목록에서 삭제
                self.dataManager.deleteCompleteList(completeList)
            }
            
            print("스위치 값이 변경되었습니다. 새로운 값: \(isOn)")
        }
    }

}
