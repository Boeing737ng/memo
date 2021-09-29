//
//  MemoDetailViewController.swift
//  memo
//
//  Created by Kihyun Choi on 2021/09/24.
//

import UIKit
import RxSwift

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
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
    }

}
