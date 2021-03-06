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
                JumpAction(title: "openUrl", sel: "onClickOpenUrl"),
                JumpAction(title: "OpenGroupInfoWithParameters", sel: "onClickOpenGroupInfoWithParameters"),
                JumpAction(title: "OpenGroupInfoWithUrl1", sel: "onClickOpenGroupInfoWithUrl1"),
                JumpAction(title: "OpenGroupInfoWithUrl2", sel: "onClickOpenGroupInfoWithUrl2"),
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
        let url = URL(string: "www.youApp.com/app/product/:object/:action")!
        print("onClickJumpPush: ", url.pathComponents)
        let c = URLComponents(string: url.absoluteString)
        print("onClickJumpPush: ", c)
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
       let r = JJRouter.default.open("/app/product/2")
        print("onClickPassParameters: ", r)
    }
    
    @IBAction func onClickOpenUrl() {
        let r = JJRouter.default.open("applinks://www.youApp.com/app/product/10")
        // ???????????????????????????,??????????????????????????????????????????????????????,???????????????????????????????????????,???????????????????????????????????????,??????????????????????????????UI
        r?.register(blockName: "onLoginSuccess", callback: { _ in
            print("onLoginSuccess----")
        })
    }
    
    @IBAction func onClickOpenGroupInfoWithParameters() {
        JJRouter.default.open(BlockExampleRouter.groupInfo(id: 999, name: "adfs"))
    }
    
    @IBAction func onClickOpenGroupInfoWithUrl1() {
        JJRouter.default.open("/app/groupInfo/88/play")
    }
    
    @IBAction func onClickOpenGroupInfoWithUrl2() {
        JJRouter.default.open("/app/web/product?id=123&group=game")
    }
}
