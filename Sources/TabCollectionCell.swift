//
//  TabCollectionCell.swift
//  TabPageViewController
//
//  Created by EndouMari on 2016/02/24.
//  Copyright © 2016年 EndouMari. All rights reserved.
//

import UIKit

class TabCollectionCell: UICollectionViewCell {

    var tabItemButtonPressedBlock: (() -> Void)?
    var option: TabPageOption = TabPageOption() {
        didSet {
            currentBarViewHeightConstraint.constant = option.currentBarHeight
        }
    }
    var item: String = "" {
        didSet {
            itemLabel.text = item
            itemButton.accessibilityLabel = item
            itemLabel.invalidateIntrinsicContentSize()
            invalidateIntrinsicContentSize()
        }
    }
    var isCurrent: Bool = false {
        didSet {
            currentBarView.isHidden = !isCurrent
            if isCurrent {
                highlightTitle()
            } else {
                unHighlightTitle()
            }
            currentBarView.backgroundColor = option.currentColor
            layoutIfNeeded()
        }
    }

    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var itemButton: UIButton!
    @IBOutlet private weak var currentBarView: UIView!
    @IBOutlet private weak var currentBarViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        currentBarView.isHidden = true
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return item.isEmpty ? .zero : intrinsicContentSize
    }

    class func cellIdentifier() -> String {
        return "TabCollectionCell"
    }
}


// MARK: - View

extension TabCollectionCell {

    override var intrinsicContentSize: CGSize {
        let width: CGFloat
        if let tabWidth = option.tabWidth , tabWidth > 0.0 {
            width = tabWidth
        } else {
            width = itemLabel.intrinsicContentSize.width + option.tabMargin * 2
        }

        return CGSize(width: width, height: option.tabHeight)
    }

    func hideCurrentBarView() {
        currentBarView.isHidden = true
    }

    func showCurrentBarView() {
        currentBarView.isHidden = false
    }

    func highlightTitle() {
        itemLabel.textColor = option.currentColor
        itemLabel.font = .boldSystemFont(ofSize: option.fontSize)
    }

    func unHighlightTitle() {
        itemLabel.textColor = option.defaultColor
        itemLabel.font = .systemFont(ofSize: option.fontSize)
    }
}


// MARK: - IBAction

extension TabCollectionCell {

    @IBAction private func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonPressedBlock?()
    }
}
