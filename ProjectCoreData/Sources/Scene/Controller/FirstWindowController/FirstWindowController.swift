import Foundation
import UIKit
import CoreData

class FirstWindowController: UIViewController {
    
    // MARK: - Elements
    
    private var model: FirstWindowModel?
    private var firstView = FirstWindowView()
    
    
    private var firstWindowView: FirstWindowView? {
        guard isViewLoaded else { return nil }
        return view as? FirstWindowView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstView
        firstView.delegate = self
        model = FirstWindowModel()
        
        configureView()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - Configurations

private extension FirstWindowController {
    func configureView() {
        guard let models = model?.createModels() else { return }
        firstWindowView?.configureView(with: models)
    }
}

// MARK: - Delegate

extension FirstWindowController: FirstWindowDelegate {
    func addData(textLabel: String) {
        print("add: \(textLabel)")
    }
    
    func addDataModel(textLabel: String) {
        firstWindowView?.configureView(with: self.model?.addObject(textLabel: textLabel) ?? [])
    }
    
    func deleteObjectModel(indexObject: Int) {
        firstWindowView?.configureView(with: self.model?.deleteObject(indexObject: indexObject) ?? [])
    }
}
