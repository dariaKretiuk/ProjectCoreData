import Foundation
import UIKit

class SecondWindowController: UIViewController {
    
    // MARK: - Elements
    
    private var model: SecondWindowModel?
    private var secondView = SecondWindowView()
    private var isTappedUpdate = false
    
    private var firstWindowView: SecondWindowView? {
        guard isViewLoaded else { return nil }
        return view as? SecondWindowView
    }
    
    private let buttonRight: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Редактировать", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonLeft: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = secondView
        secondView.delegate = self
        model = SecondWindowModel()
        
        configureView()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonRight)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonLeft)
        
        buttonRight.addTarget(self, action: #selector(updateData), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc private func updateData() {
        if isTappedUpdate {
            buttonRight.setTitle("Редактировать", for: .normal)
            let result = secondView.sendData(isTapped: isTappedUpdate)
            self.firstWindowView?.configureView(with: self.model?.addObject(object: result) ?? [])
            isTappedUpdate.toggle()
        } else {
            buttonRight.setTitle("Сохранить", for: .normal)
            let _ = secondView.sendData(isTapped: isTappedUpdate)
            isTappedUpdate.toggle()
        }
    }
    
}

// MARK: - Configurations

private extension SecondWindowController {
    func configureView() {
        guard let models = model?.createModels() else { return }
        secondView.configureView(with: models)
    }
}

// MARK: - Delegate

extension SecondWindowController: SecondWindowDelegate {
    func addObject(object: (name: String, birthday: String, genders: String)) {
        firstWindowView?.configureView(with: self.model?.addObject(object: object) ?? [])
    }
}
