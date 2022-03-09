//
//  ProfileView.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 08.03.2022.
//

import Foundation
import UIKit

protocol Configurable {
    func configure(user: User)
}

class ProfileView: UIViewController {
    let presenter: Presenter
    
    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationItem = UINavigationItem(title: Constants.navigationBarTitle)
        let newUserButton = UIBarButtonItem(
            title: Constants.newUserButtonTitle,
            style: .plain,
            target: self,
            action: #selector(getNewUser))
        navigationItem.rightBarButtonItem = newUserButton
        navigationBar.setItems([navigationItem], animated: false)
        
        return navigationBar
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = Constants.imageBorderWidth
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.labelSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var containerViewForImage: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupSubviews()
        setupSubviewsConstraints()
        presenter.getUser()
    }
    
    private func setupSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(containerViewForImage)
        view.addSubview(labelsStackView)
    }
    
    private func setupSubviewsConstraints() {
        setupNavigationBarConstraints()
        setupContainerViewForImage()
        setupProfileImageViewConstraints()
        setupStackView()
    }
    
    private func setupNavigationBarConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: Constants.navigationBarHeight)
        ])
    }
    
    private func setupContainerViewForImage() {
        containerViewForImage.addSubview(profileImageView)
        
        containerViewForImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerViewForImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerViewForImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerViewForImage.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            containerViewForImage.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupProfileImageViewConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: self.containerViewForImage.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: self.containerViewForImage.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
    
    private func setupStackView() {
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(addressLabel)
        labelsStackView.addArrangedSubview(emailLabel)
        labelsStackView.addArrangedSubview(phoneLabel)
        labelsStackView.addArrangedSubview(genderLabel)
        
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.LabelsStackViewInsets.leading),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.LabelsStackViewInsets.trailing),
            labelsStackView.topAnchor.constraint(equalTo: containerViewForImage.bottomAnchor, constant: Constants.LabelsStackViewInsets.top),
            labelsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.LabelsStackViewInsets.bottom)
        ])
    }
    
    @objc private func getNewUser() {
        presenter.getUser()
    }
}

// MARK: - Configurable
extension ProfileView: Configurable {
    func configure(user: User) {
        let urlString = user.picture.large
        let url = URL(string: urlString)
        guard url != nil else {
            print("URL is nil")
            return
        }
        
        profileImageView.load(url: url!)
        nameLabel.text = Constants.LabelPrefix.name + user.name.getFullName()
        addressLabel.text = Constants.LabelPrefix.address + user.location.getAddress()
        emailLabel.text = Constants.LabelPrefix.email + user.email
        phoneLabel.text = Constants.LabelPrefix.phone + user.phone
        genderLabel.text = Constants.LabelPrefix.gender + user.gender
    }
}

// MARK: - ProfileViewProtocol
extension ProfileView: ProfileViewProtocol {
    func success() {
        let user = presenter.response?.results[0]
        guard user != nil else {
            print("URL is nil")
            return
        }
        configure(user: user!)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - UIImageView extension
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
