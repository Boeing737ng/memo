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
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
        addButton.rx.action = viewModel.makeCreateAction()
        
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
            // .do -> subscribe 시점이 아닌 이벤트 발생시점에 처리할 작업이 있을때 사용
            .do(onNext: {[unowned self] (_, indexPath) in
                self.listTableView.deselectRow(at: indexPath, animated: true)
            }).map { $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
        
        listTableView.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
        
    }

}
