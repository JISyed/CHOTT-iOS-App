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
    
    enum DefaultsKeys: String
    {
        case currentProjectId
        case currentStartTime
        case isCurrentlyTiming
    }
    
    private static let defaults = UserDefaults.standard
    
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
    
    
    public static func isCurrentlyTimingSession() -> Bool
    {
        return defaults.bool(forKey: DefaultsKeys.isCurrentlyTiming.rawValue)
    }
    
    public static func declareTimingSession(ofProject project: ChottProjectData, withStartTime startTime: Date)
    {
        defaults.set(project.id!.uuidString, forKey: DefaultsKeys.currentProjectId.rawValue)
        defaults.set(startTime, forKey: DefaultsKeys.currentStartTime.rawValue)
        
        defaults.set(true, forKey: DefaultsKeys.isCurrentlyTiming.rawValue)
    }
    
    public static func declareStoppingSession()
    {
        defaults.set(false, forKey: DefaultsKeys.isCurrentlyTiming.rawValue)
    }
    
    public static func restoreCurrentSessionData() -> ChottCurrentSessionData
    {
        let idString = defaults.object(forKey: DefaultsKeys.currentProjectId.rawValue) as! String
        let projectId = UUID(uuidString: idString)!
        let startTime = defaults.object(forKey: DefaultsKeys.currentStartTime.rawValue) as! Date
        
        let restoredSession = ChottCurrentSessionData(currentProjectId: projectId, currentStartTime: startTime)
        
        return restoredSession
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
        // Delete sessions of this project first
        ChottDataService.deleteEverySession(of: project)
        
 
        // Now delete project
        _currentProjects.remove(at: rowIndex)
        CoreDataService.deleteEntity(ofType: ChottProjectData.self, entity: project)
        CoreDataService.saveContext()
    }
    
    
    static func searchProject(byId uuid: UUID) -> ChottProjectData?
    {
        let requestProjects: NSFetchRequest<ChottProjectData> = ChottProjectData.fetchRequest()
        
        let query = NSPredicate(format: "%K == %@", "id", uuid as CVarArg)
        requestProjects.predicate = query
        
        do 
        {
            let foundEntities: [ChottProjectData] = try CoreDataService.context.fetch(requestProjects)
            return foundEntities.first
        } 
        catch 
        {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }
        
        return nil
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
    
    static func deleteSession(_ session: ChottSessionData, atIndex rowIndex: Int)
    {
        _currentSessions.remove(at: rowIndex)
        CoreDataService.deleteEntity(ofType: ChottSessionData.self, entity: session)
        CoreDataService.saveContext()
    }
    
    
    static func deleteEverySession(of project: ChottProjectData)
    {
        _currentSessions.removeAll()
        
        // Fetch every session for the given project ID
        let requestSessions = NSFetchRequest<NSFetchRequestResult>(entityName: "ChottSessionData")
        let query = NSPredicate(format: "%K == %@", "projectId", project.id! as CVarArg)
        requestSessions.predicate = query
        
        // Request deletion of fetched results
        let deleteSessionsRequest = NSBatchDeleteRequest(fetchRequest: requestSessions)
        
        // Delete sessions
        do
        {
            try CoreDataService.context.execute(deleteSessionsRequest)
        }
        catch
        {
            let deletionError = error as NSError
            print(deletionError)
        }
    }
    
    
    
    
    
    static func loadCurrentProjects(from category: ChottCategory)
    {
        _currentProjects.removeAll()
        _currentSessions.removeAll()
        
        let requestProjects: NSFetchRequest<ChottProjectData> = ChottProjectData.fetchRequest()
        
        let query = NSPredicate(format: "%K == %@", "categoryId", "\(category.rawValue)")
        requestProjects.predicate = query
        
        let sortMethod = NSSortDescriptor(key: "lastWorkedOn", ascending: false)
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
        
        let requestSessions: NSFetchRequest<ChottSessionData> = ChottSessionData.fetchRequest()
        
        // Credit to: https://stackoverflow.com/a/45685319
        let query = NSPredicate(format: "%K == %@", "projectId", project.id! as CVarArg)
        requestSessions.predicate = query
        
        let sortMethod = NSSortDescriptor(key: "startTime", ascending: false)
        requestSessions.sortDescriptors = [sortMethod]
        
        do 
        {
            let foundEntities: [ChottSessionData] = try CoreDataService.context.fetch(requestSessions)
            _currentSessions = foundEntities
        } 
        catch 
        {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }
    }
    
    
    
    
    
    
}
