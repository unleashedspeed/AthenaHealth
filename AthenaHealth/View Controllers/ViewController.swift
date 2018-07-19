//
//  ViewController.swift
//  AthenaHealth
//
//  Created by Saurabh Gupta on 19/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Severity: String {
        case normal = "NORMAL"
        case abnormal = "ABNORMAL"
        case neutral = "NEUTRAL"
    }
    
    @IBOutlet weak var backPainButton: UIButton! {
        didSet {
            backPainButton.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var allNormalButton: UIButton! {
        didSet {
            allNormalButton.layer.cornerRadius = 4
            allNormalButton.layer.borderWidth = 0.5
            allNormalButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var clearAllSectionsButton: UIButton!{
        didSet {
            clearAllSectionsButton.layer.cornerRadius = 4
            clearAllSectionsButton.layer.borderWidth = 0.5
            clearAllSectionsButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var patientButton: UIButton! {
        didSet {
            patientButton.layer.cornerRadius = 4
            patientButton.layer.borderWidth = 0.5
            patientButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .none
            tableView.register(SentenceTableViewCell.nib(), forCellReuseIdentifier: cellIdentifier)
            tableView.register(SectionFooterView.nib(), forCellReuseIdentifier: "FooterView")
        }
    }
    
    let cellIdentifier = "SentenceCell"
    var records: Record?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.standard.getRecords { (records, error) in
            if error == nil {
                self.records = records
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // Do error handling here
                print(error)
            }
        }
    }
    
}

extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return records?.hpi?.first?.sentences?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.hpi?.first?.sentences?[section].findings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SentenceTableViewCell
        let finding = records?.hpi?.first?.sentences?[indexPath.section].findings?[indexPath.row]
        cell.findingButton.setTitle(finding?.genericFindingName, for: .normal)
        switch finding?.findingType {
        case Severity.abnormal.rawValue:
            cell.findingButton.layer.borderColor = UIColor.red.cgColor
        case Severity.normal.rawValue:
            cell.findingButton.layer.borderColor = UIColor.green.cgColor
        case Severity.neutral.rawValue:
            cell.findingButton.layer.borderColor = UIColor.blue.cgColor
        case .none:
            break
        case .some(_):
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return records?.hpi?.first?.sentences?[section].sentenceName
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCell(withIdentifier: "FooterView") as! SectionFooterView

        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

