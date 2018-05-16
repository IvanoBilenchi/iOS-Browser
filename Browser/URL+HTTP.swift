//
//  Created by Ivano Bilenchi on 16/05/18.
//  Copyright © 2018 Ivano Bilenchi. All rights reserved.
//

import Foundation

extension URL {
    static func httpURL(withString string: String) -> URL? {
        let urlString: String
        
        if (string.starts(with: "http://") || string.starts(with: "https://")) {
            urlString = string
        } else {
            urlString = "http://" + string
        }
        
        return URL(string: urlString)
    }
}
