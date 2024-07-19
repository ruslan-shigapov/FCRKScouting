//
//  AddCareerViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.07.2024.
//

import UIKit

final class AddCareerViewController: UIViewController {
    
    private var delegate: AddCareerViewControllerDelegate
    
    private let yearLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.year)
    private let dashLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.dash)
    private let periodLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.period)
    private let leagueLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.league)
    
    private lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toYearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var toYearSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.backgroundColor = .white
        switcher.layer.cornerRadius = 16
        switcher.addTarget(
            self,
            action: #selector(toYearSwitcherChanged),
            for: .valueChanged)
        return switcher
    }()
    
    private lazy var leaguePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 2
        pickerView.backgroundColor = .white
        pickerView.setupCornerRadius()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    init(delegate: AddCareerViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubviews(
            yearLabel,
            yearPickerView,
            dashLabel,
            periodLabel,
            toYearSwitcher,
            toYearPickerView,
            leagueLabel,
            leaguePickerView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func getYears() -> [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let yearsInPast = 30
        var years: [Int] = []
        for year in (currentYear - yearsInPast)...currentYear {
            years.append(year)
        }
        return years.reversed()
    }
    
    @objc private func toYearSwitcherChanged() {
        toYearPickerView.isHidden.toggle()
    }
}

extension AddCareerViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = pickerView.tag == 1
        ? String(getYears()[row])
        : Constants.Text.Leagues.allCases[row].rawValue
        rowLabel.font = Constants.Fonts.text
        rowLabel.textColor = .black
        rowLabel.textAlignment = .center
        return rowLabel
    }
}

extension AddCareerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        pickerView.tag == 1
        ? getYears().count
        : Constants.Text.Leagues.allCases.count
    }
}

// MARK: - Layout
private extension AddCareerViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 48),
            yearLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            yearPickerView.topAnchor.constraint(
                equalTo: yearLabel.bottomAnchor,
                constant: 12),
            yearPickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            yearPickerView.heightAnchor.constraint(equalToConstant: 80),
            yearPickerView.widthAnchor.constraint(equalToConstant: 150),
            
            dashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dashLabel.centerYAnchor.constraint(
                equalTo: yearPickerView.centerYAnchor),
            
            toYearPickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            toYearPickerView.centerYAnchor.constraint(
                equalTo: yearPickerView.centerYAnchor),
            toYearPickerView.heightAnchor.constraint(equalToConstant: 80),
            toYearPickerView.widthAnchor.constraint(equalToConstant: 150),
            
            periodLabel.centerYAnchor.constraint(
                equalTo: yearLabel.centerYAnchor),
            periodLabel.leadingAnchor.constraint(
                equalTo: toYearPickerView.leadingAnchor),
            
            toYearSwitcher.centerYAnchor.constraint(
                equalTo: yearLabel.centerYAnchor),
            toYearSwitcher.trailingAnchor.constraint(
                equalTo: toYearPickerView.trailingAnchor),
            
            leagueLabel.centerYAnchor.constraint(
                equalTo: leaguePickerView.centerYAnchor),
            leagueLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            leaguePickerView.centerXAnchor.constraint(
                equalTo: dashLabel.centerXAnchor),
            leaguePickerView.topAnchor.constraint(
                equalTo: yearPickerView.bottomAnchor,
                constant: 24),
            leaguePickerView.heightAnchor.constraint(equalToConstant: 80),
            leaguePickerView.widthAnchor.constraint(equalToConstant: 190),
        ])
    }
}
