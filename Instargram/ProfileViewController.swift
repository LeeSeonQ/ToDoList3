//
//  ProfileViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/19.
//


import UIKit
import SnapKit
import Then


class ProfileViewController: UIViewController {

    var viewModel: ViewModel!
    
    let nameLabel = UILabel() .then {
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
        
    }
    
    let ageLabel = UILabel() .then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel = ViewModel(userName: "이선규", userAge: 29)
        updateUI()
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        
        ageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(ageLabel.snp.top).offset(-30)
        }
    }
    
    func updateUI() {
        nameLabel.text = "Name: \(viewModel.userName)"
        ageLabel.text = "Age: \(viewModel.userAge)"
    }
}
