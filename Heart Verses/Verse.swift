//
//  Verse.swift
//  
//
//  Created by Isaac Williams on 7/21/15.
//
//

import Foundation
import CoreData

class Verse: NSManagedObject {
    @NSManaged var passage: String
    @NSManaged var text: String
    @NSManaged var translation: String
}

class VerseStore: NSObject {
    var managedObjectContext: NSManagedObjectContext?
    
    init(moc : NSManagedObjectContext) {
        managedObjectContext = moc
    }
    
    func verses() -> [Verse] {
        let entityDescription = NSEntityDescription.entityForName("Verse", inManagedObjectContext: managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        return managedObjectContext!.executeFetchRequest(request, error:&error) as! [Verse]
    }
}

class HeartVersesAPI: NSObject {
    var managedObjectContext: NSManagedObjectContext?
    
    init(moc: NSManagedObjectContext) {
        managedObjectContext = moc
    }
    
    func loadVerse(passage: String) {
        var book: String?
        var chapter: Int?
        var verseNumber: Int?
        var text: String?
        
        let url = NSURL(string: passage)
        let session = NSURLSession.sharedSession()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), {
            let task = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                var parseError: NSError?
                let parsedJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&parseError)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if let verseData = parsedJSON as? NSDictionary {
                        if let verses = verseData["verses"] as? NSArray {
                            if let topVerseObject = verses[0] as? NSDictionary {
                                if let rawBook = topVerseObject["book"] as? String {
                                    book = rawBook
                                }
                                
                                if let rawChapter = topVerseObject["chapter"] as? Int {
                                    chapter = rawChapter
                                }
                                
                                if let rawVerse = topVerseObject["verse"] as? Int {
                                    verseNumber = rawVerse
                                }
                                
                                if let verseText = topVerseObject["text"] as? String {
                                    text = verseText
                                }
                                
                                let passageString = "\(book!) \(chapter!):\(verseNumber!)"
                                
                                let verse = NSEntityDescription.insertNewObjectForEntityForName("Verse", inManagedObjectContext: self.managedObjectContext!) as! Verse
                                verse.translation = "KJV"
                                verse.passage = passageString
                                verse.text = text!
                                
                                var error: NSError?
                                self.managedObjectContext!.save(&error)
                            }
                        }
                    }
                }
            })
            
            task.resume()
        })
    }
}