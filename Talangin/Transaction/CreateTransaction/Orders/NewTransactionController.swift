//
//  CreateTransactionController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol NewTransactionControllerDelegate: AnyObject {
    // Delegate method that can be used
    func displayAlert(message:String?)
}

class NewTransactionController: UIViewController, UITextFieldDelegate, NewTransactionViewDelegate, MemberTransactionControllerDelegate {
    
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
    @IBOutlet weak var eventTitle: UITextField!
    
    // MARK: - Object initialization & Optional
    var newDataToBeSave: TransactionModel?
    var isUpdated: Bool = false
    var listNewOrders: [OrderModel] = []
    var orderCount: Int = 1
    
    // MARK: - delegate object initialization
    weak var delegate: NewTransactionControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        eventTitle.layer.cornerRadius = 8.0;
        eventTitle.layer.masksToBounds = true;
        eventTitle.layer.borderColor = UIColor.black.cgColor;
        eventTitle.layer.borderWidth = 0.3;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib2 = UINib(nibName: "NewTransactionView", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "newTransactionViewCellID")
        eventTitle.delegate = self
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderToMember" {
            let member = segue.destination as? MemberTransactionController
            // since we already subscribe the delegate from second page, we need to connect it to here
            member?.delegate = self
        }
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.delegate?.displayAlert(message:"Ahay")
        self.performSegue(withIdentifier: "orderToMember", sender: self)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        eventTitle.text = ""
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            // Since our textview text it's an optional, which possible to have a nil, then we need to use it savely
            if let storyHasSomething = eventTitle.text {
                print(storyHasSomething)
            }
            eventTitle.resignFirstResponder()
            return false
        }
        return true
    }
    
    func addMoreRow() {
        self.orderCount += 1
        self.tableView.reloadData()
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
        print("close")
    }
}

extension NewTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "newTransactionViewCellID", for: indexPath) as? NewTransactionView)!
        
        let nib = TransactionView()
        nib.name.text = "Items \(orderCount)"
        nib.price.text = "0"
        nib.quantity.text = "0"
        nib.amount.text = "0"
        cell.stackView.addArrangedSubview(nib)
        
        if orderCount < 2 {
            let border = UIView()
            border.backgroundColor = .gray
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            border.frame = CGRect(x: 20, y: 0, width: 374, height: 1)
            cell.stackView.addSubview(border)
        }
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
