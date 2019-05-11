//
//  SightWordAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class SightWordAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=jpVWGhuckcQ",
                    "https://www.youtube.com/watch?v=-dTfftkaGkQ",
            "https://www.youtube.com/watch?v=KzSutwEQ0T8",
            "https://www.youtube.com/watch?v=bo28x-ky0dU",
            "https://www.youtube.com/watch?v=d8irWS0MKZk",
            "https://www.youtube.com/watch?v=qU3mx70yGos",
            "https://www.youtube.com/watch?v=CLt6vakKzfw",
            "https://www.youtube.com/watch?v=vWUwTqep-8E",
            "https://www.youtube.com/watch?v=47PGXl-SHIk",
            "https://www.youtube.com/watch?v=-dTfftkaGkQ",
            "https://www.youtube.com/watch?v=bADYd_DXltU",
            "https://www.youtube.com/watch?v=__E3kdvH9Ac",

        ]
        
        var videoHtmlList = [String]()
        for url in urls{
            videoHtmlList.append(YoutubeLink(url: url).getHtml())
        }
        return videoHtmlList
    }
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        var videoHtmlList = [String]()
        
        if(first()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=jpVWGhuckcQ").getHtml())
        }
        if(second()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=-dTfftkaGkQ").getHtml())
        }
        if(third()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=KzSutwEQ0T8").getHtml())
        }
        if(fourth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=bo28x-ky0dU").getHtml())
        }
        if(fifth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=d8irWS0MKZk").getHtml())
        }
        if(sixth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=qU3mx70yGos").getHtml())
        }
        if(seventh()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=CLt6vakKzfw").getHtml())
        }
        if(eighth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=vWUwTqep-8E").getHtml())
        }
        if(ninth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=47PGXl-SHIk").getHtml())
        }
        if(tenth()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=bADYd_DXltU").getHtml())
        }
        if(first()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=__E3kdvH9Ac").getHtml())
        }
        
        
        if(videoHtmlList.count > 0){
            let detail = WordAnalysisDetail(title: title, detail: "This word is what is a called a sight word.  Some words are so common, but often hard to sound out, that it is recommended you learn to recognize them without sounding them out.  These are called sight words.  Learning to recognize and say sight words will make your reading much quicker and smoother.  There are lots of other Youtube videos and quiz programs that you can use to learn them.  Try googling how to learn sight words.  Practice makes perfect!", videoHtmlList: videoHtmlList)
            
            
            wordDetails.append(detail)
        }
        
        return wordDetails
    }
    
    private func first()->Bool{
        let list = ["the","of","and","a","to","in","is","you","that","it","he","for","was","on","are","as","with","his","they","at","be","this","from","I"]
        return list.contains(word)
    }
    
    private func second()->Bool{
        let list = ["the","of","find","only","was","are","could","to","would","do","were","your","some","have","from","a","into","who","people","other","one","two","you","what","many","there","said","been","their","they"]
        return list.contains(word)
    }
    
    private func third()->Bool{
        let list = ["the","of","and","a","to","in","he","you","i","it"]
        return list.contains(word)
    }
    
    private func fourth()->Bool{
        let list = ["she", "was", "for", "on", "that", "but", "said", "his", "they", "had"]
        return list.contains(word)
    }
    
    private func fifth()->Bool{
        let list = ["at", "be", "this", "have", "from", "or", "one", "had", "by", "word"]
        return list.contains(word)
    }
    
    private func sixth()->Bool{
        let list = ["out", "as", "be", "have", "go", "we", "am", "then", "little", "down"]
        return list.contains(word)
    }
    
    private func seventh()->Bool{
        let list = ["do", "can", "could", "when", "did", "what", "so", "see", "not", "were"]
        return list.contains(word)
    }
    
    private func eighth()->Bool{
        let list = ["you", "like", "see", "the", "at", "can", "me", "be", "to", "we", "and", "come", "little", "is", "look", "up", "in" ,"out", "big", "it", "by", "did", "my", "she", "he", "said", "not", "do", "for", "or", "had", "but", "that", "this", "will", "have", "has", "if", "on", "off", "of", "one", "two", "three", "him", "her", "his", "boy", "us", "they"]
        return list.contains(word)
    }
    
    private func ninth()->Bool{
        let list = ["water", "very", "word", "most", "where", "through", "another", "come" ,"work", "does", "put", "again", "old", "great", "should", "give", "something", "thought", "both", "often", "world", "want", "different", "together", "school", "head", "enough", "sometimes", "four", "once"]
        return list.contains(word)
    }
    
    private func tenth()->Bool{
        let list = ["move", "much", "must", "name", "need", "new", "off", "old", "only", "our", "over", "page", "picture", "place", "play", "point", "put", "read", "right", "same", "say", "sentence", "set", "should", "show"
]
        return list.contains(word)
    }
    
    private func eleventh()->Bool{
        let list = ["small", "sound", "spell", "still", "study", "such", "take", "tell", "thing", "think", "three", "through", "too", "try", "turn", "us", "very", "want", "well", "went", "where", "why", "work", "world", "years"
        ]
        return list.contains(word)
    }
}
