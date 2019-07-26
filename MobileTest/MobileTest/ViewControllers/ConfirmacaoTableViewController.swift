//
//  ConfirmacaoTableViewController.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ConfirmacaoTableViewController: UITableViewController {
    

    @IBOutlet weak var contaOrigemTextField: UIView!
    @IBOutlet weak var contaDestinoTextField: UILabel!
    @IBOutlet weak var valorTextField: UILabel!
    var valorSoma: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valorTextField.text = "\(valorSoma)"
    }

    @IBAction func addUm(_ sender: Any) {
        valorSoma += 1
        valorTextField.text = "\(valorSoma)"
    }
    @IBAction func addCinco(_ sender: Any) {
        valorSoma += 5
        valorTextField.text = "\(valorSoma)"
    }
    @IBAction func addDez(_ sender: Any) {
        valorSoma += 10
        valorTextField.text = "\(valorSoma)"
    }
    @IBAction func confirmar(_ sender: Any) {
        
    }
    
}
