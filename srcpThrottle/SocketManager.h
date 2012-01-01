//
//  SocketManager.h
//  srcpThrottle
//
//  Created by Andrea on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface SocketManager : NSObject <NSStreamDelegate>
{


    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
    NSMutableArray	*messages;

    NSString * reply;
    
}
@property (nonatomic,retain) NSInputStream *inputStream;
@property (nonatomic,retain) NSOutputStream *outputStream;
@property (nonatomic, retain) NSMutableArray *messages;


- (void)sendMessage:(NSString *)message;
-(void) Connect:(NSString *) server_address port:(int) port;
- (void) messageReceived:(NSString *)message;


@end
