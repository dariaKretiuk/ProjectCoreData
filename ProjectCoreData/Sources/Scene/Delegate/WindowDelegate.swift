import Foundation

protocol FirstWindowDelegate: AnyObject {
    func addDataModel(textLabel: String)
    
    func deleteObjectModel(indexObject: Int)
}

protocol SecondWindowDelegate: AnyObject {
    func addObject(object: (name: String, birthday: String, genders: String))
}
