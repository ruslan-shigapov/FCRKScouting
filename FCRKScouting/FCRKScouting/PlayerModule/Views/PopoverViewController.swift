//
//  PopoverViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.08.2024.
//

import UIKit

final class PopoverViewController: UIViewController {
    
    private var viewModel: PopoverViewModelProtocol
    
    private lazy var leagueTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var delegate: PopoverViewControllerDelegate?
    
    init(viewModel: PopoverViewModelProtocol) {
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
        view.addSubview(leagueTableView)
        view.prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Table View Delegate
extension PopoverViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self else { return }
            dismiss(animated: true) {
                self.delegate?.currentLeagueWasChosen?(indexPath.row)
            }
        }
    }
}

// MARK: - Table View Data Source
extension PopoverViewController: UITableViewDataSource {
    
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
        cell.textLabel?.text = viewModel.getLeagueName(forRow: indexPath.row)
        cell.textLabel?.font = Constants.Fonts.secondary
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

// MARK: - Layout
extension PopoverViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            leagueTableView.topAnchor.constraint(equalTo: view.topAnchor),
            leagueTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            leagueTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leagueTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
