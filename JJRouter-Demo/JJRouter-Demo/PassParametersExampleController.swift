//
//  PassParametersExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class PassParametersExampleController: UIViewController {
    private var pid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加载中..."
        view.backgroundColor = .random()
        loadProductInfo()
    }
    
    private func loadProductInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else {
                return
            }
            self.title = "产品id=\(self.pid)详情"
        }
    }
}

extension PassParametersExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController),
        let pid = result.parameters["id"] else {
            return
        }
        self.pid = pid
        let navi = UINavigationController(rootViewController: self)
        tvc.present(navi, animated: true)
    }
}
