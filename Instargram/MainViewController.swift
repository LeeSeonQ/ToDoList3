//
//  MainViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/12.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    
    
    private let userNameLabel = UILabel().then {
        $0.text = "UserName"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.textColor = .white
    }

    private let toDoImage = UIImageView(image: UIImage(named: "CheckBox")) .then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    private let toDoListButton = UIButton(type: .system).then{
        $0.setTitle("나의 할일", for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
    }
    
    private let completeButton = UIButton(type: .system).then{
        $0.setTitle("완료한 일",for: .normal)
        $0.tintColor = .black
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }
    
    func setupUI() {
        view.addSubview(userNameLabel)
        view.addSubview(toDoImage)
        view.addSubview(toDoListButton)
        view.addSubview(completeButton)
        
        
        toDoListButton.addTarget(self, action: #selector(toDoListButtonTapped(_:)), for: .touchUpInside)
        
        userNameLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.4)
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        toDoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-175)
        }
        toDoListButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(toDoImage.snp.bottom).offset(30)
            $0.width.equalTo(100)
            $0.height.equalTo(44)

        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(toDoListButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
        
    }

    
    
    @objc func toDoListButtonTapped(_ sender: UIButton) {
        let toDoListVC = ToDoListViewController()
          self.navigationController?.pushViewController(toDoListVC, animated: true)
      }
        
    
    
    @objc func completeButtonTapped() {
        
        
    }
}
