//
//  BottomBlockExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class BottomBlockExampleController: UIViewController {
    private lazy var button = UIButton()
    private var routerResult: JJRouter.MatchResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        preferredContentSize = CGSize(width: view.bounds.width, height: 300)
        button.addTarget(self, action: #selector(onClick), for: .primaryActionTriggered)
        button.setTitle("更改上个界面的背景色", for: [])
        button.backgroundColor = .random()
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 50, y: view.bounds.height - 100, width: view.bounds.width - 100, height: 40)
    }
    
    @IBAction private func onClick() {
        routerResult?.perform(blockName: "onNeedChangeBackgroundColor", withObject: UIColor.random())
    }
}

extension BottomBlockExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        routerResult = result
        let pd = AlertPresentationController(show: self, from: tvc) { ctx in
            ctx.usingClearCoverAnimators()
            ctx.usingBottomPresentation()
            ctx.presentationWrappingView = AlertPresentationContext.Default.topRoundedCornerWrappingView(10)
        }
        transitioningDelegate = pd
        tvc.present(self, animated: true) {
            let _ = pd
        }
    }
}
