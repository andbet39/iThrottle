//
//  Protcol.h
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketManager.h"
#import "Locomotiva.h"
#import "LocomotiveManager.h"
@interface Protocol : NSObject
{

    SocketManager * sckmgr;
    

}

@property(nonatomic,retain) SocketManager * sckmgr;


-(void)Connect;
-(void)updateLoco:(Locomotiva *) l;
-(void)getInfoLoco:(Locomotiva *) l;
-(void)update;
-(void)initLoco:(Locomotiva *) l;

@end
