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

    
    return self;
}


-(void) Connect{

    
}


-(void)initLoco:(Locomotiva *) l{


}
-(void)updateLoco :(Locomotiva * ) l{
    
    NSString * msg = [NSString stringWithFormat:@"SET %d GL %d %d %d %d %d %d %d %d %d",1,l.address,l.dir, l.speed,l.max_speed,l.f1,l.f2,l.f3,l.f4,l.f5];
    NSLog(msg);
    [sckmgr sendMessage:msg];
    

}


-(void)getInfoLoco:(Locomotiva * ) l{

    NSString * msg = [NSString stringWithFormat:@"GET %d GL %d",1,l.address];
    NSLog(msg);

    [sckmgr sendMessage:msg ];    
        
}


-(void)update{


    NSRange range;
    NSMutableArray * toDelete =[[NSMutableArray alloc]init];

    for (NSString * mess in [sckmgr.messages reverseObjectEnumerator]) {
        
        range = [mess rangeOfString :@"200 OK"];
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
            
            //Se è una LOCO - GL
            if([[myWords objectAtIndex:4]isEqualToString:@"GL"]){
            
                LocomotiveManager *lm = [LocomotiveManager sharedManager];
                
                Locomotiva * l =[[Locomotiva alloc]initWithAddress:[[myWords objectAtIndex:5]intValue]];
                
                [l setSpeed:[[myWords objectAtIndex:7]intValue]];
                [l setDir:[[myWords objectAtIndex:6]intValue]];
                [l setMax_speed:[[myWords objectAtIndex:8]intValue]];
                [l setF1:[[myWords objectAtIndex:9]intValue]];
                [l setF2:[[myWords objectAtIndex:10]intValue]];
                [l setF3:[[myWords objectAtIndex:11]intValue]];
                [l setF4:[[myWords objectAtIndex:12]intValue]];
                [l setF5:[[myWords objectAtIndex:13]intValue]];
                
                [lm updateLocobyLoco:l];
                
            
            [toDelete addObject:mess];
        }
        
    }
    
    
    [sckmgr.messages removeObjectsInArray:toDelete];


    }
}


@end
