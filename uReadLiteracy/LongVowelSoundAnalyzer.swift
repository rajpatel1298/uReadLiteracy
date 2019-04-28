//
//  LongVowelSoundAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class LongVowelSoundAnalyzer{
    
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        addIorOWithTwoConsonants()
        addSingleVowel2()
        addConsonantVowelConsonantAndE()
        addConsonantAConsonantE()
        addLongATwoVowels()
        addLongOWithOA()
        addLongETwoVowels()
        addLongITwoVowels()
        addLongIWithConsonantAndIConsonantE()
        addLongOWithConsonantOConsonantE()
        addLongOTwoVowels()
        addLongUTwoVowels()
        addTwoVowelsNoRules1()
        addTwoVowelsNoRules2()
        addOO()
        
        /*
         if(LongVowelSoundAnalyzer.twoVowelsNoRules5(word: word)){
         getUrlRequest(url: "https://www.youtube.com/watch?v=m0tfFJm76hg")
         }
         */
        
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addIorOWithTwoConsonants(){
        var urlRequestList = [URLRequest]()
        
        if(IorOWithTwoConsonants()){
            let request = StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=bmTgHABs-_c")
            urlRequestList.append(request)
        }
        if singleVowel1(){
            let request = StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=qRVUULcS_xU")
            urlRequestList.append(request)
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a long vowel sound made by a single vowel in the middle or end of the word.  A long vowel sound says the name of the letter of the vowel. Sometimes this occurs when I or O is followed by two consonants (for example kind, find, pint, Christ, climb, most, post, gold, sold, comb).  The I  or the Y at the end of a word will sound long and say the name either of the letter I of the letter E. If you’re not sure which it is, try it both ways and decide which makes sense and sounds like a real word", urlRequests: urlRequestList))
        }
    }
   
    //I or O +two consonants= long vowel (kind, find, pint, Christ, climb, most, post, gold, sold, comb
    private func IorOWithTwoConsonants()->Bool{
        if(word.count >= 3){
            
            if(word[word.count-3] == "i" || word[word.count-3] == "o" ){
                if(LetterAnalyzer.isConsonant(letter: word[word.count-2]) && LetterAnalyzer.isConsonant(letter: word[word.count-1])){
                    return true
                }
            }
            
        }
        return false
    }
    
    private let longVowelSoundSingleVowel1 = ["child", "gold", "I", "he", "she", "we"]
    
    //Long vowel sound, single vowel
    private func singleVowel1()->Bool{
        if(longVowelSoundSingleVowel1.contains(word)){
            return true
        }
        
        if(word.last != nil){
            if(word.last == "y" || word.last == "i"){
                return true
            }
        }
        return false
    }
    
    //MARK: New Detail
    
    private func addSingleVowel2(){
        var urlRequestList = [URLRequest]()
        
        if singleVowel2(){
            let request = StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=4QRop-G9hw8")
            urlRequestList.append(request)
        }
        
        if(urlRequestList.count>0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has at least one long vowel sound, but it is made by a single vowel.  A long vowel sound says the name of the letter of the vowel.", urlRequests: urlRequestList))
        }
    }
    
    private  let longVowelSoundSingleVowel2 = ["alien", "acorn", "agent","apricot", "ice", "only", "open", "me", "equal", "she","human", "island", "tidy", "idea", "united", "uniform"]
    
    private func singleVowel2()->Bool{
        if(longVowelSoundSingleVowel2.contains(word)){
            return true
        }
        return false
    }
    
    // MARK: New Detail
    
    private func addConsonantVowelConsonantAndE(){
        var urlRequestList = [URLRequest]()
        
        if consonantVowelConsonantAndE(){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=c3oA4wfUBak"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=wJ2KpholmtE"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=aV0piUUlXec&index=2&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a long vowel sound because it has the letter pattern consonant-vowel-consonant-e.  A long vowel sound says the name of the letter of the vowel. When you see this pattern, it is usually a long vowel sound and that means it says its name.  Unfortunately, there are some exceptions to this.  This includes glove, love, have, live, give, active, inventive, olive, come, one, there, eye, are, done, any word that ends in -ve", urlRequests: urlRequestList))
        }
    }
    
    
    // Long vowel sound made by consonant(s)-vowel-consonant+e
    private func consonantVowelConsonantAndE()->Bool{
        let exception = ["glove", "love", "have", "live", "give","active", "inventive", "olive", "come", "one", "there", "eye", "are", "done"]
        if(exception.contains(word)){
            return false
        }
        
        if(word.count >= 4){
            if(LetterAnalyzer.isConsonant(letter: word[word.count-4])){
                if(LetterAnalyzer.isVowel(letter: word[word.count-3])){
                    if(LetterAnalyzer.isConsonant(letter: word[word.count-2])){
                        if(word[word.count-1] == "e"){
                            if(word[word.count-2] == "v"){
                                return false
                            }
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    // ----------------------------------------------------------------
    //MARK: New Detail
    
    private func addConsonantAConsonantE(){
        var urlRequestList = [URLRequest]()
        
        if(consonantAConsonantE()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=krad_5lR80M"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=8P4RJ3CXJFI"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant + a + consonant + e pattern.  For this pattern, the a is a long vowel sound.  That means it says it’s name.", urlRequests: urlRequestList))
        }
    }
    
    //Long a:  consonant + a + consonant + e
    private func consonantAConsonantE()->Bool{
        if(word.count >= 4){
            if(LetterAnalyzer.isConsonant(letter: word[word.count-4])){
                if(word[word.count-1] == "a"){
                    if(LetterAnalyzer.isConsonant(letter: word[word.count-2])){
                        if(word[word.count-1] == "e"){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    // MARK: New Detail
    
    private func addLongATwoVowels(){
        var urlRequestList = [URLRequest]()
        
        if(longATwoVowels()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=iRuoRzU0MPE"))
        }
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When  ai, ay, ea, eigh are together, they usually make a long a sound.  This means the sound is the same as how you pronounce the letter name a.", urlRequests: urlRequestList))
        }
    }
    
    //Long a vowel sound made by two vowels together:  ai, ay, ea, eigh
    private func longATwoVowels()->Bool{
        let vowels = ["ai", "ay", "ea"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["eigh"])
        
    }
    
    // ----------------------------------------------------------------
    
    // MARK: New Detail
    
    private func addLongOWithOA(){
        var urlRequestList = [URLRequest]()
        
        if(LongVowelSoundAnalyzer.longOWithOA(word: word)){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=_xYKYTf0JS8"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When o and a are together, it usually makes a long o sound.  This means the sound is the same as how you pronounce the letter name o.", urlRequests: urlRequestList))
        }
    }
    
    
    //Long o: -oa-
    static func longOWithOA(word:String)->Bool{
        return LetterAnalyzer.matchAnyPosition(word: word, targets:["oi"])
    }
    
    // ----------------------------------------------------------------
    // MARK: New Detail
    
    private func addLongETwoVowels(){
        var urlRequestList = [URLRequest]()
        
        if(longETwoVowels()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=iRuoRzU0MPE"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=AnmKkqRJ980"))
        }
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When ea, ee, or ey are together, they usually make a long e sound.  This means the sound is the same as how you pronounce the letter e.", urlRequests: urlRequestList))
        }
    }
    
    //Long e vowel sound made by two vowels together:  ea, ee, ey
    private func longETwoVowels()->Bool{
        let vowels = ["ea", "ee", "ey"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels)
    }
    
    //MARK: New Detail
    
    private func addLongITwoVowels(){
        var urlRequestList = [URLRequest]()
        
        if(longITwoVowels()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=WBwwcBRM3Rc"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=ObVaokd5vq4"))
        }
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When ie and igh are together, they usally make a long I sound.  That means the sound is the same as how you pronounce the letter I.  But there are exceptions.  Piece, alien, field, chief, and thief make a long e sound which means the sound is the same how you pronounce the letter e.  When ei are together, they usually also make a long e sound.  If you’re not sure whether the word has a long I or a long E sound, try both out and decide which sounds like a real word and makes sense in the sentence.", urlRequests: urlRequestList))
        }
    }
    
    //Long I vowel sound made by two vowels
    private func longITwoVowels()->Bool{
        let exception = ["piece", "alien", "field", "chief", "thief", "ceiling", "receipt", "receive"]
        
        if(exception.contains(word)){
            return false
        }
        
        let vowels = ["ie", "ei"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels) || LetterAnalyzer.matchAnyPosition(of: word, numberOfLetters: 3, in: ["igh"])
    }
    
    // MARK: New Detail
    
    private func addLongIWithConsonantAndIConsonantE(){
        var urlRequestList = [URLRequest]()
        
        if(longIWithConsonantAndIConsonantE()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=osbtOG5cz40"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant + i + consonant + e pattern.  For this pattern, the i makes a long vowel sound.  This means the sound is the same as how you pronounce the letter name i.", urlRequests: urlRequestList))
        }
    }
    
    // Long I, consonant(s) + i + consontant(s) + e
    private func longIWithConsonantAndIConsonantE()->Bool{
        return LetterAnalyzer.consonantLetterConsonantLetter(word: word, letter1: "i", letter2: "e")
    }

    // ----------------------------------------------------------------
    // MARK: New Detail
    
    private func addLongOWithConsonantOConsonantE(){
        var urlRequestList = [URLRequest]()
        
        if(longOWithConsonantOConsonantE()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=SUp-nnGusvk"))
        }
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant + o + consonant + e pattern.  For this pattern, the o makes a long vowel sound.  This means the sound is the same as how you pronounce the letter name o.", urlRequests: urlRequestList))
        }
    }
    
    // Long o made with consonant - o - consonant + e
    private func longOWithConsonantOConsonantE()->Bool{
        return LetterAnalyzer.consonantLetterConsonantLetter(word: word, letter1: "o", letter2: "e")
    }
    
    // MARK: New Detail
    
    private func addLongOTwoVowels(){
        var urlRequestList = [URLRequest]()
        
        if(longOTwoVowels()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=l2nH1KfOVXA"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When words have oa, oo, oe, or ow, the sound is often a long o sound which means the sound is the same as how you pronounce the letter name o.  There are some exceptions like canoe, shoe, cow, sow, plow, brow.  If you’re not sure which sound the o makes, oo like show or o like boat, try both out and see which one makes sense in the sentence and sounds like a real word.", urlRequests: urlRequestList))
        }
    }
    
    //Long O vowel sound made by two vowels
    private func longOTwoVowels()->Bool{
        let exception = ["canoe", "shoe"]
        
        if(exception.contains(word)){
            return false
        }
        
        let vowels = ["oa", "oo", "oe", "ow"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels)
    }
    
    // ----------------------------------------------------------------
    //MARK: New Detail
    
    private func addLongUTwoVowels(){
        var urlRequestList = [URLRequest]()
        
        if(longUTwoVowels()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=J_s1eBCtaiI"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=acLppUOFs3w"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When words have ew, ue, ui, and oo, the sound is often a long u sound which means the sound is the same as how you pronounce the letter name u.  There are some exceptions like book, look, and shook.  Words that have a consonant + u + consonant = e pattern also have a long u sound that sounds like oo as in moon or the way you say the letter us.  Sometimes when a words starts with u, it has a long u sound.  If you’re not sure which sound the u is making try out the possibilities and see which one makes sense in the sentence and sounds like a real word.", urlRequests: urlRequestList))
        }
    }
    
    //Long u sound made by two vowels:  ew, ue, ui, oo or consonant + u+ consonant + e
    private func longUTwoVowels()->Bool{
        let accepted = ["uniform", "unicorn", "unique", "unity", "unite", "ukele"]
        if(accepted.contains(word)){
            return true
        }
        
        let vowels = ["ew", "ue", "ui", "oo"]
        return LetterAnalyzer.consonantLetterConsonantLetter(word: word, letter1: "u", letter2: "e") || LetterAnalyzer.matchAnyPosition(word: word, targets: vowels)
    }
    
    // ----------------------------------------------------------------
    // MARK: New Detail
    
    private func addTwoVowelsNoRules1(){
        var urlRequestList = [URLRequest]()
        
        if(twoVowelsNoRules1()){
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["oi"])){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=EMdtke9HZVE"))
            }
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["oi","oy"])){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=EtPpSYDsVZs"))
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=cdI7fycHg1k"))
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "Although the usual rule when two vowels are together is that the first vowel is pronounced with that letters long vowel sound. But au, aw, ou, ow, oi, oy and some words like bread and book break this rule.  They are consonant blends that do not have long vowel sounds.  Each has its own sound.  If you’re not sure if the first vowel is long rule applies try it out and see if it sounds right and fits in the sentence that way.  If not try some other possible sounds.", urlRequests: urlRequestList))
        }
    }
    
    // au, aw, ou, ow, oi, oy, or bread, thread, book, look, hook, brook.
    private func twoVowelsNoRules1()->Bool{
        let accepted = ["bread", "thread", "book", "look", "hook", "brook"]
        if(accepted.contains(word)){
            return true
        }
        
        let vowels = ["au", "aw", "ou", "ow", "oi", "oy"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels)
    }
    
    // MARK: New Detail
    
    private func addTwoVowelsNoRules2(){
        var urlRequestList = [URLRequest]()
        
        if(twoVowelsNoRules2()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=7fb3Pdt8kxg"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=k-n_LHGseNk"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=10m4ujzFVqc"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "Many times when two vowels are together, the second one is silent and the first one makes the long vowel sound of that letter.  So, for example, when oa are together, often times, the word will have a long o sound which means it will have the sound of saying the letter o.  A lot of times people will describe this as ‘when two vowels go walking, the first one does the talking.", urlRequests: urlRequestList))
        }
    }
    
    // Long vowel sounds made with two vowels together:  oa, ea, ai, ay
    private func twoVowelsNoRules2()->Bool{
        let vowels = ["oa", "ea", "ai", "ay"]
        return LetterAnalyzer.matchAnyPosition(word: word, targets: vowels)
    }
    
    // MARK: New Detail
    
    private func addOO(){
        var urlRequestList = [URLRequest]()
        
        if(twoVowelsNoRules3()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=_vME18_vURk&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=9"))
        }
            
        else if(twoVowelsNoRules4()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc"))
        }
        else{
            if(OO()){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=_vME18_vURk&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=9"))
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc"))
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "When two o’s are together they can make one of two sounds; neither one is exactly a long or a short o sound.  It can be ooh as in boot or uh as in book.  There isn’t an easy way to know which way to pronounce the o sound in this case.  Try both and see which one makes sense in the sentence or sounds like a real word.", urlRequests: urlRequestList))
        }
    }
    
    // -oo-
    private func twoVowelsNoRules3()->Bool{
        let accepted = ["room", "moon", "food", "book", "cook", "good", "poor", "door", "floor", "blood", "flood", "cooperate", "coordinate","boot", "moon", "spoon", "goose", "moose", "food", "book", "cook", "wood", "foot"]
        if(accepted.contains(word)){
            return true
        }
        return false
    }
    
    private func twoVowelsNoRules4()->Bool{
        let accepted = ["boot", "moon", "spoon", "goose", "moose", "food", "book", "cook", "wood", "foot"]
        if(accepted.contains(word)){
            return true
        }
        return false
    }
    
    private func OO()->Bool{
        return LetterAnalyzer.matchAnyPosition(word: word, targets: ["oo"])
    }
    
    static func twoVowelsNoRules5(word:String)->Bool{
        return LetterAnalyzer.matchAnyPosition(word: word, targets: ["augh"])
    }
}
