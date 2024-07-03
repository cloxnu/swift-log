//
//  GlobalLogger.swift
//
//
//  Created by Sidney Liu on 7/3/24.
//

import Foundation

public let globalLogger = Logger(label: Bundle.main.bundleIdentifier ?? "")

// MARK: - Global Functions

public func log(_ message: @autoclosure () -> Logger.Message, level: Logger.Level, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: level, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for messages that contain information normally of use only when
/// tracing the execution of a program.
public func logT(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .trace, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for messages that contain information normally of use only when
/// debugging a program.
public func logD(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .debug, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for informational messages.
public func logI(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .info, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for conditions that are not error conditions, but that may require
/// special handling.
public func logN(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .notice, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for messages that are not error conditions, but more severe than notice.
public func logW(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .warning, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for error conditions.
public func logE(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .error, message(), metadata: metadata(), file: file, function: function, line: line)
}

/// Appropriate for critical error conditions that usually require immediate
/// attention.
///
/// When a `critical` message is logged, the logging backend (`LogHandler`) is free to perform
/// more heavy-weight operations to capture system state (such as capturing stack traces) to facilitate
/// debugging.
public func logC(_ message: @autoclosure () -> Logger.Message, metadata: @autoclosure () -> Logger.Metadata? = nil, file: String = #fileID, function: String = #function, line: UInt = #line) {
    globalLogger.log(level: .critical, message(), metadata: metadata(), file: file, function: function, line: line)
}

public func logElapsedTime<T>(
    _ message: @autoclosure () -> Logger.Message,
    level: Logger.Level = .trace,
    metadata: @autoclosure () -> Logger.Metadata? = nil,
    work: () throws -> T,
    file: String = #fileID,
    function: String = #function,
    line: UInt = #line
) rethrows -> T {
    let start = DispatchTime.now()
    let result = try work()
    let end = DispatchTime.now()
    let elapsedTime = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
    log("\(message()) \(elapsedTime)", level: level, file: file, function: function, line: line)
    return result
}
