//
//  Pipe.swift
//  Brain---- Compiler
//
//  Created by Hanniel C. Malonzo on 5/26/16.
//  Copyright © 2016 Hanniel C. Malonzo. All rights reserved.
//

import Foundation
import Darwin

struct Pipe {
    //place data is to be held in
    let file: UnsafeMutablePointer<FILE>
}

extension Pipe: OutputStreamType {
    mutating func write(string: String) {
        fputs(string, file)
    }
}

extension Pipe {
    mutating func read() -> Int32 {
        return getc(file)
    }
}

extension Pipe {
    static var stdin: Pipe {
        return Pipe(file: __stdinp)
    }
    
    static var stdout: Pipe {
        return Pipe(file: __stdoutp)
    }
    
    static var stderr: Pipe {
        return Pipe(file: __stderrp)
    }
}