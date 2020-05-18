//
//  OctokitListTableViewCell.swift
//  YatraApp
//
//  Created by NMG on 16/05/20.
//  Copyright © 2020 Yatra. All rights reserved.
//

import UIKit

class OctokitListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelRepoName: UILabel!
    @IBOutlet weak var labelRepoDescription: UILabel!
    @IBOutlet weak var labelIssueCount: UILabel!
    @IBOutlet weak var labelLicence: UILabel!
    @IBOutlet weak var labelAdminPermission: UILabel!
    @IBOutlet weak var labelPullPermission: UILabel!
    @IBOutlet weak var labelPushPermissions: UILabel!
    public static let reuseID: String = "ListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public var  repo: UserDetailModel? {
        didSet {
            clearCell()
            configureCell()
        }
    }
    func setRepoCellWith(repo: Repo) {
        
        DispatchQueue.main.async {
            self.labelRepoName.text = "Name: " + (repo.name ?? "N/A")
            self.labelRepoDescription.text =  "Discription: " + (repo.repoDescription ?? "N/A")
            self.labelIssueCount.text =  "OpenIssuesCount: " + String(describing: repo.issueCount)
            self.labelLicence.text = "Licence Name: " + (repo.licenceName ?? "N/A")
            self.labelAdminPermission.text = String(describing:repo.adminPermission)
            self.labelPullPermission.text = String(describing:repo.pullPermission)
            self.labelPushPermissions.text = String(describing:repo.pushPermission)
            
        }
    }
    private func clearCell() {
        
    }
    
    private func configureCell() {
        guard let repo = self.repo else {
            return
        }
        labelRepoName.text = "Name: " + repo.name!
        labelRepoDescription.text =  "Discription: " + repo.description!
        labelIssueCount.text =  "OpenIssuesCount: " + String(describing: repo.open_issues_count!)
        labelLicence.text = "Licence Name: " + (repo.license?.name ?? "N/A")
        labelAdminPermission.text = String(describing:repo.permissions!.admin)
        labelPullPermission.text = String(describing:repo.permissions!.pull)
        labelPushPermissions.text = String(describing:repo.permissions!.push)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
