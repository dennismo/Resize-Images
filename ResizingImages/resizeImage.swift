//
//  resizeImg.swift
//  ResizingImages
//
//  Created by Dennis Mo on 2017-08-31.
//  Copyright © 2017 Dennis Mo. All rights reserved.
//

import Foundation
import Cocoa

class resizeImage{
    

    public var selectedFolder = FileManager.default.homeDirectoryForCurrentUser
    private var saveFolder = FileManager.default.homeDirectoryForCurrentUser
    public var width:CGFloat = 0.0
    public var height:CGFloat = 0.0
    private var urls = [URL]()
    public var sizeOption = "Scale to fit"
    
    
    func search(view: NSView,folderPath: NSTextField){
        guard let window = view.window else {return}
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.beginSheetModal(for: window){ (result) in
            if result == NSFileHandlingPanelOKButton{
                self.selectedFolder = panel.urls[0]
                folderPath.stringValue = self.selectedFolder.path
            }
        }
    }
    
    func save(view: NSView){
        guard let window = view.window else { return }
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        panel.beginSheetModal(for: window) { (result) in
            if result == NSFileHandlingPanelOKButton,
                let url = panel.url {
                    self.saveFolder = url
            }
        }
    }
    

    func contentsOf(folder : URL){
        let fileManager = FileManager.default
        do{
            let contents = try fileManager.contentsOfDirectory(atPath: folder.path)
            urls = contents.map{ return folder.appendingPathComponent($0)}
            
        }
        catch{
            urls = []
        }
    }
    
    func loadImages(view: NSView){
        contentsOf(folder: selectedFolder)
        print("\(self.width),\(self.height)")
        print("sizeOption\(sizeOption)")
        let count = urls.count
        var i = 0
        let imageSize = NSMakeSize(width, height)
        while(i < count){
            var MyImage = NSImage(byReferencing: urls[i])
            let name = urls[i].lastPathComponent
            if sizeOption == "Scale to fit" {
                MyImage = MyImage.resizeWhileMaintainingAspectRatioToSize(size: imageSize)!
            }
            else{
                MyImage = MyImage.crop(size: imageSize)!
            }
            let imageName = saveFolder.appendingPathComponent(name)
            if MyImage.pngWrite(to: imageName, options: .withoutOverwriting) {
                print("File saved")
            }
            print(urls[i].path)
            i += 1

        }
    }
    
    
}

