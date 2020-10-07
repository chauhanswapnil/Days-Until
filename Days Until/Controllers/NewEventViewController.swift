//
//  NewEventViewController.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 02/10/20.
//

import UIKit
import YPImagePicker
import RealmSwift

class NewEventViewController: UIViewController {

    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = Date()
        configImagePicker()
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        eventImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eventImageViewTapped)))
        saveLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveLabelTapped)))
    }
    
    @objc func saveLabelTapped() {
        let alertController = UIAlertController(title: "Error", message: "Please input all fields correctly!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        if let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if title == "" {
                present(alertController, animated: true, completion: nil)
            } else {
                if ( imageData == nil ) {
                    present(alertController, animated: true, completion: nil)
                } else {
                    let newEvent = Event()
                    newEvent.title = title
                    newEvent.date = datePicker.date
                    newEvent.image = imageData
                    let realm = try! Realm()
                    do {
                        try realm.write {
                            realm.add(newEvent)
                        }
                        dismiss(animated: true, completion: nil)
                    } catch {
                        let alertController = UIAlertController(title: "Error", message: "An internal error occured.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                        present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func configImagePicker() {
        var config = YPImagePickerConfiguration()
        config.shouldSaveNewPicturesToAlbum = true
        YPImagePickerConfiguration.shared = config
    }
    
    @objc func eventImageViewTapped() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
                self.eventImageView.contentMode = .scaleAspectFill
                if let mod = photo.modifiedImage {
                    self.eventImageView.image = mod
                    self.imageData = mod.pngData()
                } else {
                    self.eventImageView.image = photo.originalImage
                    self.imageData = photo.originalImage.pngData()
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @objc func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
