//
//  SecondWindowView.swift
//  ProjectCoreData
//
//  Created by Дарья Кретюк on 14.06.2022.
//

import Foundation
import UIKit

class SecondWindowView: UIView {
    
    // MARK: - Private properties

    private var models: [SecondWindow] = []
    weak var delegate: SecondWindowDelegate?
    
    // MARK: - Elements
    
    private let bottomLine: CALayer = {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 0, width: 700, height: 2)
        bottomLine.backgroundColor = UIColor(red: 247.0/255.0,
                                             green: 247.0/255.0,
                                             blue: 247.0/255.0,
                                             alpha: 1
        ).cgColor
        return bottomLine
    }()
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .center
        view.layer.cornerRadius = 100
        return view
    }()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "iconSecondWindow")
        img.layer.cornerRadius = 30
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .white
        return img
    }()
    
    private let name: UITextField = {
        let textField = UITextField()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "person")
        imageView.image = image
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        textField.attributedPlaceholder =
        NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.leftView = view
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let birthday: UITextField = {
        let textField = UITextField()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "calendar")
        imageView.image = image
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        textField.attributedPlaceholder =
        NSAttributedString(string: "Birthday", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.leftView = view
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let genders: UITextField = {
        let textField = UITextField()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "figure.stand")
        imageView.image = image
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        textField.attributedPlaceholder =
        NSAttributedString(string: "Genders", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 20
        textField.leftView = view
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.spacing = 15
//        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Private functions

    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageContainer)
        imageContainer.addSubview(image)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(birthday)
        stackView.addArrangedSubview(genders)
        
        name.isEnabled = false
        birthday.isEnabled = false
        genders.isEnabled = false
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            
            image.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            name.topAnchor.constraint(equalTo: image.bottomAnchor),
            name.widthAnchor.constraint(equalToConstant: 250),
            name.bottomAnchor.constraint(equalTo: birthday.topAnchor),
            name.heightAnchor.constraint(equalToConstant: 100),
            
            birthday.topAnchor.constraint(equalTo: name.bottomAnchor),
            birthday.widthAnchor.constraint(equalToConstant: 250),
            birthday.heightAnchor.constraint(equalToConstant: 100),
            
            
            genders.topAnchor.constraint(equalTo: birthday.bottomAnchor),
            genders.widthAnchor.constraint(equalToConstant: 250),
            genders.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    // MARK: - Configuration

    func configureView(with models: [SecondWindow]) {
        self.models = models
    }
    
    // MARK: - Private func
    
    func sendData(isTapped: Bool) -> (name: String, birthday: String, genders: String) {
        if isTapped {
            name.isEnabled = false
            birthday.isEnabled = false
            genders.isEnabled = false
            let result = (name: name.text ?? "",
                    birthday: birthday.text ?? "",
                    genders: genders.text ?? "")
            name.text = ""
            birthday.text = ""
            genders.text = ""
            return result
        } else {
            name.isEnabled = true
            birthday.isEnabled = true
            genders.isEnabled = true
            return (name: "",
                    birthday: "",
                    genders: "")
        }
    }
}
