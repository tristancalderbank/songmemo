//
//  Util.swift
//  songmemo
//
//  Created by testuser1 on 2018-12-12.
//  Copyright © 2018 songmemo. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
