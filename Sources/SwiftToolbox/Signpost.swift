//
//  Signpost.swift
//
//
//  Created by Adam Wulf on 1/21/22.
//

import Foundation
import os

protocol Signpostable {
    var name: StaticString { get }
    init(_ name: StaticString)
    func finish()
    func emit(event: String)
}

struct Signpost: Signpostable {
    private let signpost: Signpostable?

    let name: StaticString

    init(_ name: StaticString) {
        self.name = name
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            signpost = OSSignpost(name)
        } else {
            signpost = nil
        }
    }

    func finish() {
        signpost?.finish()
    }

    func emit(event: String) {
        signpost?.emit(event: event)
    }
}

@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *)
final class OSSignpost: Signpostable {
    let signposter: OSSignposter
    let spidState: OSSignpostIntervalState
    private var finished: Bool = false

    let name: StaticString
    init(_ name: StaticString) {
        self.name = name
        signposter = OSSignposter(subsystem: "Muse", category: .pointsOfInterest)
        spidState = signposter.beginInterval(name)
    }

    func finish() {
        guard !finished else {
            assertionFailure("Signpost already finished")
            return
        }
        signposter.endInterval(name, spidState)
        finished = true
    }

    func emit(event: String) {
        guard !finished else {
            assertionFailure("Signpost already finished")
            return
        }
        signposter.emitEvent(name, "\(event)")
    }

    deinit {
        assert(finished, "Signpost must be finished when deallocated")
    }
}
