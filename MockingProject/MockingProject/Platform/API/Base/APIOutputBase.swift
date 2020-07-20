//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import ObjectMapper

class APIOutputBase: Mappable {
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {}
}

