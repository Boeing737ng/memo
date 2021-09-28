//
//  MemoDetailViewController.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import UIKit

class MemoDetailViewController: UIViewController,ViewModelBindableType {
    
    var viewModel: MemoDetailViewModel!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        
    }

}
