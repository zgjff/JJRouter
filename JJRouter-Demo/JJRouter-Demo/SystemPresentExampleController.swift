//
//  SystemPresentExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class SystemPresentExampleController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SystemPresentExample"
        view.backgroundColor = .random()
        addScreenPanGestureDismiss()
        let b = UIButton(frame: CGRect(x: 50, y: view.bounds.height - 150, width: view.bounds.width - 100, height: 40))
        b.backgroundColor = .random()
        b.setTitle("跳转带回调的控制器", for: [])
        b.addTarget(self, action: #selector(onClick), for: .primaryActionTriggered)
        view.addSubview(b)
    }
    
    @IBAction private func onClick() {
        let router = JJRouter.default.open(BlockExampleRouter.bottomBlock)
        router?.register(blockName: "onNeedChangeBackgroundColor", callback: { [weak self] obj in
            if let obj = obj as? UIColor {
                self?.view.backgroundColor = obj
            }
        })
    }
}

extension SystemPresentExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        tvc.present(self, animated: true)
    }
}
