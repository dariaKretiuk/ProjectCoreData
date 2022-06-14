import Foundation
import UIKit
import CoreData

class FirstWindowView: UIView {
    
    // MARK: - Private properties

    private var models: [FirstWindow] = []
    weak var delegate: FirstWindowDelegate?

    // MARK: - Elements

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =
        NSAttributedString(string: "Введите текст", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .ff585b
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Искать", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .ff585b
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchCharacters), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
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
        setupTable()
        setupLayout()
    }

    // MARK: - Private functions

    private func setupHierarchy() {
        addSubview(tableView)
        addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FirstWindowTableCell.self, forCellReuseIdentifier: FirstWindowTableCell.identifier)
        tableView.backgroundColor = .white
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Configuration

    func configureView(with models: [FirstWindow]) {
        self.models = models
    }
    
    // MARK: - Action
    
    @objc private func searchCharacters(_ sender: UIButton) {
        delegate?.addDataModel(textLabel: textField.text ?? "")
        self.tableView.reloadData()
        textField.text = ""
    }
}

extension FirstWindowView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstWindowTableCell.identifier, for: indexPath) as? FirstWindowTableCell else {
            return UITableViewCell()
        }

        cell.configure(with: model.value(forKey: "textLabel") as! String)
        print(model)

        return cell
    }
}

extension FirstWindowView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Удалить") {  (contextualAction, view, boolValue) in
            self.delegate?.deleteObjectModel(indexObject: indexPath.row)
            self.tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
        
        
//        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") {
//            (action, indexPath) in
//            self.delegate?.deleteObjectModel(indexObject: indexPath.row)
//            self.tableView.reloadData()
//        }
//
//        delete.backgroundColor = UIColor.red
//
//        return [delete]
    }
}


