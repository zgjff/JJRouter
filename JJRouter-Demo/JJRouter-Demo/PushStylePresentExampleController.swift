//
//  PushStylePresentExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class PushStylePresentExampleController: UIViewController, PushPopStylePresentDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PushStylePresentExample"
        view.backgroundColor = .random()
        addScreenPanGestureDismiss()
        let b = UIButton(frame: CGRect(x: 50, y: view.bounds.height - 150, width: view.bounds.width - 100, height: 40))
        b.backgroundColor = .random()
        b.setTitle("跳转带回调的控制器", for: [])
        b.addTarget(self, action: #selector(onClick), for: .primaryActionTriggered)
        view.addSubview(b)
    }
    
    @IBAction private func onClick() {
        let showFromBottom = arc4random_uniform(2) == 0
        let pid = Int(arc4random_uniform(10)) - 5
        let router = JJRouter.default.open(BlockExampleRouter.passContext, context: (showFromBottom, pid))
        router?.register(blockName: "onNeedChangeBackgroundColor", callback: { [weak self] obj in
            if let obj = obj as? UIColor {
                self?.view.backgroundColor = obj
            }
        })
        router?.register(blockName: "onNeedChangeTitle", callback: { [weak self] obj in
            if let obj = obj as? String {
                self?.title = obj
            }
        })
    }
}

extension PushStylePresentExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        let navi = UINavigationController(rootViewController: self)
        navi.modalPresentationStyle = .fullScreen
        navi.transitioningDelegate = pushPopStylePresentDelegate
        tvc.present(navi, animated: true)
    }
}
