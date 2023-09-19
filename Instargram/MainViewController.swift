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
    
    
    private let catButton = UIButton (type: .system).then{
        $0.setTitle("야옹", for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
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
    private let profileViewButton = UIButton (type: .system).then{
        $0.setTitle("프로필", for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }
    
    func setupUI() {
        view.addSubview(toDoImage)
        view.addSubview(toDoListButton)
        view.addSubview(completeButton)
        view.addSubview(catButton)
        view.addSubview(profileViewButton)

        
        toDoListButton.addTarget(self, action: #selector(toDoListButtonTapped(_:)), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for:.touchUpInside)
        catButton.addTarget(self, action: #selector(catButtonTapped(_:)), for:.touchUpInside)
        profileViewButton.addTarget(self, action: #selector(profileViewButtonTapped(_:)), for:.touchUpInside)

        toDoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-225)
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
        catButton.snp.makeConstraints {
            $0.top.equalTo(completeButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
        profileViewButton.snp.makeConstraints {
            $0.top.equalTo(catButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
    }

    
    
    @objc func toDoListButtonTapped(_ sender: UIButton) {
        let toDoListVC = ToDoListViewController()
          self.navigationController?.pushViewController(toDoListVC, animated: true)
      }
    
    @objc func completeButtonTapped(_ sender: UIButton) {
        let completeListVC = CompleteListViewController()
          self.navigationController?.pushViewController(completeListVC, animated: true)
    }
    @objc func catButtonTapped(_ sender: UIButton) {
        let completeListVC = CompleteListViewController()
          self.navigationController?.pushViewController(completeListVC, animated: true)
    }
    
    @objc func profileViewButtonTapped(_ sender: UIButton) {
        let profileVC = ProfileViewController()
//        profileVC.modalPresentationStyle = .fullScreen
        self.present(profileVC, animated: true)
    }
    
}
