//
//  CompleteListTableViewCell.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//

import UIKit

class CompleteListTableViewCell: UITableViewCell {

    static let identifier = "CompleteCell"
    private let dataManager = DataManager.shared

    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 23)
    }
    let dateLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    let isCompletedSwitch = UISwitch().then{
        $0.isOn = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(isCompletedSwitch) // 뷰 위치에따라서 버튼이 안눌림

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
            $0.height.equalTo(20)
        }
        isCompletedSwitch.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
