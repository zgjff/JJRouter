//
//  AlertCenterExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class AlertCenterExampleController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        preferredContentSize = CGSize(width: view.bounds.width - 100, height: 200)
    }
}

extension AlertCenterExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        let pd = AlertPresentationController(show: self, from: tvc) { ctx in
            ctx.usingBlurBelowCoverAnimators()
            ctx.presentationWrappingView = AlertPresentationContext.Default.allRoundedCornerWrappingView
        }
        transitioningDelegate = pd
        tvc.present(self, animated: true) {
            let _ = pd
        }
    }
}
