//
//  BeerDetailView.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/21.
//

import Foundation
import UIKit

class BeerDetailView: UIView {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.contentMode = .scaleAspectFill
//        image.image = UIImage(named: "poster")
        return image
    }()
    
    let containerView = UIView()
    
    let imageContainerView = UIView()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = UIColor().buttonColor.cgColor
        button.layer.borderWidth = 5
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = UIColor().buttonColor
        button.layer.cornerRadius = 10
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor().buttonColor
        button.setTitle("맥주 공유하기", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let introView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addBottomButton()
        makeStretchyHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addBottomButton() {
        self.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }

        buttonContainerView.addSubview(buttonStackView)

//        if viewType == "Recommend" {
//            buttonStackView.addArrangedSubview(resetButton)
//            resetButton.snp.makeConstraints {
//                $0.width.equalTo(resetButton.snp.height)
//            }
//        }
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func makeStretchyHeader() {
        containerView.addSubview(imageContainerView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(introView)
        self.addSubview(imageView)
        self.addSubview(scrollView)
        
        let distance = UIScreen.main.bounds.height * 0.3
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top)
        }
        
        containerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(2000)
            $0.bottom.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(distance)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(imageContainerView)
        }
        
        introView.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(0.9)
            $0.height.equalTo(self).multipliedBy(0.15)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(distance / 5 * 4)
        }
    }
}
