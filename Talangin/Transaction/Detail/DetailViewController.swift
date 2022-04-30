//
//  DetailViewController.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol DetailViewControllerDelegate: AnyObject {
    // Delegate method that can be used
    func displayAlert(message:String?)
}

class DetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTableView: UITableView!
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
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Object initialization & Optional
    var dataToBeUpdate: TransactionModel?
    var newDataToBeSave: TransactionModel?
    var isUpdated: Bool = false
    
    // MARK: - delegate object initialization
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        if let data = dataToBeUpdate {
            name.text = data.title
            date.text = DateFormatter.mediumDateFormatter.string(from: data.date)
            if let amount = NumberFormatter.rupiahFormatter.string(from:Int(data.amount) as NSNumber) {
                totalAmount.text = "Rp. \(amount)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.isUpdated {
            let nib = UINib(nibName: "DetailViewCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "detailViewCellID")
        } else {
            let nib2 = UINib(nibName: "NewTransactionView", bundle: nil)
            self.newTableView.register(nib2, forCellReuseIdentifier: "newTransactionViewCellID")
        }
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if self.isUpdated {
                self.delegate?.displayAlert(message:"Uhuy")
            }
        }
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.dataToBeUpdate {
            return data.personsOrders.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isUpdated {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "detailViewCellID", for: indexPath) as? DetailViewCell)!
            if let data = self.dataToBeUpdate {
                cell.personName.text = "\(data.personsOrders[indexPath.row].person.name)'s total"
                if let amount = NumberFormatter.rupiahFormatter.string(from:Int(data.personsOrders[indexPath.row].total) as NSNumber) {
                    cell.totalAmount.text = "Rp. \(amount)"
                }
                
                //cleaning stackView to reuse it
                cell.stackView.subviews.forEach { (view) in
                    if !(view is UILabel) {
                        view.removeFromSuperview()
                    }
                }
                
                //Adding custom views to the stackView
                for order in data.personsOrders[indexPath.row].orders {
                    let nib = DetailTransactionView()
                    nib.name.text = order.name
                    nib.quantity.text = "x\(order.quantity)"
                    if let amount = NumberFormatter.rupiahFormatter.string(from:Int(order.amount) as NSNumber) {
                        nib.amount.text = "Rp. \(amount)"
                    }
                    
                    
                    let border = UIView()
                    border.backgroundColor = .gray
                    border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                    border.frame = CGRect(x: 20, y: 0, width: 374, height: 1)
                    cell.stackView.addSubview(border)
                    
                    cell.stackView.addArrangedSubview(nib)
                }
            }
            cell.selectionStyle = .none
            
            return cell
        }
        let cell = (tableView.dequeueReusableCell(withIdentifier: "newTransactionViewCellID", for: indexPath) as? NewTransactionView)!
        let nib = OrderViewCell()
        cell.stackView.addArrangedSubview(nib)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
