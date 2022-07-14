//
//  Route.swift
//  RouterDemo
//
//  Created by 郑桂杰 on 2022/7/14.
//

import Foundation

struct Route {
    let tokens: [RoutingPatternToken]
}

extension Route {
    
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}

extension Route: Equatable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        if lhs.tokens.count != rhs.tokens.count {
            return false
        }
        if lhs.tokens.isEmpty {
            return true
        }
        let count = lhs.tokens.count
        for idx in 0..<count {
            if lhs.tokens[idx] != rhs.tokens[idx] {
                return false
            }
        }
        return true
    }
}

extension Route: CustomStringConvertible {
    var description: String {
        let desc: String = tokens.reduce("") { result, token in
            if result.isEmpty {
                return token.description
            }
            return "\(result), \(token.description)"
        }
        return "[\(desc)]"
    }
}
