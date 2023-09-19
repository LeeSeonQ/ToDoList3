//
//  ProfileViewController.swift
//  Instargram
//
//  Created by Lee on 2023/09/18.
//

import UIKit
import SnapKit
import Then

class ProfileViewController: UIViewController {

    private let userName = UILabel() .then{
        $0.text = "userName"
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private let sideBarButton = UIButton(type: .system) .then{
        $0.tintColor = .black
        $0.setImage(UIImage(named: "Menu"), for: .normal)
    }
    private let profileImage = UIImageView() .then{
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.bounds.size.width = 88
        $0.layer.cornerRadius = 0.5 * $0.bounds.size.width
        $0.clipsToBounds = true
        $0.image = UIImage(named: "Profile - Fill")
    }
    private let postLabel = UILabel() .then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.text = "post"
        $0.textAlignment = .center
    }
    private let followerLabel = UILabel() .then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.text = "follower"
        $0.textAlignment = .center
    }
    private let followingLabel = UILabel() .then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.text = "following"
        $0.textAlignment = .center
    }
    private let postButton = UIButton(type: .system) .then{
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.5)
        $0.setTitle("0", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let followerButton = UIButton(type: .system) .then{
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.5)
        $0.setTitle("0", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let followingButton = UIButton(type: .system) .then{
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.5)
        $0.setTitle("0", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let infoLabelOne = UILabel() .then{
        $0.text = "르탄이"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    private let infoLabelTwo = UILabel() .then{
        $0.text = "IOS Developer"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    private let infoLabelThree = UILabel() .then{
        $0.text = "spartacodingclub.co.kr"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center

    }
    private let followButton = UIButton(type: .system) .then{
        $0.setTitle("follow",for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
        $0.tintColor = .black
    }
    private let messageButton = UIButton(type: .system) .then{
        $0.setTitle("message",for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
        $0.tintColor = .black
    }
    private let moreButton = UIButton(type: .system) .then{
        $0.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
        $0.tintColor = .black
    }
    private let divider = UIView().then {
        $0.backgroundColor = .lightGray
    }
    private let gridButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "Grid"), for: .normal)
        $0.tintColor = .black
    }
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.5
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 84, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = UIColor.systemRed.cgColor
        
        // 여기에 콜렉션 뷰에 필요한 설정 및 데이터 소스, 델리게이트 등을 추가하세요.

        return collectionView
    }()
    private let profileButton = UIButton(type: .system) .then{
        $0.tintColor = .black
        $0.setImage(UIImage(named: "Profile - Fill"), for: .normal)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
    }
    func setUpUI() {
        view.addSubview(userName)
        view.addSubview(sideBarButton)
        view.addSubview(profileImage)
        view.addSubview(postLabel)
        view.addSubview(followerLabel)
        view.addSubview(followingLabel)
        view.addSubview(postButton)
        view.addSubview(followerButton)
        view.addSubview(followingButton)
        view.addSubview(infoLabelOne)
        view.addSubview(infoLabelTwo)
        view.addSubview(infoLabelThree)
        view.addSubview(followButton)
        view.addSubview(messageButton)
        view.addSubview(moreButton)
        view.addSubview(divider)
        view.addSubview(gridButton)
        view.addSubview(collectionView)
        view.addSubview(profileButton)


        profileImage.snp.makeConstraints{
            $0.top.equalTo(userName.snp.bottom).offset(14)
            $0.left.equalToSuperview().offset(14)
            $0.width.height.equalTo(88)
        }
        userName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        sideBarButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
            $0.width.equalTo(21)
            $0.height.equalTo(17.5)
        }
        postButton.snp.makeConstraints{
            $0.left.equalTo(profileImage.snp.right).offset(50)
            $0.top.equalTo(userName.snp.bottom).offset(37)
            $0.width.equalTo(10)
            $0.height.equalTo(22)
        }
        postLabel.snp.makeConstraints{
            $0.top.equalTo(postButton.snp.bottom)
            $0.left.equalTo(profileImage.snp.right).offset(38)
        }
        followerButton.snp.makeConstraints{
            $0.left.equalTo(postButton.snp.right).offset(71)
            $0.top.equalTo(userName.snp.bottom).offset(37)
            $0.width.equalTo(10)
            $0.height.equalTo(22)
        }
        followerLabel.snp.makeConstraints{
            $0.left.equalTo(postLabel.snp.right).offset(38)
            $0.top.equalTo(followerButton.snp.bottom)
        }
        followingButton.snp.makeConstraints{
            $0.left.equalTo(followerButton.snp.right).offset(71)
            $0.top.equalTo(userName.snp.bottom).offset(37)
            $0.width.equalTo(10)
            $0.height.equalTo(22)
        }
        followingLabel.snp.makeConstraints{
            $0.top.equalTo(followerButton.snp.bottom)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-42)
            $0.height.equalTo(19)
            $0.left.equalTo(followerLabel.snp.right).offset(26)
        }
        infoLabelOne.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(17)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
        }
        infoLabelTwo.snp.makeConstraints{
            $0.top.equalTo(infoLabelOne.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
        }
        infoLabelThree.snp.makeConstraints{
            $0.top.equalTo(infoLabelTwo.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
        }
        followButton.snp.makeConstraints{
            $0.top.equalTo(infoLabelThree.snp.bottom).offset(16.5)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        messageButton.snp.makeConstraints{
            $0.top.equalTo(infoLabelThree.snp.bottom).offset(16.5)
            $0.left.equalTo(followButton.snp.right).offset(8)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        moreButton.snp.makeConstraints{
            $0.top.equalTo(infoLabelThree.snp.bottom).offset(16.5)
            $0.left.equalTo(messageButton.snp.right).offset(8)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(followButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        gridButton.snp.makeConstraints {
            $0.width.height.equalTo(22.5)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(52)
            $0.top.equalTo(divider.snp.bottom).offset(8)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(gridButton.snp.bottom).offset(10.5)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-85)
        }
        profileButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
            $0.top.equalTo(collectionView.snp.bottom)
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
