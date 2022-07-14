//
//  UrlRouter.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import Foundation

extension URL: JJRouterSource {}

extension URL {
    public var routerPattern: String {
        return "/app/web/*"
    }
}

extension URL {
    public func register() throws {
        try JJRouter.default.register(pattern: routerPattern, mapRouter: { result in
            print(result.url.path)
            // 因为RouterX暂不支持query查询,所以这里映射下
            if result.url.path.contains("product") {
                guard let urlComponents = URLComponents(url: result.url, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else {
                    return nil
                }
                var id: String?
                var name: String?
                for queryItem in queryItems {
                    if queryItem.name == "id" {
                        id = queryItem.value
                    }
                    if queryItem.name == "group" {
                        name = queryItem.value
                    }
                }
                guard let id = id, let pid = Int(id), let name = name else {
                    return nil
                }
                return BlockExampleRouter.groupInfo(id: pid, name: name)
            }
            // other
            return nil
        })
    }
}

extension URL {
    public func makeRouterDestination() -> JJRouterDestination {
        return AlertCenterExampleController()
    }
}
