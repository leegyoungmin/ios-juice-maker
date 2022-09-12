//
//  ModifyViewController - ModifyViewController.swift
//  Created by Ash, 미니.
//

import UIKit

protocol ModifyStockDelegate {
	func updateValues(changedStock: [Fruit: Int])
}

class ModifyViewController: UIViewController {
	static let identifier = "presentModifyViewController"
	var inventory: [Fruit: Int] = [:]
	var delegate: ModifyStockDelegate?
    
    @IBOutlet var fruitLabels: [UILabel]!
    @IBOutlet var stockSteppers: [UIStepper]!
    
    override func viewDidLoad() {
		super.viewDidLoad()
		changeNavBackgroundColor()
		setUpLabels()
        setUpStepper()
	}
}

// UI 관련 메서드
private extension ModifyViewController {
    func changeNavBackgroundColor() {
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    func setUpLabels() {
        fruitLabels.compactMap { $0 }.forEach {
            if let fruit = Fruit(rawValue: $0.tag),
               let stock = inventory[fruit]?.description {
                $0.text = stock
            }
        }
    }
    
    func setUpStepper() {
        stockSteppers.compactMap { $0 }.forEach {
            if let fruit = Fruit(rawValue: $0.tag),
               let stock = inventory[fruit] {
                $0.value = Double(stock)
            }
        }
    }
}

// 버튼 관련 메서드
private extension ModifyViewController {
    @IBAction func didTappedStepper(_ sender: UIStepper) {
        if let fruit = Fruit(rawValue: sender.tag) {
            inventory[fruit] = Int(sender.value)
            setUpLabels()
        }
    }
}

// 화면 이동 관련 메서드
private extension ModifyViewController {
    @IBAction func didTapDismissButton(_ sender: UIBarButtonItem) {
        delegate?.updateValues(changedStock: inventory)
        dismiss(animated: true)
    }
}
