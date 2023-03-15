//
//  FormValidationTests.swift
//  LotteryManagerSDKTests
//
//  Created by Rodrigo Scroferneker on 15/03/2023.
//

import XCTest
@testable import LotteryManagerSDK

final class FormValidationTests: XCTestCase {
    
    func testSimpleGameValidForm() throws {
        let validFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "SimpleGameValidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: validFormsPath)
        let sut = SimpleGameConfigurator()
        
        for form in forms {
            XCTAssertTrue(sut.isValid(form: form))
        }
    }
    
    func testSimpleGameInvalidForm() throws {
        let invalidFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "SimpleGameInvalidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: invalidFormsPath)
        let sut = SimpleGameConfigurator()
        
        for form in forms {
            XCTAssertFalse(sut.isValid(form: form))
        }
    }
    
    func testMultipleGameValidForm() throws {
        let validFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "MultipleGameValidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: validFormsPath)
        let sut = MultipleGamesConfigurator()
        
        for form in forms {
            XCTAssertTrue(sut.isValid(form: form))
        }
    }
    
    func testMultipleGameInvalidForm() throws {
        let invalidFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "MultipleGameInvalidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: invalidFormsPath)
        let sut = MultipleGamesConfigurator()
                
        for form in forms {
            XCTAssertFalse(sut.isValid(form: form))
        }
    }
    
    func testExtraDozenGameValidForm() throws {
        let validFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "ExtraDozenGameValidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: validFormsPath)
        let sut = ExtraDozenGameConfigurator()
                
        for form in forms {
            XCTAssertTrue(sut.isValid(form: form))
        }
    }
    
    func testExtraDozenGameInvalidForm() throws {
        let invalidFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "ExtraDozenGameInvalidForms", ofType: "json")!
        let forms: [LMFormMock] = loadFile(named: invalidFormsPath)
        let sut = ExtraDozenGameConfigurator()
                
        for form in forms {
            XCTAssertFalse(sut.isValid(form: form))
        }

    }

//    func testExtraValueValidForm() throws {
//        let validFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "ExtraValueValidForms", ofType: "json")!
//        let forms: [LMFormMock] = loadFile(named: validFormsPath)
//    }
//    
//    func testExtraValueInvalidForm() throws {
//        let invalidFormsPath = Bundle(for: FormValidationTests.self).path(forResource: "ExtraValueInvalidForms", ofType: "json")!
//        let forms: [LMFormMock] = loadFile(named: invalidFormsPath)
//
//    }
    
}
