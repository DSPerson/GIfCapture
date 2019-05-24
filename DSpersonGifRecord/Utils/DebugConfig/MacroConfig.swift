//
//  MacroConfig.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Foundation
#if DEBUG
#else
func print(object: Any) {}
func println(object: Any) {}
func println() {}

func NSLog(format: String, args: CVarArg...) {}
#endif
