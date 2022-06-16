//
//  FirstWindowDelegate.swift
//  ProjectCoreData
//
//  Created by Дарья Кретюк on 13.06.2022.
//

import Foundation

protocol FirstWindowDelegate: AnyObject {
    func addData(textLabel: String)
    
    func addDataModel(textLabel: String)
    
    func deleteObjectModel(indexObject: Int)
}

protocol SecondWindowDelegate: AnyObject {
    func addObject(object: (name: String, birthday: String, genders: String))
}
