//
//  Protcol.m
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Protocol.h"

@implementation Protocol

@synthesize sckmgr,isConnecting,isConnect;

-(id)init
{

    sckmgr = [[SocketManager alloc]init];
    isConnecting=false;
    isConnect=FALSE;
    
    return self;
    
}
-(void)updateLoco:(Locomotiva *) l{

    NSLog(@"Update loco with address : %d",l.address);
    
}
-(void)getInfoLoco:(Locomotiva *) l{


}


@end
