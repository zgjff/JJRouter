//
//  Scanner.swift
//  RouterDemo
//
//  Created by 郑桂杰 on 2022/7/13.
//

import Foundation

extension Router {
    struct Scanner {
        func tokenize(pattern: String) -> [RoutingPatternToken] {
            guard !pattern.isEmpty else {
                return []
            }
            let scanner = Foundation.Scanner(string: pattern)
            var builder = PatternTokenBuilder()
            while !scanner.isAtEnd {
                if let str = scanner.scanCharacters(from: .letters) {
                    builder.appendLetters(str)
                    continue
                }
                if let dvalue = scanner.scanDouble() {
                    let isInteger = floor(dvalue) == dvalue
                    builder.appendLetters(isInteger ? String(Int(dvalue)) : String(dvalue))
                    continue
                }
                if let _ = scanner.scanString("/") {
                    builder.appendSlash()
                    continue
                }
                if let _ = scanner.scanString(":") {
                    builder.appendVariable()
                    continue
                }
                if let _ = scanner.scanString("?") {
                    builder.appendQuery()
                    continue
                }
                if let _ = scanner.scanString("=") {
                    builder.appendEqual()
                    continue
                }
                if let _ = scanner.scanString("&") {
                    builder.appendAnd()
                    continue
                }
                if let _ = scanner.scanString("#") {
                    builder.appendFragment()
                    continue
                }
                _ = scanner.scanCharacter()
            }
            return builder.build()
        }
        
        func tokenize1(pattern: String) -> [RoutingPatternToken] {
            guard !pattern.isEmpty else {
                return []
            }
            let scanner = Foundation.Scanner(string: pattern)
            var builder = PatternTokenBuilder()
            while !scanner.isAtEnd {
                if let str = scanner.scanCharacters(from: .letters) {
                    builder.appendLetters(str)
                    continue
                }
                if let dvalue = scanner.scanDouble() {
                    let isInteger = floor(dvalue) == dvalue
                    builder.appendLetters(isInteger ? String(Int(dvalue)) : String(dvalue))
                    continue
                }
                if let _ = scanner.scanString("/") {
                    builder.appendSlash()
                    continue
                }
                if let _ = scanner.scanString(":") {
                    builder.appendVariable()
                    continue
                }
                if let _ = scanner.scanString("?") {
                    builder.appendQuery()
                    continue
                }
                if let _ = scanner.scanString("=") {
                    builder.appendEqual()
                    continue
                }
                if let _ = scanner.scanString("&") {
                    builder.appendAnd()
                    continue
                }
                if let _ = scanner.scanString("#") {
                    builder.appendFragment()
                    continue
                }
                _ = scanner.scanCharacter()
            }
            return builder.build()
        }
    }
}

enum ScanTerminal {
    /// /
    case slash
    /// ?
    case query
    /// =
    case equal
    /// &
    case and
    /// :
    case variable
    /// #
    case fragment
    case letters(_ value: String)
}
