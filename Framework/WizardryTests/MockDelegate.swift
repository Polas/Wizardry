//
//  MockDelegate.swift
//  Wizardry
//
//  Created by Joshua Smith on 5/1/16.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

import XCTest

final class MockDelegate: WizardDelegate {
    
    struct Methods: OptionSet {
        let rawValue: Int
        
        static let
        WizardDidCancel                 = Methods(rawValue: 1 << 1),
        WizardDidFinish                 = Methods(rawValue: 1 << 2),
        WizardDidGoToInitialWizardStep  = Methods(rawValue: 1 << 3),
        WizardDidGoToNextWizardStep     = Methods(rawValue: 1 << 4),
        WizardDidGoToPreviousWizardStep = Methods(rawValue: 1 << 5)
    }
    
    private let expectedMethods: Methods
    internal var unexpectedMethodsCalled = Methods()
    
    init(expectedMethods: Methods) {
        self.expectedMethods = expectedMethods
    }
    
    var wizardDidCancel_callCount = 0
    func wizardDidCancel(_: Wizard) {
        guard expectedMethods.contains(.WizardDidCancel) else {
            unexpectedMethodsCalled.formUnion(.WizardDidCancel)
            return
        }
        wizardDidCancel_callCount += 1
    }
    
    var wizardDidFinish_callCount = 0
    func wizardDidFinish(_: Wizard) {
        guard expectedMethods.contains(.WizardDidFinish) else {
            unexpectedMethodsCalled.formUnion(.WizardDidFinish)
            return
        }
        wizardDidFinish_callCount += 1
    }
    
    var wizardDidGoToInitialWizardStep_callCount = 0
    var wizardDidGoToInitialWizardStep_wizardStep: WizardStep?
    func wizard(_: Wizard, didGoToInitialWizardStep wizardStep: WizardStep) {
        guard expectedMethods.contains(.WizardDidGoToInitialWizardStep) else {
            unexpectedMethodsCalled.formUnion(.WizardDidGoToInitialWizardStep)
            return
        }
        wizardDidGoToInitialWizardStep_callCount += 1
        wizardDidGoToInitialWizardStep_wizardStep = wizardStep
    }
    
    var wizardDidGoToNextWizardStep_callCount = 0
    var wizardDidGoToNextWizardStep_wizardStep: WizardStep?
    var wizardDidGoToNextWizardStep_placement: WizardStepPlacement?
    func wizard(_: Wizard, didGoToNextWizardStep wizardStep: WizardStep, placement: WizardStepPlacement) {
        guard expectedMethods.contains(.WizardDidGoToNextWizardStep) else {
            unexpectedMethodsCalled.formUnion(.WizardDidGoToNextWizardStep)
            return
        }
        wizardDidGoToNextWizardStep_callCount += 1
        wizardDidGoToNextWizardStep_wizardStep = wizardStep
        wizardDidGoToNextWizardStep_placement = placement
    }
    
    var wizardDidGoToPreviousWizardStep_callCount = 0
    var wizardDidGoToPreviousWizardStep_wizardStep: WizardStep?
    var wizardDidGoToPreviousWizardStep_placement: WizardStepPlacement?
    func wizard(_: Wizard, didGoToPreviousWizardStep wizardStep: WizardStep, placement: WizardStepPlacement) {
        guard expectedMethods.contains(.WizardDidGoToPreviousWizardStep) else {
            unexpectedMethodsCalled.formUnion(.WizardDidGoToPreviousWizardStep)
            return
        }
        wizardDidGoToPreviousWizardStep_callCount += 1
        wizardDidGoToPreviousWizardStep_wizardStep = wizardStep
        wizardDidGoToPreviousWizardStep_placement = placement
    }
}
