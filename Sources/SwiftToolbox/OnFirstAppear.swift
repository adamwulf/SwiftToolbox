//
//  OnFirstAppear.swift
//  SwiftToolbox
//

import Foundation
import SwiftUI

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, *)
public struct FirstAppearMofier: ViewModifier {

    private let action: () async -> Void
    @State private var hasAppeared = false

    public init(_ action: @escaping () async -> Void) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        content
            .task {
                guard !hasAppeared else { return }
                hasAppeared = true
                await action()
            }
    }
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, *)
public extension View {
    func onFirstAppear(_ action: @escaping () async -> Void) -> some View {
        modifier(FirstAppearMofier(action))
    }
}
