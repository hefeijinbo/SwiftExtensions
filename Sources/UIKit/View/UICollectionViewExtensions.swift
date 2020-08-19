//
//  UICollectionViewExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/10.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UICollectionView {
    /// 计算正好填满 collectionView 的 cell size
    /// - Parameters:
    ///   - cellCount: 当前滚动方向的垂直方向需要填充的 cell 数量
    @objc func fillCellSize(cellCount: Int) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return collectionViewLayout.collectionViewContentSize
        }
        let count = CGFloat(cellCount)
        if layout.scrollDirection == .vertical {
            var totalWidth = bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
            totalWidth -= ((count - 1) * layout.minimumInteritemSpacing)
            let itemWidth = floor(totalWidth / count)
            return CGSize(width: itemWidth, height: layout.itemSize.height)
        } else {
            var totalHeight = bounds.size.height - layout.sectionInset.top - layout.sectionInset.bottom
            totalHeight -= ((count - 1) * layout.minimumLineSpacing)
            let itemHeight = floor(totalHeight / count)
            return CGSize(width: layout.itemSize.width, height: itemHeight)
        }
    }
    
    /// 安全滑动到指定 item
    @objc func scrollToItemSafe(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard indexPath.item >= 0 &&
            indexPath.section >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.item < numberOfItems(inSection: indexPath.section) else {
                return
        }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
}
