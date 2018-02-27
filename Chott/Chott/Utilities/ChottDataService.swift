//
//  ChottDataService.swift
//  Chott
//
//  Created by Jibran Syed on 2/25/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import Foundation
import CoreData


class ChottDataService
{
    private init(){}
    
    
    private static var _currentProjects = [ChottProjectData]()
    private static var _currentSessions = [ChottSessionData]()
    
    public static var currentProjects: [ChottProjectData]
    {
        return _currentProjects
    }
    
    public static var currentSessions: [ChottSessionData]
    {
        return _currentSessions
    }
    
    
    static func addProject(withName name: String, andCategory cate: ChottCategory) -> ChottProjectData?
    {
        let newProject = CoreDataService.makeNewEntity(ofType: ChottProjectData.self)
        newProject.id = UUID()
        newProject.categoryId = Int32(cate.rawValue)
        newProject.lastWorkedOn = Date()
        newProject.name = name
        
        _currentProjects.append(newProject)
        
        CoreDataService.saveContext()
        
        return newProject
    }
    
    static func renameProject(_ project: ChottProjectData, with newName: String)
    {
        project.name = newName
        
        CoreDataService.saveContext()
    }
    
    static func deleteProject(_ project: ChottProjectData, atIndex rowIndex: Int)
    {
        /*
        // First delete the sessions associated with this project
        ChottDataService.loadCurrentSessions(of: project)
        
        // Iterate through every session and delete
        while _currentSessions.count > 0
        {
            let _ = _currentSessions.popLast()!
            
            // TODO: Delete
            //ChottDataService.deleteSession(session)
        }
        */       
 
        // Now delete project
        _currentProjects.remove(at: rowIndex)
        CoreDataService.deleteEntity(ofType: ChottProjectData.self, entity: project)
        CoreDataService.saveContext()
    }
    
    
    
    static func addSession(forProject project: ChottProjectData, startTime: Date, andEndTime endTime: Date)
    {
        let newSession = CoreDataService.makeNewEntity(ofType: ChottSessionData.self)
        newSession.id = UUID()
        newSession.projectId = project.id
        newSession.startTime = startTime
        newSession.endTime = endTime
        
        _currentSessions.append(newSession)
        
        CoreDataService.saveContext()
    }
    
    static func deleteSession(_ session: ChottSessionData)
    {
        CoreDataService.deleteEntity(ofType: ChottSessionData.self, entity: session)
    }
    
    
    
    
    
    
    static func loadCurrentProjects(from category: ChottCategory)
    {
        _currentProjects.removeAll()
        _currentSessions.removeAll()
        
        let requestProjects: NSFetchRequest<ChottProjectData> = ChottProjectData.fetchRequest()
        
        let query = NSPredicate(format: "%K == %@", "categoryId", "\(category.rawValue)")
        requestProjects.predicate = query
        
        let sortMethod = NSSortDescriptor(key: "lastWorkedOn", ascending: true)
        requestProjects.sortDescriptors = [sortMethod]
        
        do 
        {
            let foundEntities: [ChottProjectData] = try CoreDataService.context.fetch(requestProjects)
            
            _currentProjects = foundEntities
        } 
        catch 
        {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }
    }
    
    
    static func loadCurrentSessions(of project: ChottProjectData)
    {
        _currentSessions.removeAll()
        
        
    }
    
    
    
    
    
    
}
