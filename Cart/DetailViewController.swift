//
//  DetailViewController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-07-18.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
import AlamofireImage

var snapshot: UIImage?
class DetailViewController: UIViewController, UISearchBarDelegate  {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newTab: UIButton!
   
    @IBOutlet weak var webView: WKWebView!
    let sampleURL = "https://developer.apple.com/documentation/webkit/wkwebview/"
    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    private var tabsPage: TabsViewController!
    var counter: Int!
    
   
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(currentWebView == nil) {
            currentWebView = "https://www.google.com"
        }
        
        counter = 0
        //sendRequest(urlString: currentWebView!)
        cartModel.setWebView(webView: webView)
        setToolBar()
        webView.navigationDelegate = self
        searchBar.delegate = self

        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
     
        sendRequest(urlString: currentWebView!)
        

        
    }
   
    
   
    
    @IBAction func backTapped(_ sender: Any) {
        DispatchQueue.main.async {
        self.performSegue(withIdentifier: "unwindToFirstPageSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(TabsViewController.counter > 0) {
            if segue.identifier == "webToTab" {
                if let destinationVC = segue.destination as? TabsViewController{
                    tabsPage = destinationVC
                    
                }
            }
        }
        else {
            if segue.identifier == "tabsSegue" {
                if let destinationVC = segue.destination as? TabsViewController{
                    tabsPage = destinationVC
                    
                }
            }
            
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("hej")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var search = searchBar.text
        if(!search!.contains("www.")) {
            search = "www." + (searchBar.text ?? "google.com")
        }
        else {
            search = searchBar.text ?? "google.com"
        }
        currentWebView = "https://" + search!
        sendRequest(urlString: currentWebView!)
        cartModel.setWebView(webView: webView)
        setToolBar()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }/*
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? shoppingSites : shoppingSites.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            collectionView.reloadData()
        }
    }
    */
    @IBAction func searchButtonPressed(_ sender: Any) {
        var search = searchBar.text
        if(!search!.contains("www.")) {
            search = "www." + (searchBar.text ?? "google.com")
        }
        else {
            search = searchBar.text ?? "google.com"
        }
        currentWebView = "https://" + search!
        sendRequest(urlString: currentWebView!)
        cartModel.setWebView(webView: webView)
        setToolBar()
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        let url = webView.url?.absoluteString
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
        completionHandler: { (html: Any?, error: Error?) in
        do{
            let doc: Document = try SwiftSoup.parse(html as! String)
            let pngs: Elements = try doc.select("img[src$=.jpg]")
            let srcsStringArray: [String?] = pngs.array().map { try? $0.attr("src").description }
            for imgs in srcsStringArray {
                if let imgUrl = imgs {
                    var finalUrl = URL(string: "")
                    if imgUrl.contains("http") {
                        finalUrl = URL(string: String(format: imgUrl))
                        
                   } else {
                            finalUrl = URL(string: String(format: "%@%@", (currentWebView)!, imgUrl))
                            }
                    
                    print(finalUrl)
                    cartModel.setProductInfo(imageUrl: finalUrl!, url: url!)
                    self.imageView.af_setImage(withURL: finalUrl!)
                    print(finalUrl as Any) //debug URL
                    
                            }
                break
             }
             } catch Exception.Error(let type, let message){
                print(type, message)
             } catch {
                print("error")
                }
        })
    }
        /*
        webView.takeSnapshot(with: nil) { image, error in
            if let image = image {
                let favorite = self.tabBarController!.viewControllers![3] as! UINavigationController
                if favorite.topViewController is FavoritesViewController {
                    let f = favorite.topViewController as! FavoritesViewController
                    if(f.isViewLoaded){
                        f.setImage(image: image)
                    }
                    else {
                        cartModel.setFavorite(image: image, url: url!)
                    }
                }
                
                print("Got snapshot")
            } else {
                print("Failed taking snapshot: \(error?.localizedDescription ?? "--")")
            }
        }
       // cartModel.checkout()
        */
        /*
        let boozt = ["document.getElementById('nav-count-cart').click();", "document.getElementById('order_paymentId_2').click()", "document.getElementById('order_customer_billingAddress_firstname').value='hejhej'", "document.getElementById('order_customer_billingAddress_lastname').value='hejson'", "document.getElementById('order_customer_billingAddress_street').setAttribute('value', 'Ekebyvägen 11');", "document.getElementById('order_customer_billingAddress_postcode').setAttribute('value', '75263');", "document.getElementById('order_customer_billingAddress_city').setAttribute('value', 'Uppsala');", "document.getElementById('order_customer_billingAddress_phone_number').value='0700000000'", "document.getElementById('order_customer_billingAddress_email_email').value='messi96@hotmail.se'", "document.getElementById('order_customer_billingAddress_email_verify_email').value='messi96@hotmail.se'", "document.getElementById('16').click();", "document.getElementById('shipping_13').click();", "document.getElementById('pakkeshop_cont').checked = true;", "document.getElementById('order_customer_gender_male').click();", "document.getElementById('accept_term').click();", "document.getElementById('checkout_form').submit();", "document.getElementById('creditCardNumberInput').value='5226675961216750'", "document.getElementById('cvcInput').value='456'", "document.getElementById('cardholderNameInput').value='hej hejsson'"]
        var locked = false
            DispatchQueue.global(qos: .default).async {
                for js in boozt {
                    
                    print("hej")
                    DispatchQueue.main.async {
                        self.webView.evaluateJavaScript(js, completionHandler: nil)
                        print(js)
                        
                    }
                    
                    
                    sleep(5)

                    
                    
                }
 
            }
 

            
        
        
    }
 */
    
    // Convert String into URL and load the URL
    private func sendRequest(urlString: String) {
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
 
 
    
    fileprivate func setToolBar() {
        let screenWidth = self.view.bounds.width
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolBar.isTranslucent = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.items = [backButton]
        webView.addSubview(toolBar)
        // Constraints
        toolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
    }
    @objc private func goBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func setActivityIndicator() {
        // Configure the background containerView for the indicator
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = webView.center.x
        // Need to subtract 44 because WebKitView is pinned to SafeArea
        //   and we add the toolbar of height 44 programatically
        activityIndicatorContainer.center.y = webView.center.y - 44
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
        
        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
    }
    fileprivate func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.removeFromSuperview()
        }
    }
}
extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Set the indicator everytime webView started loading
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
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


