//
//  PatternTokenBuilder.swift
//  RouterDemo
//
//  Created by 郑桂杰 on 2022/7/14.
//

import Foundation

struct PatternTokenBuilder {
    private var scanTerminals: [ScanTerminal] = []
}

extension PatternTokenBuilder {
    /// 添加 /
    mutating func appendSlash() {
        scanTerminals.append(.slash)
    }
    
    /// 添加 ?
    mutating func appendQuery() {
        scanTerminals.append(.query)
    }
    
    /// 添加 =
    mutating func appendEqual() {
        scanTerminals.append(.equal)
    }
    
    /// 添加 &
    mutating func appendAnd() {
        scanTerminals.append(.and)
    }
    
    /// 添加 :
    mutating func appendVariable() {
        scanTerminals.append(.variable)
    }
    
    /// 添加 #
    mutating func appendFragment() {
        scanTerminals.append(.fragment)
    }
    
    /// 添加 字符串
    mutating func appendLetters(_ letters: String) {
        scanTerminals.append(.letters(letters))
    }
}

extension PatternTokenBuilder {
    func build() -> [RoutingPatternToken] {
        var tokens: [RoutingPatternToken] = []
        for (idx, scan) in scanTerminals.enumerated() {
            switch scan {
            case .slash:
                tokens.append(.slash)
            case .query, .equal, .and, .variable, .fragment:
                continue
            case .letters(let text):
                if idx == 0 {
                    tokens.append(.path(text))
                    continue
                }
                let preScan = scanTerminals[idx - 1]
                switch preScan {
                case .slash:
                    tokens.append(.path(text))
                case .query:
                    // 遵守url命名规则的?后面一般都跟查询的key
                    tokens.append(.search(key: text, value: ""))
                case .equal:
                    // 遵守url命名规则的=后面一般都跟查询的value
                    let lastToken = tokens.removeLast()
                    if case let .search(key: key, value: _) = lastToken {
                        tokens.append(.search(key: key, value: text))
                    }
                case .and:
                    // 遵守url命名规则的&后面一般都跟查询的key
                    tokens.append(.search(key: text, value: ""))
                case .fragment:
                    // 遵守url命名规则的#后面一般都跟片段,且片段字符串之后不能拼接其它数据
                    tokens.append(.fragment(value: text))
                case .variable:
                    // 这个一般是存储变量的
                    tokens.append(.variable(key: text))
                case .letters:
                    // 这个永远不会出现
                    continue
                }
            }
        }
        return tokens
    }
}