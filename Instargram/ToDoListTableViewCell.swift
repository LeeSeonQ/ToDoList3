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
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 23)
    }
    
    let isCompletedSwitch = UISwitch().then {
        $0.isEnabled = true
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        addSubview(titleLabel)
        addSubview(isCompletedSwitch)
        addSubview(dateLabel)

        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview().offset(-50)
        }
        dateLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-5)
            $0.top.equalToSuperview().offset(-5)
            $0.bottom.equalTo(isCompletedSwitch.snp.top).offset(-5)
        }
        isCompletedSwitch.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
