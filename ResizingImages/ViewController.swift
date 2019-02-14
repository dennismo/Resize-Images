//
//  ViewController.swift
//  ResizingImages

//  Created by Dennis Mo on 2017-08-31.
//  Copyright © 2017 Dennis Mo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var resize: resizeImage = resizeImage()
    

    @IBAction func resizeOption(_ sender: NSPopUpButton) {
        self.resize.sizeOption = sender.selectedItem!.title
    }

    @IBOutlet weak var folderPath: NSTextField!
    @IBAction func width(_ sender: NSTextFieldCell) {
        print(sender.floatValue)
        resize.width = CGFloat(sender.floatValue)
    }
 
    @IBAction func height(_ sender: NSTextFieldCell) {
        print(sender.floatValue)
        resize.height = CGFloat(sender.floatValue)
    }
    
    @IBAction func saveFolder(_ sender: NSButton) {
        self.resize.save(view: view)
    }
    
    
    @IBAction func resizeImg(_ sender: NSButton){
        self.resize.loadImages(view: view)
    }
    
    
    @IBAction func searchFolder(_ sender: NSButton) {
        self.resize.search(view: view,folderPath: folderPath)
     
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

