//
//  PassContextBlockExampleController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/11.
//

import UIKit

final class PassContextBlockExampleController: UIViewController {
    private lazy var button = UIButton()
    private var routerResult: JJRouter.MatchResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        button.addTarget(self, action: #selector(onClick), for: .primaryActionTriggered)
        button.backgroundColor = .random()
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 50, y: view.bounds.height - 100, width: view.bounds.width - 100, height: 40)
    }
    
    @IBAction private func onClick() {
        guard let routerResult = routerResult,
        let (fromBottom, _) = routerResult.context as? (Bool, Int) else {
            return
        }
        if fromBottom {
            routerResult.perform(blockName: "onNeedChangeBackgroundColor", withObject: UIColor.random())
        } else {
            routerResult.perform(blockName: "onNeedChangeTitle", withObject: "\(arc4random_uniform(90))")
        }
    }
}

extension PassContextBlockExampleController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController),
        let (fromBottom, pid) = result.context as? (Bool, Int),
        pid > 0 else {
            return
        }
        button.setTitle(fromBottom ? "更改上个界面的背景色" : "更改上个界面的title", for: [])
        preferredContentSize = fromBottom ? CGSize(width: view.bounds.width, height: 300) : CGSize(width: view.bounds.width - 100, height: 200)
        routerResult = result
        let pd = AlertPresentationController(show: self, from: tvc) { ctx in
            ctx.usingClearCoverAnimators()
            if fromBottom {
                ctx.usingBottomPresentation()
                ctx.presentationWrappingView = AlertPresentationContext.Default.topRoundedCornerWrappingView(10)
            }
        }
        transitioningDelegate = pd
        tvc.present(self, animated: true) {
            let _ = pd
        }
    }
}
