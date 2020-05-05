//
//  ViewController.swift
//  ShareFlag
//
//  Created by Александра Наврузова on 03.05.2020.
//  Copyright © 2020 Alexandra Navruzova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags: [(name: String, flag: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasSuffix("png") {
                let name = item.components(separatedBy: ".png")[0].uppercased()
                flags.append((name, item))
            }
        }
        print(flags)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row].name
        cell.imageView?.image = UIImage(named: flags[indexPath.row].flag)
        cell.imageView?.layer.borderWidth = 0.1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView?.layer.cornerRadius = 5
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row].flag
            vc.selectedCountry = flags[indexPath.row].name
            vc.selectedImageNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
}

