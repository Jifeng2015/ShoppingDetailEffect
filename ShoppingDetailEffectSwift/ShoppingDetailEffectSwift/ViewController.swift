//
//  ViewController.swift
//  ShoppingDetailEffectSwift
//
//  Created by FangZhongli on 16/3/8.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var headView : UIView!
    
    var webView : UIWebView!
    
    var _tipLab : UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        webView = UIWebView.init(frame: CGRect(x: 0, y: tableView.contentSize.height, width: view.width, height: view.height-50))
        webView.backgroundColor = UIColor.magenta
        webView.scalesPageToFit = true
        webView.scrollView.delegate = self
        webView.loadRequest(URLRequest(url: URL(string: "https://coding.net/u/fzhongli/p/shoppingDetailEffect/git")!))
        tableView.addSubview(webView)
        
        
        let tipLab = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.width, height: -50))
        tipLab.textAlignment = .center
        tipLab.textColor = UIColor.white
        tipLab.text = "----下拉返回----"
        webView.scrollView.addSubview(tipLab)
        _tipLab = tipLab
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        tableView.backgroundColor = UIColor.lightGray
        tableView.rowHeight = 100
        
        headView = UIView.init(frame: CGRect(x: 0, y: -200, width: view.width, height: 230))
        headView.backgroundColor = UIColor.green
        tableView.addSubview(headView)
        
        tableView.sendSubview(toBack: headView)
        
        for i in 0 ..< 4 {
            let label = UILabel.init(frame: CGRect(x: 0, y: 20+CGFloat(i)*50, width: view.frame.size.width, height: 50))
            label.textColor = UIColor.white
            label.text = "----\(i)----"
            label.textAlignment = .center
            headView.addSubview(label)
        }
        
        
        
        print(headView)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(tableView)  {
            
            headView?.top = -200.0*3.0/5.0+scrollView.contentOffset.y*2.0/5.0
            
            let maxOffset = max(30, tableView.contentSize.height - tableView.height + 30)
            if (scrollView.contentOffset.y > maxOffset && !scrollView.isDragging && scrollView.isDecelerating) {
                
                tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height-50), animated: true)
                tableView.isScrollEnabled = false;
            }
        }
        if scrollView.isEqual(webView?.scrollView)  {
            
            _tipLab?.top = scrollView.contentOffset.y
            
            if (scrollView.contentOffset.y < -30 && !scrollView.isDragging && scrollView.isDecelerating) {
                
                tableView.setContentOffset(CGPoint(x: 0, y: -200), animated: true)
                webView.scrollView.contentOffset = CGPoint.zero
                tableView.isScrollEnabled = true;
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellIdentifier")
        }
        cell?.textLabel?.text = NSString.init(format: "-SS--%ld---BB-", indexPath.row) as String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

