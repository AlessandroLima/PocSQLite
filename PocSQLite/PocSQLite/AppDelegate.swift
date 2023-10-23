//
//  AppDelegate.swift
//  PocSQLite
//
//  Created by alessandro on 23/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var sqliteManager = SQLiteManager()
    var db: OpaquePointer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setDBManager()
        createPersonTable()
        return true
    }
    
    private func setDBManager() {
        let manager = sqliteManager.openOrCreateDatabase(databaseName: "myDatabase.sqlite")
        db = manager.db
        
    }
    
    private func createPersonTable() {
        
        if let db = self.db {
            
            lazy var person: Pessoa = {
                return Pessoa()
            }()
            
            person.setManagerAndDB(manager: self.sqliteManager, db: db)
            person.createTable()
        
            let peopleToInsert = [
                Pessoa(nome: "Alice", idade: 4),
                Pessoa(nome: "Ale", idade: 50),
                Pessoa(nome: "Mi", idade: 39),
                Pessoa(nome: "Pedro", idade: 0),
            ]
            
            _ = person.insertPeopleInBatch(people: peopleToInsert)
            
            let persons = person.selectTopNPeople(limit: 10)
            
            if let persons = persons {
                for person in persons {
                    print("Id: \(person.id), Nome: \(person.nome), Idade: \(person.idade)")
                }
            }
        }
    }
    
    private func insertPeople() {
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}


}

