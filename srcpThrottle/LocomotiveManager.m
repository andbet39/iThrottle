//
//  LocomotiveManager.m
//  srcpThrottle
//
//  Created by Andrea on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocomotiveManager.h"




@implementation LocomotiveManager

static LocomotiveManager *sharedLocomotiveManager = nil;


@synthesize  locomotivesArray;


#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if (sharedLocomotiveManager == nil)
            sharedLocomotiveManager = [[self alloc] init];
    }
    return sharedLocomotiveManager;
}


- (id)init {
    if (self = [super init]) {
        
        locomotivesArray = [[NSMutableDictionary alloc]init ];
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"locomotiveArray"];
       
       if (dataRepresentingSavedArray != nil)
       {
            NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
            
           if (oldSavedArray != nil){
                for (Locomotiva * l in oldSavedArray){
                    [locomotivesArray setValue:l forKey:[NSString stringWithFormat:@"%d",l.address]];
                }
            } 
       
       }else{
       
          }
        
    
    
    }
    return self;
}


-(void)updateLocobyLoco:(Locomotiva *)tempLoco{

    Locomotiva * toUpdate =[locomotivesArray valueForKey:[NSString stringWithFormat:@"%d",tempLoco.address]];
    
    toUpdate.speed=tempLoco.speed;
    toUpdate.dir=tempLoco.dir;
    toUpdate.max_speed=tempLoco.max_speed;
    toUpdate.f1=tempLoco.f1;
    toUpdate.f2=tempLoco.f2;
    toUpdate.f3=tempLoco.f3;
    toUpdate.f4=tempLoco.f4;
    toUpdate.f5=tempLoco.f5;
    
}


-(void)addNewLoco:(Locomotiva *) l
{
    
    [locomotivesArray setValue:l forKey:[NSString stringWithFormat:@"%d",l.address]];
     

}

-(void)removeLoco:(Locomotiva *) l{

    [locomotivesArray removeObjectForKey:[NSString stringWithFormat:@"%d",l.address]];
}


- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void)saveToUserDefault{

    NSArray * arrayToSave = [[NSArray alloc]initWithArray:[locomotivesArray allValues]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayToSave] forKey:@"locomotiveArray"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // Do this or nothing gets saved. :(

}
-(void)initzialize{

    
}



@end
