//
//  DetailsViewController.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    let tableView=UITableView()
    var newsData:MostpopularModel!
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor),tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName:String(describing: DetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DetailsTableViewCell.self))
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
    }
    

}

extension DetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: String(describing: DetailsTableViewCell.self), for: indexPath)as?DetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.mostPopular=self.newsData
        return cell
    }
    
}
