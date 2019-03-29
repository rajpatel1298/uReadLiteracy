//
//  BlockRuleExtension.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/29/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

extension BrowserViewController{
    func getBlockRule()->String{
        let blockRules = """
         [{"trigger": {"url-filter": ".*","resource-type": ["script"]},"action": {
                 "type": "block"
             }
         },
         {
             "trigger": {
                 "url-filter": ".*",
                 "resource-type": ["style-sheet"]
             },
             "action": {
                 "type": "block"
             }
         },
         {
             "trigger": {
                 "url-filter": ".*.jpeg"
             },
             "action": {
                 "type": "ignore-previous-rules"
             }
         }]
      """
        return blockRules
    }
}
