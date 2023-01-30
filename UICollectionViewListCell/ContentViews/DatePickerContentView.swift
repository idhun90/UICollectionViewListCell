//
//  DatePickerContentView.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/30.
//

import UIKit

final class DatePickercontentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var date = Date.now
        var text = ""
        
        func makeContentView() -> UIView & UIContentView {
            return DatePickercontentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> DatePickercontentView.Configuration {
            return self
        }
    }
    
    let datePicker = UIDatePicker()
    let label = UILabel()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 44).isActive = true
        datePicker.addTarget(self, action: #selector(didPick(_:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
    }
    
    @objc private func didPick(_ sender: UIDatePicker) {
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date // 값전달인듯
        label.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickercontentView.Configuration {
        DatePickercontentView.Configuration()
    }
}
