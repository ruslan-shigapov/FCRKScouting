//
//  HorizontalSliderView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 23.05.2024.
//

import UIKit

final class HorizontalSliderView: UIView {

    private lazy var horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private let customPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .label.withAlphaComponent(0.6)
        return pageControl
    }()
    
    private lazy var pageControlBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.addSubview(customPageControl)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let patchView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        patchView.backgroundColor = Constants.Colors.deepGreen
        addSubviews(horizontalScrollView, pageControlBackgroundView, patchView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func generateScrollView(with pages: [UIView]) {
        horizontalScrollView.contentSize = CGSize(
            width: frame.width * CGFloat(pages.count),
            height: frame.height
        )
        for (index, page) in pages.enumerated() {
            page.frame = CGRect(
                x: frame.width * CGFloat(index),
                y: 0,
                width: frame.width,
                height: frame.height
            )
            horizontalScrollView.addSubview(page)
        }
    }
    
    func configure(with pages: [UIView]) {
        generateScrollView(with: pages)
        customPageControl.numberOfPages = pages.count
    }
}

// MARK: - Scroll View Delegate
extension HorizontalSliderView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = round(
            scrollView.contentOffset.x / scrollView.frame.size.width)
        customPageControl.currentPage = Int(currentPage)
    }
}

// MARK: - Layout
private extension HorizontalSliderView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: topAnchor),
            horizontalScrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            horizontalScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalScrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            
            pageControlBackgroundView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: -2),
            pageControlBackgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20),
            
            patchView.topAnchor.constraint(equalTo: topAnchor),
            patchView.leadingAnchor.constraint(
                equalTo: pageControlBackgroundView.trailingAnchor),
            patchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            patchView.bottomAnchor.constraint(
                equalTo: pageControlBackgroundView.bottomAnchor),
            
            customPageControl.topAnchor.constraint(
                equalTo: pageControlBackgroundView.topAnchor,
                constant: -4),
            customPageControl.leadingAnchor.constraint(
                equalTo: pageControlBackgroundView.leadingAnchor,
                constant: -25),
            customPageControl.bottomAnchor.constraint(
                equalTo: pageControlBackgroundView.bottomAnchor,
                constant: 4),
            customPageControl.trailingAnchor.constraint(
                equalTo: pageControlBackgroundView.trailingAnchor,
                constant: 25)
        ])
    }
}
