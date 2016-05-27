//
//  ViewController.swift
//  BASIC Compiler
//
//  Created by Hanniel C. Malonzo on 5/16/16.
//  Copyright © 2016 Hanniel C. Malonzo. All rights reserved.
//

import UIKit
import Darwin

//foreword: This program is unfinished. A lot of this code was taken from different places (open source programs, specifically) because of deadlines and my ineptitude in programming complex things. I plan to rewrite it in the future so that I know what I am doing and can develop the app further.

//TODO: link textview to console

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var fileView: UITextView!
    @IBOutlet weak var consoleView: UITextView!
    
    var saveFile = ""
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        saveFile = fileView.text
        print(saveFile)
        return true
    }
    
    
    
    @IBAction func Execute(sender: UIButton) {
        
        if case let args = Process.arguments where args.count > 1, case let file = args[1] {
            if case let fd = fopen(file, "rb") where fd != nil {
                defer { fclose(fd) }
                fseek(fd, 0, SEEK_END)
                let fileSize = ftell(fd)
                fseek(fd, 0, SEEK_SET)
                var buffer = UnsafeMutablePointer<CChar>.alloc(fileSize)
                defer { buffer.destroy() }
                if fread(buffer, sizeof(CChar), fileSize, fd) == fileSize {
                    buffer[fileSize] = 0
                    if let program = String.fromCString(buffer) {
                        if let vm = VM(program: program) {
                            vm.run()
                            exit(EXIT_SUCCESS)
                        }
                        else {
                            print("Invalid BF program in '\(file)'.")
                        }
                    }
                }
            }
            print("Failed to open file '\(file)'.")
            exit(EXIT_FAILURE)
        }
        else {
            text += "> \n"
            print("> ", terminator: "")
            var input = ""
            while let line = readLine() {
                input += line
            }
            if let vm = VM(program: input) {
                vm.run()
            }
            else {
                print("Invalid BF program")
                exit(EXIT_FAILURE)
            }
        }
        
        
        
        let source = fileView.text
        VM(program: source)!.run()
        
    }
    
    
    
    //when the text value changes
    //save text file
    //save date and time of edit
    //execute program
    
    }

    //nodes



