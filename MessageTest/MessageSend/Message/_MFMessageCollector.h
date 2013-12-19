/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSObject.h"

#import "MessageConsumer.h"
#import "QueryProgressMonitor.h"

@class NSMutableArray;

@interface _MFMessageCollector : NSObject <MessageConsumer, QueryProgressMonitor>
{
    NSMutableArray *messages;
}

- (id)init;
- (void)dealloc;
- (id)messages;
- (id)copyMessages;
- (void)newMessagesAvailable:(id)arg1;
- (BOOL)shouldCancel;

@end

