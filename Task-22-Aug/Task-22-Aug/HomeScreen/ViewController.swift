//
//  ViewController.swift
//  Task-21-Aug
//
//  Created by Mac on 21/08/23.
//

import UIKit

enum HomeScreenConstants: Int {
    case numberOfRows = 3
    case rowHeight = 475
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
    }

    private func registerXib() {
        let nibName = UINib(nibName: "PlayTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "PlayTableViewCell")
    }
    
    private func moveToDetailsScreen() {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HomeScreenConstants.numberOfRows.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayTableViewCell", for: indexPath) as? PlayTableViewCell else {return UITableViewCell()}
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(HomeScreenConstants.rowHeight.rawValue)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToDetailsScreen()
    }
}
