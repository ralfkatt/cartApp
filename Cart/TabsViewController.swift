//
//  TabsViewController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-09-01.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit

class TabsViewController: UIViewController {
    @IBOutlet weak var tabImage: UIImageView!
    @IBOutlet weak var tabImage1: UIImageView!
    
    @IBOutlet weak var tabImage2: UIImageView!
    
    @IBOutlet weak var tabImage3: UIImageView!
    
    var tabs:[UIImageView]!
    
    var urlAndImage = [UIImage : String]()
    static var counter = 0
    
    @IBOutlet weak var newTabButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabImage.isUserInteractionEnabled = true
        tabImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        tabImage1.isUserInteractionEnabled = true
        tabImage1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped1)))
        tabImage2.isUserInteractionEnabled = true
        tabImage2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped2)))
        tabImage3.isUserInteractionEnabled = true
        tabImage3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped3)))
        TabsViewController.counter += 1
        // Do any additional setup after loading the view.
        
        tabImage.isHidden = true
        tabImage1.isHidden = true
        tabImage2.isHidden = true
        tabImage3.isHidden = true
        cartModel.loadSnapShot(tabView: self)
        cartModel.setTabsViewController(tabView: self)
        tabs = [tabImage, tabImage1, tabImage2, tabImage3]
        
        
        //self.loadWebSnapshot()
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //cartModel.loadSnapShot(tabView: self)
        
    }
    @IBAction func unwindToThisVC(segue: UIStoryboardSegue) {
        
    }
    func loadWebSnapshot() {
        if(tabImage.image != nil && tabImage.isHidden) {
            tabImage.isHidden = false
        }
        else if(tabImage1.image != nil && tabImage1.isHidden) {
            tabImage1.isHidden = false
        }
        else if(tabImage2.image != nil && tabImage2.isHidden) {
            tabImage2.isHidden = false
        }
        else if(tabImage3.image != nil && tabImage3.isHidden) {
            tabImage3.isHidden = false
        }
    }
    
    @IBAction func newTabButtonPressed(_ sender: Any) {
        tabBarController?.selectedIndex = 1
        for tab in self.tabs {
            if(tab.isHidden) {
                tab.isHidden = false
                break
            }
            
        }
    }
    func setTabImage(image: UIImage, url: String) {
        print(tabImage.image)
        print(tabImage1.image)
        if(tabImage.image == nil) {
            urlAndImage[image] = url
            tabImage.image = image
            print(tabImage.image)
            print("inside if")
        }
        else if(tabImage1.image == nil) {
            urlAndImage[image] = url
            tabImage1.image = image
        }
        else if(tabImage2.image == nil) {
            urlAndImage[image] = url
            tabImage2.image = image
        }
        else if(tabImage3.image == nil) {
            urlAndImage[image] = url
            tabImage3.image = image
        }
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabToWeb" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.webView = currentWebView
            }
        }
    }
 */
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        let url = cartModel.urlAndImage[tabImage.image!]
        currentWebView = url
        cartModel.sendRequest(urlString: url!)
        tabBarController?.selectedIndex = 1
        
        
    }
    @objc private func imageTapped1(_ recognizer: UITapGestureRecognizer) {
        let url = cartModel.urlAndImage[tabImage1.image!]
        currentWebView = url
        cartModel.sendRequest(urlString: url!)
        tabBarController?.selectedIndex = 1
    }
    @objc private func imageTapped2(_ recognizer: UITapGestureRecognizer) {
        let url = cartModel.urlAndImage[tabImage2.image!]
        currentWebView = url
        cartModel.sendRequest(urlString: url!)
        tabBarController?.selectedIndex = 1
        
    }
    @objc private func imageTapped3(_ recognizer: UITapGestureRecognizer) {
        let url = cartModel.urlAndImage[tabImage3.image!]
        currentWebView = url
        cartModel.sendRequest(urlString: url!)
        tabBarController?.selectedIndex = 1
        
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
