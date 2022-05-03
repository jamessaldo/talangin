//
//  MemberOrderController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol MemberOrderTransactionControllerDelegate: AnyObject {
    // Delegate method that can be used
    //    func displayAlert(message:String?)
    func dismissModal()
}

class MemberOrderTransactionController: UIViewController, UITextFieldDelegate, MemberOrderTransactionViewDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.drawARoundedCorner()
            cancelButton.drawABorder()
        }
    }
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    // MARK: - Object initialization & Optional
    var newDataToBeSave: TransactionModel?
    var isUpdated: Bool = false
    var listNewOrders: [OrderModel] = []
    var orderCount: Int = 1
    
    // MARK: - delegate object initialization
    weak var delegate: MemberOrderTransactionControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "MemberOrderTransactionView", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "memberOrderTransactionViewCellID")
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.dismissModal()
        }
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addMoreRow() {
        self.orderCount += 1
        self.tableView.reloadData()
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
}

extension MemberOrderTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "memberOrderTransactionViewCellID", for: indexPath) as? MemberOrderTransactionView)!
        
        let nib = MemberOrder()
        nib.name.text = "Items \(orderCount)"
        nib.price.text = "0"
        nib.quantity.text = "0"
        nib.amount.text = "0"
        cell.stackView.addArrangedSubview(nib)
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        if orderCount < 2 {
            let border = UIView()
            border.backgroundColor = .gray
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            border.frame = CGRect(x: 20, y: 0, width: 374, height: 1)
            cell.stackView.addSubview(border)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

