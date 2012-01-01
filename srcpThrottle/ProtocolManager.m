//
//  ProtocolManager.m
//  srcpThrottle
//
//  Created by Andrea on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ProtocolManager.h"

@implementation ProtocolManager

static ProtocolManager *sharedProtocolManager = nil;


@synthesize  protocol,isBidirection;


#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if (sharedProtocolManager == nil)
            sharedProtocolManager = [[self alloc] init];
    }
    return sharedProtocolManager;
}


- (id)init {
    if (self = [super init]) {
       
        isBidirection=TRUE;
    
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
