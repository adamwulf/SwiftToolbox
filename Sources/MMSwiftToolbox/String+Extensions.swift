//
//  File.swift
//  
//
//  Created by Adam Wulf on 4/16/21.
//

import Foundation

extension String {
    func trimmingCharacters(in chars: String) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: chars))
    }
}
