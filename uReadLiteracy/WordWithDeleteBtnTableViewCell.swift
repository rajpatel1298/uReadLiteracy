//
//  WordWithDeleteBtnTableViewCell.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 3/16/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class WordWithDeleteBtnTableViewCell: UITableViewCell {

    @IBOutlet var wordLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    private var onDelete = {}
    
    func inject(onDelete:@escaping ()->Void){
        self.onDelete = onDelete
    }
    
    
    func resetDeleteBtn(){
        deleteBtn.isHidden = false
        bringSubviewToFront(deleteBtn)
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        onDelete()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
