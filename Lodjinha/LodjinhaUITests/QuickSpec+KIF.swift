//
//  QuickSpec+KIF.swift
//  LodjinhaUITests
//
//  Created by Guilherme Bayma on 09/06/19.
//  Copyright © 2019 Guilherme Bayma. All rights reserved.
//

import KIF
import Quick

extension QuickSpec {
    var system: KIFSystemTestActor {
        return system()
    }

    var tester: KIFUITestActor {
        return tester()
    }

    var viewTester: KIFUIViewTestActor {
        return viewTester()
    }

    // MARK: Private functions

    private func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        KIFEnableAccessibility()

        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

    private func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        KIFEnableAccessibility()

        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    private func viewTester(_ file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        KIFEnableAccessibility()

        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
}
