/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "RoToshiTiModTisocketioSocketProxy.h"

@implementation RoToshiTiModTisocketioSocketProxy

-(void)_initWithProperties:(NSDictionary *)properties
{
    NSURL* url = [[NSURL alloc] initWithString:[properties objectForKey:@"url"]];
    socket = [[SocketIOClient alloc] initWithSocketURL:url options:@{@"log": @YES, @"forcePolling": @YES}];
}

-(void)_destroy
{
    socket = nil;
    [super _destroy];
}

-(void)connect:(id)args
{
    [socket connect];
}

-(void)connectWithTimeoutAfter:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [socket connectWithTimeoutAfter:[args objectForKey:@"timeout"] withTimeoutHandler:^{
        [[args objectForKey:@"error"] call:@[] thisObject:nil];
    }];
}

-(void)on:(id)args
{
    NSString *eventName;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(eventName, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 1, KrollCallback);
    [socket on:eventName callback:^(NSArray *data, SocketAckEmitter* ack){
        [callback call: data thisObject:nil];
    }];
}

-(void)emit:(id)args
{
    NSString *eventName;
    NSDictionary *data;
    ENSURE_ARG_AT_INDEX(eventName, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(data, args, 1, NSDictionary);
    NSArray *dataArray = [[NSArray alloc] initWithObjects:data, nil];
    [socket emit: eventName withItems: dataArray];
}

-(void)disconnect:(id)args
{
    if(socket != nil){
        [socket disconnect];
    }
}

@end
