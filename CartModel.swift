//
//  CartModel.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-09-03.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import Foundation

import WebKit

class CartModel{
    var webView: WKWebView!
    var urlAndImage = [UIImage : String]()
    var productsInCart = [URL: String]()
    var tabView: TabsViewController!
    var productImage: UIImage!
    var boozt: [String]?
    var cart: CartViewController!
    var products: [URL] = []
    
    func start() {
        tabView = TabsViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        cart = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController

       
        boozt = ["document.getElementById('nav-count-cart').click();", "document.getElementById('order_paymentId_2').click()", "document.getElementById('order_customer_billingAddress_firstname').value='hejhej'", "document.getElementById('order_customer_billingAddress_lastname').value='hejson'", "document.getElementById('order_customer_billingAddress_street').setAttribute('value', 'Ekebyvägen 11');", "document.getElementById('order_customer_billingAddress_postcode').setAttribute('value', '75263');", "document.getElementById('order_customer_billingAddress_city').setAttribute('value', 'Uppsala');", "document.getElementById('order_customer_billingAddress_phone_number').value='0700000000'", "document.getElementById('order_customer_billingAddress_email_email').value='messi96@hotmail.se'", "document.getElementById('order_customer_billingAddress_email_verify_email').value='messi96@hotmail.se'", "document.getElementById('16').click();", "document.getElementById('shipping_13').click();", "document.getElementById('pakkeshop_cont').checked = true;", "document.getElementById('order_customer_gender_male').click();", "document.getElementById('accept_term').click();", "document.getElementById('checkout_form').submit();", "document.getElementById('creditCardNumberInput').value='5226675961216750'", "document.getElementById('cvcInput').value='456'", "document.getElementById('cardholderNameInput').value='hej hejsson'"]

 
    }
    
    func checkout() {
        for js in boozt! {
            self.webView.evaluateJavaScript(js, completionHandler: nil)
            sleep(2)
        }
    }
    
  
    
    
    
    func sendRequest(urlString: String) {
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    func setProductInfo(imageUrl: URL, url: String) {
        self.products.append(imageUrl)
    }
    func getProductInfo() -> [URL] {
        return self.products
    }
    func getProdcuctInCart() -> [URL:String] {
        return self.productsInCart
    }
    func getFavoriteUrl(imageUrl: URL) -> String? {
        let url = productsInCart[imageUrl]
        return url
    }
    
    func setWebView(webView: WKWebView) {
        self.webView = webView
    }
    
    func setTabsViewController(tabView: TabsViewController) {
        self.tabView = tabView
    }
    
    func loadSnapShot(tabView: TabsViewController) {
        webView.takeSnapshot(with: nil) { image, error in
            if let image = image {
                self.setTabImage(image: image, url: currentWebView!, tabView: tabView)
                
                print("Got snapshot")
            } else {
                print("Failed taking snapshot: \(error?.localizedDescription ?? "--")")
            }
        }
    }
    
    func setTabImage(image: UIImage, url: String, tabView: TabsViewController) {
        print(tabView.tabImage.image)
        print(tabView.tabImage1.image)
        if(tabView.tabImage.image == nil) {
            urlAndImage[image] = url
            tabView.tabImage.image = image
            tabView.tabImage.isHidden = false
            print(tabView.tabImage.image)
            print("inside if")
        }
        else if(tabView.tabImage1.image == nil) {
            urlAndImage[image] = url
            tabView.tabImage1.image = image
           // tabView.tabImage1.isHidden = false
        }
        else if(tabView.tabImage2.image == nil) {
            urlAndImage[image] = url
            tabView.tabImage2.image = image
          //  tabView.tabImage2.isHidden = false
        }
        else if(tabView.tabImage3.image == nil) {
            urlAndImage[image] = url
            tabView.tabImage3.image = image
          //  tabView.tabImage3.isHidden = false
        }
        
    }
    
    
}
