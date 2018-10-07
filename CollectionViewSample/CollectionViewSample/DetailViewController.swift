//
//  DetailViewController.swift
//  CollectionViewSample
//
//  Created by Yogesh on 10/7/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableLayout: UITableView!
    weak var movie : MovieModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        tableLayout.rowHeight             = UITableView.automaticDimension
        tableLayout.tableFooterView       = UIView(frame: .zero)
        tableLayout.separatorStyle        = .none
        tableLayout.separatorInset        = .zero
        // Do any additional setup after loading the view.
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

extension DetailViewController  : UITableViewDelegate{
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! DetailCell
        tableViewCell.drawUI(movie : movie!)
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }


}
