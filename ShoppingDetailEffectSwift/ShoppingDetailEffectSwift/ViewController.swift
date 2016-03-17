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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        webView = UIWebView.init(frame: CGRectMake(0, tableView.contentSize.height, view.width, view.height-50))
        webView.backgroundColor = UIColor.magentaColor()
        webView.scalesPageToFit = true
        webView.scrollView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://coding.net/u/fzhongli/p/shoppingDetailEffect/git")!))
        tableView.addSubview(webView)
        
        
        let tipLab = UILabel.init(frame: CGRectMake(0, 0, view.width, -50))
        tipLab.textAlignment = .Center
        tipLab.textColor = UIColor.whiteColor()
        tipLab.text = "----下拉返回----"
        webView.scrollView.addSubview(tipLab)
        _tipLab = tipLab
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        tableView.backgroundColor = UIColor.lightGrayColor()
        tableView.rowHeight = 100
        
        headView = UIView.init(frame: CGRectMake(0, -200, view.width, 230))
        headView.backgroundColor = UIColor.greenColor()
        tableView.addSubview(headView)
        
        for var i=0; i<4; i++ {
            let label = UILabel.init(frame: CGRectMake(0, 20+CGFloat(i)*50, view.frame.size.width, 50))
            label.textColor = UIColor.whiteColor()
            label.text = "----\(i)----"
            label.textAlignment = .Center
            headView.addSubview(label)
        }
        
        
        
        print(headView)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isEqual(tableView)  {
            
            headView?.top = -200.0*3.0/5.0+scrollView.contentOffset.y*2.0/5.0
            
            let maxOffset = max(30, tableView.contentSize.height - tableView.height + 30)
            if (scrollView.contentOffset.y > maxOffset && !scrollView.dragging && scrollView.decelerating) {
                
                tableView.setContentOffset(CGPointMake(0, tableView.contentSize.height-50), animated: true)
                tableView.scrollEnabled = false;
            }
        }
        if scrollView.isEqual(webView?.scrollView)  {
            
            _tipLab?.top = scrollView.contentOffset.y
            
            if (scrollView.contentOffset.y < -30 && !scrollView.dragging && scrollView.decelerating) {
                
                tableView.setContentOffset(CGPointMake(0, -200), animated: true)
                webView.scrollView.contentOffset = CGPointZero
                tableView.scrollEnabled = true;
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "cellIdentifier")
        }
        cell?.textLabel?.text = NSString.init(format: "-SS--%ld---BB-", indexPath.row) as String
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        return view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

