//
//  MainViewController.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 02/10/20.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var newEventImageView: UIImageView!
    @IBOutlet weak var settingsImageView: UIImageView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        newEventImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newEventTapped)))
        
        settingsImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsTapped)))
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Will Appear")
        getData()
    }
    
    func getData() {
        let realm = try! Realm()
        let events = realm.objects(Event.self)
        self.events = Array(events)
        if (self.events.count == 0) {
            DispatchQueue.main.async {
                self.eventTableView.isHidden = true
            }
        } else {
            DispatchQueue.main.async {
                self.eventTableView.isHidden = false
                self.eventTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventTableViewCell
        cell.eventImageView.layer.cornerRadius = 10.0
        cell.eventImageView.image = UIImage(data: events[indexPath.row].image!)
        cell.eventLabel.text = events[indexPath.row].title
        cell.daysLabel.text = getDaysString(from: events[indexPath.row].date)
        cell.uuid = events[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
        if (editingStyle == .delete) {
            let realm = try! Realm()
            let predicate = NSPredicate(format: "id = %@", cell.uuid)
            if let object = realm.objects(Event.self).filter(predicate).first {
                try! realm.write {
                    realm.delete(object)
                }
                getData()
            }
        }
    }
    
    func getDaysString(from date: Date) -> String {
        let days = daysBetween(start: Date(), end: date)
        if (days < 0) {
            let pos = abs(days)
            if (days == -1) {
                return "1 Day Ago"
            }
            return "\(pos) Days Ago"
        } else {
            if (days == 1) {
                return "In 1 Day"
            }
            return "In \(days) Days"
        }
    }
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    @objc func newEventTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewEventVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func settingsTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingsVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
