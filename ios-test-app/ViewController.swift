//
//  ViewController.swift
//  ios-test-app
//
//  Created by Zomato on 26/06/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let cellReuseID = "cellID"
    let tableView = UITableView(frame: .zero)
    
    let titles = ["1st", "2nd", "3rd", "4th"]
    let subtitles = ["a", "b", "c", "d"]
    
    var cellArray: [CellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.backgroundColor = .orange
//        createLabel()
//        createView()
        loadDummyData()
        
        tableView.dataSource = self
        tableView.delegate = self
        createTableView()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellReuseID)
    }
    
    private func loadDummyData() {
        for i in 0..<5 {
            cellArray.append(CellData(title: "Restaurant \(i+1)", subtitle: "Cuisine \(i+1)", image: UIImage(named: "food1")))
        }
    }

    func createLabel()  {
        let myLabel = UILabel()
        myLabel.text = "vishalvishalvishalvishalvishalvishalvishalvishalvishalvishalvishalvishalvishalvishal";
        myLabel.backgroundColor = .green
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        
        view.addSubview(myLabel)
//        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
//        myLabel.set(.leading(view, 10), .trailing(view, 10), .centerX(view), .centerY(view))
        
        myLabel.set(.centerView(view), .sameLeadingTrailing(view, 10))

    }
    
    fileprivate func createView() {
        let paddingConst: CGFloat = 8
        
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        
        redView.set(.top(view, 6*paddingConst),
                    .leading(view, paddingConst),
                    .width(140),
                    .height(140))
        
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        view.addSubview(greenView)
    
        greenView.set(.top(redView),
                      .after(redView, paddingConst),
                      .trailing(view, paddingConst),
                      .height(140))
        
        
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        view.addSubview(orangeView)
        
        orangeView.set(.below(redView, paddingConst),
                       .trailing(view, paddingConst),
                       .height(140),
                       .width(140))
        
        let purpleView = UIView()
        purpleView.backgroundColor = .purple
        view.addSubview(purpleView)
        
        purpleView.set(.before(orangeView, paddingConst),
                       .below(redView, paddingConst),
                       .leading(view, paddingConst),
                       .height(140))
        
        let blackView = UIView()
        blackView.backgroundColor = .black
        view.addSubview(blackView)
        
        blackView.set(.below(purpleView, paddingConst),
                      .leading(view, paddingConst),
                      .trailing(view, paddingConst),
                      .height(140))
    }
    
    func createTableView()  {
        view.addSubview(tableView)
        tableView.set(.fillSuperView(view))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! TableViewCell
        
        cell.setData(cellData: cellArray[indexPath.row])
//        cell.setData(titleText: titles[indexPath.row], subtitleText: subtitles[indexPath.row], image: UIImage())
        return cell
    }
    
    // todo
    // struct
    // use struct in tableView
    // also populate image
    

}

