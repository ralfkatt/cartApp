//
//  ViewController.swift
//  Cart
//
//  Created by Oscar Englöf on 2019-07-18.
//  Copyright © 2019 Oscar Englöf. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UISearchResultsUpdating, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UISearchControllerDelegate {
   
    

    @IBOutlet weak var ZalandoButton: UIButton!
    @IBOutlet weak var BooztButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    // @IBOutlet weak var searchBar: UITextField!
    
    let shoppingSites = ["Boozt", "Zalando", "Asos", "Nike", "Apotea"]
    
    let siteToUrl: [String: String] = ["Boozt":"Boozt.com", "Zalando":"Zalando.com", "Asos":"Asos.com", "Nike":"Nike.com", "Apotea":"Apotea.se"]
    
    var filteredData: [String]!
    var searchController: UISearchController!

   
    var array = ["First Cell", "Second Cell", "Third Cell", "Fourth Cell", "Fifth Cell"]

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartModel.start()
        //Search at the top
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.isActive = true
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        
        
        self.navigationItem.titleView = searchController.searchBar
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        filteredData = shoppingSites
       

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }

    }
    
   
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        let shoppingSite = shoppingSites[indexPath!.item]
        let url = siteToUrl[shoppingSite]
        currentWebView = "https://" + url!
        performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchController.searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchController.searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchController.searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CollectionViewCell
        cell.shoppingSite.text = filteredData[indexPath.row]
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))

        return cell
    }
 
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? shoppingSites : shoppingSites.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            collectionView.reloadData()
        }
    }
    
    @IBAction func ZalandoPressed(_ sender: Any) {
        currentWebView = "https://www.zalando.se/man-home/"
        tabBarController?.selectedIndex = 1
        
        //performSegue(withIdentifier: "webbSegue", sender: self)
    }
    
    @IBAction func BooztPressed(_ sender: Any) {
        currentWebView = "https://www.boozt.com/se/sv"
        tabBarController?.selectedIndex = 1
        //performSegue(withIdentifier: "webbSegue", sender: self)
    }
    

    
    @IBAction func searchButton(_ sender: Any) {
        var search = searchBar.text
        if(!search!.contains("www.")) {
            search = "www." + (searchBar.text ?? "google.com")
        }
        else {
            search = searchBar.text ?? "google.com"
        }
        currentWebView = "https://" + search!
        tabBarController?.selectedIndex = 1
        //performSegue(withIdentifier: "webbSegue", sender: self)
    }
    
}

