//
//  File.swift
//  
//
//  Created by Adam Wulf on 2/4/23.
//

import Foundation
import os
//
//  File.swift
//
//
//  Created by Adam Wulf on 2/4/23.
//

public extension ProcessInfo {
    /// A flag indicating if the app is running as a unit test.
    static let isUnitTesting: Bool = ProcessInfo.processInfo.environment.keys.firstIndex(where: { $0.hasPrefix("XCTest") }) != nil ||
                                     ProcessInfo.processInfo.environment.keys.firstIndex(where: { $0.hasPrefix("CI") }) != nil

    /// A struct representing the memory information of a process.
    struct Memory {
        public init(footprint: ByteSize, available: ByteSize, limit: ByteSize) {
            self.footprint = footprint
            self.available = available
            self.limit = limit
        }
        /// The memory footprint of the process
        public let footprint: ByteSize
        /// The available memory for the process
        public let available: ByteSize
        /// The total available memory process. This is the sum of both `footprint` and `avaialable`
        public let limit: ByteSize

        /// Returns the memory information as a dictionary of human-readable strings.
        public var loggingContext: [String: String] {
            return ["footprint": self.footprint.humanReadable,
                    "available": self.available.humanReadable,
                    "limit": self.limit.humanReadable]
        }
    }

    /// Returns the current and peak memory usage of the process.
    var memory: (current: Memory, peak: Memory)? {
        guard
            let stats = Self.processMemory(),
            let footprint = ByteSize(stats.phys_footprint),
            let footprint_peak = ByteSize(stats.ledger_phys_footprint_peak)
        else {
            return nil
        }

        let available = Self.memoryAvailable(footprint: footprint)
        let likelyLimit = available + footprint
        let current = Memory(footprint: footprint,
                             available: available,
                             limit: likelyLimit)

        let peak = Memory(footprint: footprint_peak,
                          available: likelyLimit - footprint_peak,
                          limit: likelyLimit)

        return (current, peak)
    }

    private static func memoryAvailable(footprint: ByteSize) -> ByteSize {
        #if os(iOS)
            #if targetEnvironment(simulator)
                // Reasonable default of 2Gb
                return max(.zero, ByteSize.gigabyte(2) - footprint)
            #elseif targetEnvironment(macCatalyst)
                return max(.zero, (ByteSize(ProcessInfo.processInfo.physicalMemory) ?? .zero) - footprint)
            #else
                if #available(iOS 13.0, *) {
                    return ByteSize(rawValue: os_proc_available_memory())
                } else {
                    // Fallback on earlier versions
                    // use `ProcessInfo.processInfo.physicalMemory` to get the total physical memory
                    // But there's no direct alternative for available memory in earlier versions
                    let physicalMemory = ProcessInfo.processInfo.physicalMemory
                    return ByteSize(rawValue: Int(physicalMemory))
                }
            #endif
        #else
            return max(.zero, (ByteSize(ProcessInfo.processInfo.physicalMemory) ?? .zero) - footprint)
        #endif
    }

    private static func processMemory() -> task_vm_info_data_t? {
        let TASK_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
        guard let offset = MemoryLayout.offset(of: \task_vm_info_data_t.min_address) else { return nil }
        let TASK_VM_INFO_REV1_COUNT = mach_msg_type_number_t(offset / MemoryLayout<integer_t>.size)
        var info = task_vm_info_data_t()
        var count = TASK_VM_INFO_COUNT

        let kr = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
            }
        }

        guard kr == KERN_SUCCESS, count >= TASK_VM_INFO_REV1_COUNT else { return nil }

        return info
    }
}

/// Represents the thermal state of the device, which indicates the temperature and cooling capability.
public extension ProcessInfo.ThermalState {
    /// Returns a string representation of the thermal state.
    var stringValue: String {
        switch self {
        case .nominal:
            return "nominal"
        case .fair:
            return "fair"
        case .serious:
            return "serious"
        case .critical:
            return "critical"
        @unknown default:
            return "unknown"
        }
    }
}
