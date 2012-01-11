//
//  SRCPProtocol.m
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SRCPProtocol.h"
#import "Locomotiva.h"


@implementation SRCPProtocol


-(id)initWithServer:(NSString *)host port:(int)port{

    self=[super init];
    
    [sckmgr Connect:host port:port];
    isConnect=FALSE;
    

    
    return self;
}


-(void) Connect{
    
    isConnecting=TRUE;
    isConnect=FALSE;
    NSString * msg = [NSString stringWithFormat:@"GO"];
    [sckmgr sendMessage:msg ];    

    
}


-(void)initLoco:(Locomotiva *) l{

    NSString * msg = [NSString stringWithFormat:@"INIT %d GL %d N 1 %d 5",l.bus,l.address,l.max_speed];
    NSLog(msg);
    l.isInitiated=true;
    [sckmgr sendMessage:msg];

}
-(void)updateLoco :(Locomotiva * ) l{
    
    if(!l.isInitiated)[self initLoco:l];
    
    NSString * msg = [NSString stringWithFormat:@"SET %d GL %d %d %d %d %d %d %d %d %d",l.bus,l.address,l.dir, l.speed,l.max_speed,l.f1,l.f2,l.f3,l.f4,l.f5];
    NSLog(msg);
    [sckmgr sendMessage:msg];
    

}


-(void)getInfoLoco:(Locomotiva * ) l{

    if(!l.isInitiated)[self initLoco:l];

    NSString * msg = [NSString stringWithFormat:@"GET %d GL %d",l.bus,l.address];
    NSLog(msg);

    [sckmgr sendMessage:msg ];    
        
}


-(void)update{

    

    NSRange range;
    NSMutableArray * toDelete =[[NSMutableArray alloc]init];

    for (NSString * mess in [sckmgr.messages reverseObjectEnumerator]) {
        
        if(isConnecting){
            range = [mess rangeOfString :@"OK GO"];
            if (range.location != NSNotFound) {
                isConnecting=FALSE;
                isConnect=TRUE;
                [toDelete addObject:mess];
            }
            range = [mess rangeOfString :@"SRCP"];
            if (range.location != NSNotFound) {
                [toDelete addObject:mess];
            }
        
        }else{
            
            range = [mess rangeOfString :@"OK"];
            if (range.location != NSNotFound) {
                [toDelete addObject:mess];
                
            }
            range = [mess rangeOfString :@"ERROR"];
            if (range.location != NSNotFound) {
                [toDelete addObject:mess];
                
            }
            
            range = [mess rangeOfString :@"INFO"];
            if (range.location != NSNotFound) {
                
                
                NSArray *myWords = [mess componentsSeparatedByString:@" "];
                
                //If a LOCO - GL
                if([[myWords objectAtIndex:4]isEqualToString:@"GL"]){
                    
                    LocomotiveManager *lm = [LocomotiveManager sharedManager];
                    
                    Locomotiva * l =[[Locomotiva alloc]initWithAddress:[[myWords objectAtIndex:5]intValue]];
                    
                    [l setSpeed:[[myWords objectAtIndex:7]intValue]];
                    [l setDir:[[myWords objectAtIndex:6]intValue]];
                    [l setMax_speed:[[myWords objectAtIndex:8]intValue]];
                    
                    if([myWords count]>9)[l setF1:[[myWords objectAtIndex:9]intValue]];
                    if([myWords count]>10)[l setF2:[[myWords objectAtIndex:10]intValue]];
                    if([myWords count]>11)[l setF3:[[myWords objectAtIndex:11]intValue]];
                    if([myWords count]>12)[l setF4:[[myWords objectAtIndex:12]intValue]];
                    if([myWords count]>13)[l setF5:[[myWords objectAtIndex:13]intValue]];
                    
                    [lm updateLocobyLoco:l];
                    

        }
                    
            [toDelete addObject:mess];
        }
        
    }
    
    
    [sckmgr.messages removeObjectsInArray:toDelete];


    }
}


@end
