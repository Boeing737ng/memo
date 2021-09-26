//
//  MemoListViewController.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
  
    var viewModel: MemoListViewModel!
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo,
                cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
    }

}
