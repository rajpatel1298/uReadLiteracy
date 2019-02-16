//
//  ComprehensionQuestionManager.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 2/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ComprehensionQuestionManager {
    
    private var generalQuestions: [String]
    
    init() {
        generalQuestions = []
    }
    
    func getFileContents(fileName: String) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return []
        }
        do {
            let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch {
            return []
        }
    }
    
    func populateGeneralQuestions(){
        generalQuestions = getFileContents(fileName: "generalQuestionsBeginning.txt")
    }
    
    func selectRandomGeneralQuestion() -> String{
        if(generalQuestions.isEmpty == false){
            return generalQuestions.randomElement()!
        }
        else {
            return ""
        }
    }
    
}
