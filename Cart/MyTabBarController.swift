//
//  MyTabBarController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-09-03.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }
   
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1 ) {
            if(currentWebView == nil) {
                currentWebView = "https://www.google.com"
            }
            else {
                cartModel.sendRequest(urlString: currentWebView!)
            }
        }
        else if(item.tag == 2) {
            let tabs = self.viewControllers![2] as! UINavigationController
            if tabs.topViewController is TabsViewController {
                let t = tabs.topViewController as! TabsViewController
                if(t.isViewLoaded){
                    print("hej")
                    cartModel.loadSnapShot(tabView: cartModel.tabView)
                }
             }
        }
            
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
