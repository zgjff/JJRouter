//
//  LoginController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class LoginController: UIViewController {
    private var routerResult: JJRouter.MatchResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .random()
        addScreenPanGestureDismiss()
        let b = UIButton(frame: CGRect(x: 50, y: view.bounds.height - 150, width: view.bounds.width - 100, height: 40))
        b.backgroundColor = .random()
        b.setTitle("登录", for: [])
        b.addTarget(self, action: #selector(onClick), for: .primaryActionTriggered)
        view.addSubview(b)
    }
    
    @IBAction private func onClick() {
        dismiss(animated: true) { [weak self] in 
            self?.routerResult?.perform(blockName: "onLoginSuccess", withObject: nil)
        }
    }
}

extension LoginController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        routerResult = result
        tvc.present(UINavigationController(rootViewController: self), animated: true)
    }
}
