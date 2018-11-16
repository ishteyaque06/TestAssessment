//
//  ViewController.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 15/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class MostViewedHomeViewController: UIViewController {
    let tableView=UITableView()
    var jsonData=[MostpopularModel]()
    var activityIndicatorView: UIActivityIndicatorView!
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor),tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName:String(describing: MostPopularTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MostPopularTableViewCell.self))
        tableView.delegate=self
        tableView.dataSource=self
        tableView.showsVerticalScrollIndicator=false
        tableView.showsHorizontalScrollIndicator=false
        tableView.backgroundColor=UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        tableView.bouncesZoom=false
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView=UIView(frame: .zero)
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped=true
        tableView.backgroundView = activityIndicatorView
        populateNewsData()
    }
    
    func populateNewsData(){
        activityIndicatorView.startAnimating()
       let _ = APIClient.sharedClient.load(path: EndPoint.mostviewedNews.rawValue, method: .get, params: [:]) { (newsdata, error) in
        if error != nil{
            DispatchQueue.main.async {
                self.showAlert(message: error?.errorDescription)
            }
            return
        }else{
            if let jsonData=newsdata as? [String:Any]{
                if let result=jsonData["results"]as?[[String:Any]]{
                    for res in result{
                        if let model=MostpopularModel(jsonData: res){
                        self.jsonData.append(model)
                        }
                    }
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title="NY Times More Popular"
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.title=""
    }

}

extension MostViewedHomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: String(describing: MostPopularTableViewCell.self), for: indexPath)as?MostPopularTableViewCell else {
            return UITableViewCell()
        }
        cell.mostPopular=self.jsonData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.navigateToDetails(index: indexPath.row)
    }
   
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.navigateToDetails(index: indexPath.row)
    }
    func navigateToDetails(index:Int){
        let detailsVc=DetailsViewController()
        detailsVc.newsData=self.jsonData[index]
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
}
