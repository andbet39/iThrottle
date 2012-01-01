//
//  SRCPProtocol.h
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocol.h"
#import "Locomotiva.h"

@interface SRCPProtocol : Protocol
{


}

-(id)initWithServer:(NSString *)host port:(int)port;

-(void) Connect;
-(void)updateLoco:(Locomotiva *) l;
-(void)getInfoLoco:(Locomotiva *) l;
-(void)update;

@end
