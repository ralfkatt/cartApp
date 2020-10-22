//
//  FirstPageViewController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-09-29.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit
var currentWebView: String?
var cartModel = CartModel()
class FirstPageViewController: UIViewController {

    @IBOutlet weak var textSearch: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
   
    @IBOutlet weak var cart: UIButton!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 10
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 32)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        let timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toCart(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: self)
    }
    @IBAction func unwindToFirstPage(segue:UIStoryboardSegue) { }

    
    @objc func update() {
        // Something cool
        self.searchButton.titleLabel?.animate(newText: "Search for stores", characterDelay: 0.2)

    }
    
    @IBAction func searchTapped(_ sender: Any) {
        performSegue(withIdentifier: "searchSegue", sender: self)

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

extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
    
}
