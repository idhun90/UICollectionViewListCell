//
//  ContentView.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/30.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        var placeholder: String? = ""
        var textColor: UIColor? = nil
        var keyboardType: UIKeyboardType
        
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> TextFieldContentView.Configuration {
            return self
        }
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addSubView(textField, insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        textField.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
        textField.placeholder = configuration.placeholder
        textField.textColor = configuration.textColor
        textField.keyboardType = configuration.keyboardType
    }
    
    @objc private func valueDidChange(_ sender: UITextField) {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) errored")
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration(keyboardType: .default)
    }
}
