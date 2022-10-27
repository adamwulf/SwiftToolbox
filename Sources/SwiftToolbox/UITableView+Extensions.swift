//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/30/22.
//

#if canImport(UIKit)
import UIKit

public extension UITableView {
    func indexPaths(in section: Int) -> [IndexPath] {
        let numRows = numberOfRows(inSection: section)
        return (0..<numRows).map({ IndexPath(row: $0, section: section) })
    }

    func reloadRows(in section: Int, with animation: UITableView.RowAnimation) {
        reloadRows(at: indexPaths(in: section), with: animation)
    }
}
#endif
