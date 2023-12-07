//
//  File.swift
//
//
//  Created by Adam Wulf on 12/7/23.
//

#if canImport(UIKit)
import UIKit

public extension UIPageControl {
    func indicatorIndex(for tapPoint: CGPoint) -> Int? {
        let indicatorSize: CGFloat = 7.0 // Adjust this value according to your indicator size
        let spacing: CGFloat = 10.0 // Adjust this value according to your spacing between indicators

        let totalWidth = CGFloat(numberOfPages) * indicatorSize + CGFloat(numberOfPages - 1) * spacing
        let startX = (bounds.size.width - totalWidth) / 2.0

        if tapPoint.x >= startX && tapPoint.x < startX + totalWidth {
            let relativeX = tapPoint.x - startX
            let indicatorIndex = Int(relativeX / (indicatorSize + spacing))
            return indicatorIndex
        }

        return nil
    }
}
#endif
