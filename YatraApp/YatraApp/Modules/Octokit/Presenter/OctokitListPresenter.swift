//
//  OctokitListPresenter.swift
//  YatraApp
//
//  Created NMG on 16/05/20.
//  Copyright © 2020 Yatra. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import CoreData
class OctokitListPresenter: OctokitListPresenterProtocol
{
    func viewDidReachPageEnd() {
        interactor?.incrementPage()
        interactor?.fetchOctokitList()
    }
    
    private var detail: [UserDetailModel] = []
    var listCount: Int{
        return detail.count
    }
    func data(atIndex index: Int) -> UserDetailModel {
        return detail[index]
    }
    
    func viewDidLoad() {
        view?.showLoader(forPage: 1)
        interactor?.fetchOctokitList()
    }
    
    weak private var view: OctokitListViewProtocol?
    var interactor: OctokitListInteractorInputProtocol?
    private let router: OctokitListWireframeProtocol
    
    private func createRepoEntityFrom(dictionary: UserDetailModel) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let repoEntity = NSEntityDescription.insertNewObject(forEntityName: "Repo", into: context) as? Repo {
            repoEntity.name = dictionary.name
            repoEntity.repoDescription = dictionary.description
            repoEntity.issueCount = dictionary.open_issues_count!
            repoEntity.licenceName = dictionary.license?.name
            repoEntity.adminPermission = dictionary.permissions!.admin
            repoEntity.pullPermission = dictionary.permissions!.pull
            repoEntity.pushPermission = dictionary.permissions!.push
            return repoEntity
        }
        return nil
    }
    private func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Repo.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    private func saveInCoreDataWith(array: [UserDetailModel]) {
        _ = array.map{self.createRepoEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    init(interface: OctokitListViewProtocol, interactor: OctokitListInteractorInputProtocol?, router: OctokitListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}

extension OctokitListPresenter : OctokitListInteractorOutputProtocol
{
    func interactor(didFetchList list: [UserDetailModel], forPage page: Int) {
        view?.hideLoader(forPage: page)
        self.detail += list
        if self.detail.count == 0 {
        }else {
            clearData()
            self.saveInCoreDataWith(array: self.detail)
            view?.reloadTableview()
        }    }
    
    func interactor(didFailToFetchListWithError error: Error, page: Int) {
        view?.showErrorAlert(withError: error)
        view?.hideLoader(forPage: page)
    }
    
    
    
    
    func interactor(didStartFetchingListForPage page: Int) {
        view?.showLoader(forPage: page)
        
    }
    
    
    
}
