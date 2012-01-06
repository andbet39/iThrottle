//
//  Locomotiva.h
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SPEED_STEP 14
#define  SRCP_LOCO_BUS 1

typedef enum {
    kForward,
    kBackWard
}direction;




@interface Locomotiva : NSObject <NSCoding>{

    
    NSString * identifier;

    UIImage *locoThumb;
    
    int address;
    
    int speed;
    int max_speed;
    direction dir;
    
    
    int bus;
    
    
    bool f1;
    bool f2;
    bool f3;
    bool f4;
    bool f5;
    
    bool isError;
    bool isInitiated;
    
    
}

@property(nonatomic,retain)NSString * identifier;
@property(nonatomic,retain)UIImage *locoThumb;

@property(readwrite) int address;
@property(readwrite) int speed;
@property(readwrite) int bus;
@property(readwrite) int max_speed;
@property(readwrite)direction dir;
@property(readwrite)bool f1;
@property(readwrite)bool f2;
@property(readwrite)bool f3;
@property(readwrite)bool f4;
@property(readwrite)bool f5;
@property(readwrite)bool isError;
@property(readwrite)bool isInitiated;


-(id)initWithAddress:(int)add ;

-(id)initWithAllParam:(int)add Identifier:(NSString *) _identifier MaxSpeed:(int)_max_speed ThumImage:(UIImage *)thumb;



@end
