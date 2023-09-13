//
//  ProfileViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//

import UIKit
import SnapKit
import Then


class ProfileViewController: UIViewController {

    private let userNameLabel = UILabel().then {
        $0.text = "UserName"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.textColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setUpUI() {
        view.addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.4)
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
