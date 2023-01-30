//
//  TextViewContentView.swift
//  UICollectionViewListCell
//
//  Created by 도헌 on 2023/01/30.
//

import UIKit

final class TextViewContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> TextViewContentView.Configuration {
            return self
        }
    }
    
    let textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 200)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addSubView(textView, insets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        textView.delegate = self
        textView.backgroundColor = nil
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = .placeholderText
        textView.autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textView.text = configuration.text
    }
}

extension TextViewContentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.textColor = .placeholderText
            textView.text = "Note"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
