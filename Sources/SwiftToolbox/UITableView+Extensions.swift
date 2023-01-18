//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/30/22.
//

#if canImport(UIKit)
import UIKit

public extension UITableView {
    /// Returns an array of IndexPaths for the given section
    /// - Parameter section: The section to get the IndexPaths for
    /// - Returns: An array of IndexPaths for the given section
    func indexPaths(in section: Int) -> [IndexPath] {
        let numRows = numberOfRows(inSection: section)
        return (0..<numRows).map({ IndexPath(row: $0, section: section) })
    }

    /// Reloads the rows in the given section with the given animation
    /// - Parameters:
    ///   - section: The section to reload
    ///   - animation: The animation to use when reloading
    func reloadRows(in section: Int, with animation: UITableView.RowAnimation) {
        reloadRows(at: indexPaths(in: section), with: animation)
    }
}
#endif
