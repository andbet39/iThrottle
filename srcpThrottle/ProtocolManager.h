//
//  ProtocolManager.h
//  srcpThrottle
//
//  Created by Andrea on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"

@interface ProtocolManager : NSObject
{
    
    Protocol * protocol;
    
    Boolean isBidirection;
    
}
@property(nonatomic,retain)Protocol * protocol;
@property(readwrite)Boolean isBidirection;

+ (id)sharedManager ;

@end
