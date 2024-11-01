//
//  ResponsibleListViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.10.2024.
//

import UIKit

final class ResponsibleListViewController: UIViewController {
    
    private var viewModel: ResponsibleListViewModelProtocol
    
    private lazy var responsibleTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    weak var delegate: ResponsibleListViewControllerDelegate?
    
    init(viewModel: ResponsibleListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(responsibleTableView)
        view.prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Table View Delegate
extension ResponsibleListViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.addResponsibleOne(forRow: indexPath.row)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            dismiss(animated: true) {
                self.delegate?.responsibleOneWasChosen?()
            }
        }
    }
}

// MARK: - Table View Data Source
extension ResponsibleListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.textLabel?.text = viewModel.getScoutShortName(
            forRow: indexPath.row)
        cell.textLabel?.font = Constants.Fonts.secondary
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

// MARK: - Layout
extension ResponsibleListViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            responsibleTableView.topAnchor.constraint(equalTo: view.topAnchor),
            responsibleTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            responsibleTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            responsibleTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
