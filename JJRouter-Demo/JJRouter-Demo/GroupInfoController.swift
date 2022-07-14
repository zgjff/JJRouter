//
//  GroupInfoController.swift
//  JJRouter-Demo
//
//  Created by 郑桂杰 on 2022/6/14.
//

import UIKit

final class GroupInfoController: UIViewController {
    init(id: Int, name: String) {
        print("GroupInfoController------------", id, name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var pid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加载中..."
        view.backgroundColor = .random()
//        loadProductInfo()
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

extension GroupInfoController: JJRouterDestination {
    func showDetail(withMatchRouterResult result: JJRouter.MatchResult) {
        guard let tvc = UIApplication.shared.topViewController(UIApplication.shared.version_keyWindow?.rootViewController) else {
            return
        }
        print("aaaa----", result)
        let navi = UINavigationController(rootViewController: self)
        tvc.present(navi, animated: true)
    }
}
