//
//  GlobalConstants.swift
//  Indicia
//
//  Created by Gambrell, John on 5/15/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import Foundation
enum GuidePostType : Int {
    case Document=0,
    Location
}

protocol GuidePostDelegate{
    func guidePostAdded()
}