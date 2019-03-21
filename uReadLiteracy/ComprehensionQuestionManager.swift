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
    private var fictionQuestionsBeginning: [String]
    private var fictionQuestionsPeriodic: [String]
    private var fictionQuestionsEnd: [String]
    private var nonFictionQuestionsBeginning: [String]
    private var nonFictionQuestionsPeriodic: [String]
    private var nonFictionQuestionsEnd: [String]
    
    init() {
        generalQuestions = []
        fictionQuestionsBeginning = []
        fictionQuestionsPeriodic = []
        fictionQuestionsEnd = []
        nonFictionQuestionsBeginning = []
        nonFictionQuestionsPeriodic = []
        nonFictionQuestionsEnd = []
    }
    
    func getFileContents(fileName: String) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return []
        }
        do {
            let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\r")
        } catch {
            return []
        }
    }
    
    func populateGeneralQuestions(){
        generalQuestions = getFileContents(fileName: "generalQuestionsBeginning")
        generalQuestions.remove(at: generalQuestions.count-1)
    }
    
    func populateFictionBeginning(){
        fictionQuestionsBeginning = getFileContents(fileName: "fictionQuestionsBeginning")
        fictionQuestionsBeginning.remove(at: fictionQuestionsBeginning.count-1)
    }
    
    func populateFictionPeriodic(){
        fictionQuestionsPeriodic = getFileContents(fileName: "fictionQuestionsPeriodic")
        fictionQuestionsPeriodic.remove(at: fictionQuestionsPeriodic.count-1)
    }
    
    func populateFictionEnd(){
        fictionQuestionsEnd = getFileContents(fileName: "fictionQuestionsEnd")
        fictionQuestionsEnd.remove(at: fictionQuestionsEnd.count-1)
    }
    
    func populateNonFictionBeginning(){
        nonFictionQuestionsBeginning = getFileContents(fileName: "nonFictionQuestionsBeginning")
        nonFictionQuestionsBeginning.remove(at: nonFictionQuestionsBeginning.count-1)
    }
    
    func populateNonFictionPeriodic(){
        nonFictionQuestionsPeriodic = getFileContents(fileName: "nonFictionQuestionsPeriodic")
        nonFictionQuestionsPeriodic.remove(at: nonFictionQuestionsPeriodic.count-1)
    }
    
    func populateNonFictionEnd() {
        nonFictionQuestionsEnd = getFileContents(fileName: "nonFictionQuestionsEnd")
        nonFictionQuestionsEnd.remove(at: nonFictionQuestionsEnd.count-1)
    }
    
    func selectRandomGeneralQuestion() -> String{
        if(generalQuestions.isEmpty == false){
            print(generalQuestions)
            return generalQuestions.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomFictionBeginningQuestion() -> String{
        if(fictionQuestionsBeginning.isEmpty == false){
            return fictionQuestionsBeginning.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomFictionPeriodicQuestion() -> String{
        if(fictionQuestionsPeriodic.isEmpty == false){
            return fictionQuestionsPeriodic.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomFictionEndQuestion() -> String{
        if(fictionQuestionsEnd.isEmpty == false){
            return fictionQuestionsEnd.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomNonFictionBeginningQuestion() -> String{
        if(nonFictionQuestionsBeginning.isEmpty == false){
            return nonFictionQuestionsBeginning.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomNonFictionPeriodicQuestion() -> String{
        if(nonFictionQuestionsPeriodic.isEmpty == false){
            return nonFictionQuestionsPeriodic.randomElement()!
        }
        else {
            return "error"
        }
    }
    
    func selectRandomNonFictionEndQuestion() -> String{
        if(nonFictionQuestionsEnd.isEmpty == false){
            return nonFictionQuestionsEnd.randomElement()!
        }
        else {
            return "error"
        }
    }
}
