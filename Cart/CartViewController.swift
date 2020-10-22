//
//  CartViewController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-09-30.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit
import AlamofireImage

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var products: [URL] = []
    var productTitles: [String] = ["Jacka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        products = cartModel.getProductInfo()
        
       // let productsInCat = cartModel.getProdcuctInCart()
       /* for(image, url) in productsInCat {
          //  products.append(imageUrl)
        }
 */
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        products = cartModel.getProductInfo()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func setProductsInCart(url: URL) {
        products.append(url)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    // create a cell for each table view row
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        print("hejhej")
        print(products[indexPath.row])
        cell.productPic.af_setImage(withURL: products[indexPath.row])
      //  cell.productPic.image = products[indexPath.row]
        cell.productText.text = "hejhej"
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

    


