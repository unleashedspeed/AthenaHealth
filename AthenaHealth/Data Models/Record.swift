//
//  Record.swift
//  AthenaHealth
//
//  Created by Saurabh Gupta on 19/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation

struct Record: Codable {
    
    let sectionNote: String?
    let summaryText: String?
    let templates: [String]?
    let templateData: [TemplateData]?
    let isHpiToRos: Bool?
    let sectionNoteLastModifiedDateTime: String?
    let lastModifiedDateTime: String?
    let hpi: [HPI]?
    
    struct HPI: Codable {
        let paragraphId: String?
        let paragraphName: String?
        let templateName: String?
        let templateId: String?
        let sentences: [Sentence]?
    
        struct Sentence: Codable {
            let sentenceNote: String?
            let sentenceName: String?
            let sentenceId: String?
            let findings: [Finding]?
        
            struct Finding: Codable {
                let findingNote: String?
                let findingType: String?
                let findingName: String
                let medcinId: String?
                let findingId: String?
                let freeText: String?
                let genericFindingName: String?
                let selectedOptions: [String]?
                let optionLists: [String]?
                let isSelected: Bool
                let contradictionIds: [String]?
                let findingShortName: String?
            }
        }
    }
    
    struct TemplateData: Codable {
        let templateName: String?
        let templateNote: String?
        let templateId: String?
        let reportedBy: String?
    }
}
