//
//  JJRouterDestination.swift
//  JJRouter
//
//  Created by zgjff on 2022/6/10.
//

import UIKit

/// 匹配成功后的路由目标界面
public protocol JJRouterDestination {
    /// 当匹配到的路由跟当前展示的界面相同时的操作方法,默认返回`new`
    ///
    /// 返回`none`时,不做任何操作
    ///
    /// 返回`update`时,会调用`updateWhenRouterIdentifierIsSame`方法来更新当前界面
    ///
    /// 返回`new`时,会调用`showDetail`来重新展示新的界面
    /// - Parameter result: 匹配结果
    func actionWhenMatchedRouterDestinationSameToCurrent(withNewMatchRouterResult result: JJRouter.MatchResult) -> JJRouter.MatchedSameRouterDestinationAction
    
    /// 当当前界面为路由匹配到的界面时,并且当前标志符跟匹配到的标志符不一致时的操作
    func updateWhenRouterIdentifierIsSame(withNewMatchRouterResult result: JJRouter.MatchResult)
    
    /// 显示匹配到的界面逻辑
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult)
}

extension JJRouterDestination {
    func actionWhenMatchedRouterDestinationSameToCurrent(withNewMatchRouterResult result: JJRouter.MatchResult) -> JJRouter.MatchedSameRouterDestinationAction {
        return .new
    }
    
    func updateWhenRouterIdentifierIsSame(withNewMatchRouterResult result: JJRouter.MatchResult) {}
    
    /// 处理路由匹配到的界面
    /// - Parameter result: 匹配结果
    func deal(withMatchedResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(JJRouter.default.appKeyWindow?.rootViewController) as? JJRouterDestination else {
            showDetail(withMatchRouterResult: result)
            return
        }
        if type(of: tvc) != type(of: self) {
            return showDetail(withMatchRouterResult: result)
        }
        switch actionWhenMatchedRouterDestinationSameToCurrent(withNewMatchRouterResult: result) {
        case .none:
            return
        case .update:
            tvc.updateWhenRouterIdentifierIsSame(withNewMatchRouterResult: result)
            return
        case .new:
            showDetail(withMatchRouterResult: result)
        }
    }
}
