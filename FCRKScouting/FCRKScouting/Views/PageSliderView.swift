//
//  PageSliderView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 23.05.2024.
//

import UIKit

final class PageSliderView: UIView {
    
    // MARK: Private Properties
    private var pageControlRightOffset: CGFloat = 12

    // MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private let pageControl = DisabledPageControl()
    
    private lazy var patchView: UIView = {
        let view = UIView()
        view.backgroundColor = .deepGreen
        view.addSubview(pageControl)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubviews(scrollView, patchView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func generateScrollView(withPages pages: [UIView]) {
        scrollView.contentSize = CGSize(
            width: frame.width * CGFloat(pages.count),
            height: frame.height
        )
        for (index, page) in pages.enumerated() {
            page.frame = CGRect(
                x: frame.width * CGFloat(index),
                y: 0,
                width: frame.width,
                height: frame.height)
            scrollView.addSubview(page)
        }
    }
    
    // MARK: Public Methods    
    func configure(withPages pages: [UIView]) {
        generateScrollView(withPages: pages)
        pageControl.numberOfPages = pages.count
    }
}

// MARK: - Scroll View Delegate
extension PageSliderView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = round(
            scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(currentPage)
    }
}

// MARK: - Layout
private extension PageSliderView {
    
    func setConstraints() {
        if #available(iOS 18.0, *) {
            pageControlRightOffset -= 20
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            
            patchView.topAnchor.constraint(equalTo: topAnchor),
            patchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControl.topAnchor.constraint(
                equalTo: patchView.topAnchor,
                constant: -4),
            pageControl.leadingAnchor.constraint(
                equalTo: patchView.leadingAnchor),
            pageControl.bottomAnchor.constraint(
                equalTo: patchView.bottomAnchor,
                constant: 4),
            pageControl.trailingAnchor.constraint(
                equalTo: patchView.trailingAnchor,
                constant: pageControlRightOffset)
        ])
    }
}
