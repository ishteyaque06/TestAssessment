//
//  ViewController.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 15/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class MostViewedHomeViewController: UIViewController {
let imageURL="https://www.nytimes.com/2018/11/14/technology/facebook-data-russia-election-racism.html?action=click&module=Top%20Stories&pgtype=Homepage"
    let tableView=UITableView()
    var jsonData=[MostpopularModel]()
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
        populateData()
    }

    func populateData(){
        jsonData.append(MostpopularModel(popularTitle: "Sherrod Brown: Rumpled, Unvarnished and Just Maybe a Candidate for President,Delay, Deny and Deflect: How Facebook’s Leaders Fought Through Crisis", authorTitle: " By Sydney Ember", dateLabel: "Nov. 14, 2018", imageUrl: imageURL))
        jsonData.append(MostpopularModel(popularTitle: "Sherrod Brown: Rumpled, Unvarnished and Just Maybe a Candidate for President", authorTitle: "By Sheera Frenkel, Nicholas Confessore, Cecilia Kang, Matthew Rosenberg and Jack Nicas", dateLabel: "Nov. 14, 2018", imageUrl: imageURL))
        jsonData.append(MostpopularModel(popularTitle: "Sherrod Brown: Rumpled, Unvarnished and Just Maybe a Candidate for President,Delay, Deny and Deflect: How Facebook’s Leaders Fought Through Crisis", authorTitle: "By Sheera Frenkel, Nicholas Confessore, Cecilia Kang, Matthew Rosenberg and Jack Nicas", dateLabel: "Nov. 14, 2018", imageUrl: imageURL))
        jsonData.append(MostpopularModel(popularTitle: "Sherrod Brown: Rumpled, Unvarnished and Just Maybe a Candidate for President,Delay, Deny and Deflect: How Facebook’s Leaders Fought Through Crisis", authorTitle: "By Sydney Ember", dateLabel: "Nov. 14, 2018", imageUrl: imageURL))
        jsonData.append(MostpopularModel(popularTitle: "Sherrod Brown: Rumpled, Unvarnished and Just Maybe a Candidate for President", authorTitle: "By Sheera Frenkel, Nicholas Confessore, Cecilia Kang, Matthew Rosenberg and Jack Nicas", dateLabel: "Nov. 14, 2018", imageUrl: imageURL))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title="NY Times More Popular"
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
   
}
