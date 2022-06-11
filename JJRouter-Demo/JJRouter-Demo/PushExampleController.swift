//
//  PushExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class PushExampleController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PushExample"
        view.backgroundColor = .random()
    }
}

extension PushExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        tvc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tvc.hidesBottomBarWhenPushed = true
        tvc.navigationController?.pushViewController(self, animated: true)
    }
}
