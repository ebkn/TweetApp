//
//  ViewController.swift
//  TweetApp
//
//  Created by Ebinuma Kenichi on 2017/09/10.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var backgroundTweetView: UIView!
    var textField: UITextField!
    var textView: UITextView!

    var tweetArray: Array<Dictionary<String, String>> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        let tweet = tweetArray[indexPath.row]

        let nameLabel = cell.viewWithTag(1) as! UILabel
        nameLabel.text = tweet["name"]
        nameLabel.font = UIFont(name: "HirakakuProN-W6", size: 13)

        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = tweet["text"]
        textLabel.font = UIFont(name: "HirakakuProN-W6", size: 18)

        let timeLabel = cell.viewWithTag(3) as! UILabel
        timeLabel.text = tweet["time"]
        timeLabel.font = UIFont(name: "HirakakuProN-W3", size: 10)
        timeLabel.textColor = UIColor.gray

        let myImageView = cell.viewWithTag(4) as! UIImageView
        myImageView.image = UIImage(named: "pug.png")
        myImageView.layer.cornerRadius = 3
        myImageView.layer.masksToBounds = true

        return cell
    }

    @IBAction func tapTweetButton(_ sender: Any) {
        backgroundTweetView = makeBackgroundTweetView()
        self.view.addSubview(backgroundTweetView)

        let tweetView = makeTweetView()
        backgroundTweetView.addSubview(tweetView)

        textField = makeTextField()
        tweetView.addSubview(textField)

        textView = makeTextView()
        tweetView.addSubview(textView)

        let nameLabel = makeLabel("名前", y: 5)
        tweetView.addSubview(nameLabel)

        let tweetLabel = makeLabel("ツイート", y: 85)
        tweetView.addSubview(tweetLabel)

        let cancelButton = makeCancelButton(tweetView)
        tweetView.addSubview(cancelButton)

        let submitButton = makeSubmitButton()
        tweetView.addSubview(submitButton)
    }

    func tappedCancelButton(_ sender: AnyObject) {
        backgroundTweetView.removeFromSuperview()
    }

    func tappedSubmitButton(_ sender: AnyObject) {
        let name = textField.text!
        let text = textView.text!

        var tweetDictionary: Dictionary<String, String> = [:]
        tweetDictionary["name"] = name
        tweetDictionary["text"] = text
        tweetDictionary["time"] = getCurrentTime()
        tweetArray.insert(tweetDictionary, at: 0)

        backgroundTweetView.removeFromSuperview()
        textField.text = ""
        textView.text = ""
        tableView.reloadData()
    }

    func getCurrentTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd' 'HH:mm:ss"

        return formatter.string(from: now)
    }

    func makeBackgroundTweetView() -> UIView {
        let backgroundTweetView = UIView()
        backgroundTweetView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        backgroundTweetView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)

        return backgroundTweetView
    }

    func makeTweetView() -> UIView {
        let tweetView = UIView()
        tweetView.frame.size = CGSize(width: 300, height: 300)
        tweetView.center.x = self.view.center.x
        tweetView.center.y = 250
        tweetView.backgroundColor = UIColor.white
        tweetView.layer.shadowOpacity = 0.3
        tweetView.layer.cornerRadius = 3

        return tweetView
    }

    func makeTextField() -> UITextField {
        textField = UITextField()
        textField.frame = CGRect(x: 10, y: 40, width: 280, height: 40)
        textField.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect

        return textField
    }

    func makeTextView() -> UITextView {
        textView = UITextView()
        textView.frame = CGRect(x: 10, y: 120, width: 280, height: 110)
        textView.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1

        return textView
    }

    func makeLabel(_ text: String, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: 10, y: y, width: 280, height: 40))
        label.text = text
        label.font = UIFont(name: "HiraKakuProN-W6", size: 15)

        return label
    }

    func makeCancelButton(_ tweetView: UIView) -> UIButton {
        let cancelButton = UIButton()
        cancelButton.frame.size = CGSize(width: 20, height: 20)
        cancelButton.center.x = tweetView.frame.width - 15
        cancelButton.center.y = 15
        cancelButton.setBackgroundImage(UIImage(named: "cancel.png"), for: UIControlState.normal)
        cancelButton.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        cancelButton.layer.cornerRadius = cancelButton.frame.width / 2
        cancelButton.addTarget(self, action: #selector(ViewController.tappedCancelButton(_:)), for: UIControlEvents.touchUpInside)

        return cancelButton
    }

    func makeSubmitButton() -> UIButton {
        let submitButton = UIButton()
        submitButton.frame = CGRect(x: 10, y: 250, width: 280, height: 40)
        submitButton.setTitle("送信", for: UIControlState.normal)
        submitButton.titleLabel?.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        submitButton.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        submitButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        submitButton.layer.cornerRadius = 7
        submitButton.addTarget(self, action: #selector(ViewController.tappedSubmitButton(_:)), for: UIControlEvents.touchUpInside)

        return submitButton
    }
}
