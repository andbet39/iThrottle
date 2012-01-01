//
//  LocomotiveManager.h
//  srcpThrottle
//
//  Created by Andrea on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locomotiva.h"

@interface LocomotiveManager : NSObject
{
    NSMutableDictionary *locomotivesArray;
}

@property(nonatomic,retain) NSMutableDictionary * locomotivesArray;

+ (id)sharedManager ;
-(void)updateLocobyLoco:(Locomotiva *)tempLoco;
-(void)addNewLoco:(Locomotiva *) l;
-(void)removeLoco:(Locomotiva *) l;
-(void)saveToUserDefault;

@end
