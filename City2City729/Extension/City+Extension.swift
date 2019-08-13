//
//  City+Extension.swift
//  City2City729
//
//  Created by Jian Ma on 8/12/19.
//  Copyright © 2019 mac. All rights reserved.
//


extension City: Comparable{
    static func < (lhs: City, rhs: City) -> Bool {
        return rhs.date.timeIntervalSince(lhs.date) > 0
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.state == rhs.state
    }
}
