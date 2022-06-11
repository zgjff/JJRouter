//
//  RootViewController.swift
//  JJRouter-Demo
//
//  Created by zgjff on 2022/6/10.
//

import UIKit

private let tableviewcellIndentifier = "tableviewcell"

class RootViewController: UIViewController {
    fileprivate struct JumpAction {
        let title: String
        let sel: String
    }
    private lazy var tableView = UITableView()
    private var actions: [JumpAction] = []
}

extension RootViewController {
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Root"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableviewcellIndentifier)
        tableView.delegate = self
        tableView.dataSource = self
        configActions()
    }
    
    private func configActions() {
        DispatchQueue.global().async {
            let actions: [JumpAction] = [
                JumpAction(title: "Push", sel: "onClickJumpPush"),
                JumpAction(title: "SystemPresent", sel: "onClickJumpSystemPresent"),
                JumpAction(title: "PushStylePresent", sel: "onClickPushStylePresent"),
                JumpAction(title: "AlertCenter", sel: "onClickAlertCenter"),
                JumpAction(title: "PassParameters", sel: "onClickPassParameters"),
                JumpAction(title: "openUrl1", sel: "onClickOpenUrl1"),
                JumpAction(title: "openUrl2", sel: "onClickOpenUrl2"),
            ]
            self.actions = actions
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewcellIndentifier, for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = actions[indexPath.row]
        let str = action.sel
        if str.isEmpty {
            return
        }
        let sel = Selector(str)
        perform(sel)
    }
}

private extension RootViewController {
    @IBAction func onClickJumpPush() {
        JJRouter.default.open(SampleExampleRouter.push)
    }
    
    @IBAction func onClickJumpSystemPresent() {
        JJRouter.default.open(SampleExampleRouter.systemPresent)
    }
    
    @IBAction func onClickPushStylePresent() {
        JJRouter.default.open(SampleExampleRouter.pushStylePresent)
    }
    
    @IBAction func onClickAlertCenter() {
        JJRouter.default.open(SampleExampleRouter.alertCenter)
    }
    
    @IBAction func onClickPassParameters() {
        JJRouter.default.open("/app/product/2")
    }
    
    @IBAction func onClickOpenUrl1() {
        let r = JJRouter.default.open("applinks://www.youApp.com/app/product/10")
        // 这个回调没任何意义,只是为了展示就算跳转不到想要的控制器,而被映射到其它控制器的时候,也可以其它控制器的拿到回调,比如登录成功之后刷新UI
        r?.register(blockName: "onLoginSuccess", callback: { _ in
            print("onLoginSuccess----")
        })
    }
    
    @IBAction func onClickOpenUrl2() {
        let url = URL(string: "/photos?user_id=2")
        print(url, url?.path, url?.query)
        let r = JJRouter.default.open("/app/aainfo/2/aaa")
        print(r)
    }
}
