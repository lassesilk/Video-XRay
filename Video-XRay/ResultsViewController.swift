//
//  ResultsViewController.swift
//  Video-XRay
//
//  Created by Lasse Silkoset on 26/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

import AVKit
import UIKit

protocol ResultsDelegate: class {
    func getReadyForNewRecording()
}

class ResultsViewController: UITableViewController {
    var movieURL: URL!
    var predictions: [(time: CMTime, prediction: String)]!
    
    weak var delegate: ResultsDelegate?
    
    //var prob: [String: Double] = [String: Double]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getReadyForNewRecording()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let prediction = predictions[indexPath.row]
        
       
        cell.textLabel?.text = prediction.prediction
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayer(url: movieURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        let prediction = predictions[indexPath.row]
        player.seek(to: prediction.time)

        present(playerViewController, animated: true)
    }
}

