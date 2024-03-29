//
//  ConfirmacaoTableViewController.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ConfirmacaoTableViewController: UITableViewController {
    

    @IBOutlet weak var contaOrigemTextField: UILabel!
    @IBOutlet weak var contaDestinoTextField: UILabel!
    @IBOutlet weak var valorTextField: UILabel!
    var contaString: String = ""
    var valorSoma: Double = 0.0
    var bancoGeral: Banco!
    
    var contaOrigem: Conta!
    var contatoDestino: Pessoa!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contaOrigemTextField.text = contaString
        contaDestinoTextField.text = contatoDestino.nome
        
        print("Banco\(bancoGeral.contaPoupanca[0].saldo)")
        
        valorTextField.text = "\(valorSoma)"
        
    }

    
    @IBAction func addUm(_ sender: Any) {
        add(1)
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addCinco(_ sender: Any) {
        add(5)
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addDez(_ sender: Any) {
        add(10)
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addCem(_ sender: Any) {
        add(100)
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addMil(_ sender: Any) {
        add(1000)
        valorTextField.text = "\(valorSoma)"
    }
    
    
    // MARK: - Write JSON
    @IBAction func confirmar(_ sender: Any) {
        
        let alertConfirm = UIAlertController(title: "Confirmaçao", message: "Você deseja transferir R$\(valorSoma) para \(contatoDestino.nome) ?", preferredStyle: .alert)
        let acaoConfirmar = UIAlertAction(title: "Confirmar", style: .default) { (completion) in
            
            let fileName = "Banco.json"
            var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            dir[0].appendPathComponent(fileName)
            
            // Conta Origem
            if (self.contaOrigemTextField?.text!.contains("Poupanca"))! {
                
                for i in self.bancoGeral.contaPoupanca {
                    if self.contaOrigem! === i {
                        i.saldo = String(Double(i.saldo)! - self.valorSoma)
                    }
                }
            } else {
                
                for i in self.bancoGeral.contaCorrente {
                    if self.contaOrigem! === i {
                        i.saldo = String(Double(i.saldo)! - self.valorSoma)
                    }
                }
            }
            
            // Conta Destino (conta corrente vem primeiro)
            var flag: Int = 0
            for i in self.bancoGeral.contaCorrente {
                
                if self.contatoDestino.id == i.id {
                    i.saldo = String(Double(i.saldo)! + self.valorSoma)
                    flag = 1
                }
            }
            if flag != 1 {
                
                for i in self.bancoGeral.contaPoupanca {
                    
                    if self.contatoDestino.id == i.id {
                        i.saldo = String(Double(i.saldo)! + self.valorSoma)
                        flag = 1
                    }
                }
            }
            
            let jsonData = try? JSONEncoder().encode(self.bancoGeral)
            try? jsonData?.write(to: dir[0])
            
            print(dir[0].absoluteString)
        }
        let acaoCancelar = UIAlertAction(title: "Sair", style: .cancel, handler: nil)
        alertConfirm.addAction(acaoConfirmar)
        alertConfirm.addAction(acaoCancelar)
        present(alertConfirm, animated: true, completion: nil)
    }
    
    
    func add(_ valorSoma: Double) {
        print(valorSoma)
        if let saldo = Double(contaOrigem.saldo) {
            if (self.valorSoma + valorSoma > 10000) || (saldo < self.valorSoma + valorSoma ) {
                print("nao foi possivel")
                let alertErro = UIAlertController(title: "Erro", message: "O valor informado é um valor invalido", preferredStyle: .actionSheet)
                let acaoCancelar = UIAlertAction(title: "Sair", style: .destructive, handler: nil)
                alertErro.addAction(acaoCancelar)
                present(alertErro, animated: true, completion: nil)
                return
            }
            self.valorSoma += valorSoma
        }
    }
}
