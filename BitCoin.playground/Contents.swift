import UIKit
import PlaygroundSupport

var greeting = "Hello, playground"



let arrayOfStartBytes = ["A","B","C","D","E","F","G","H"]

func makeNewWords(arrayOfWords: [String]) -> [String]{
    let result: [String]
    
    result = [makeNewA(arrayOfWords: arrayOfWords),makeNewB(arrayOfWords: arrayOfWords)
              ,makeNewC(arrayOfWords: arrayOfWords),makeNewD(arrayOfWords: arrayOfWords),
              makeNewE(arrayOfWords: arrayOfWords),makeNewF(arrayOfWords: arrayOfWords),
              makeNewG(arrayOfWords: arrayOfWords),makeNewH(arrayOfWords: arrayOfWords)]
    
    return result
}

//let a = makeNewWords(arrayOfWords: arrayOfStartBytes)

func makeNewWords(from arrayOfWords: [String], by numberOfSteps: Int) -> [String] {
    var result: [String] = arrayOfWords
    
    for _ in 1...numberOfSteps {
        result = makeNewWords(arrayOfWords: result)
    }
    
    return result
}


//MARK: - save to disk
FileManager.documentsDirectoryURL

let str = makeNewWords(from: arrayOfStartBytes, by: 8)

writeResultTwoDisk(arrayOfWords: str, UrlPath: FileManager.documentsDirectoryURL)



