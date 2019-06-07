//
//  main.swift
//  Lodjinha
//
//  Created by Guilherme Bayma on 04/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import func Foundation.NSStringFromClass
import func UIKit.UIApplicationMain

#if TEST
let kAppDelegateClass: String? = nil
#else
let kAppDelegateClass = NSStringFromClass(AppDelegate.self)
#endif

_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, kAppDelegateClass)
