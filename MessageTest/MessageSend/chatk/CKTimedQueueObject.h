/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSObject.h"

@class NSDate;

@interface CKTimedQueueObject : NSObject
{
    NSDate *_fireDate;
    id _obj;
}

- (void)dealloc;
- (int)compare:(id)arg1;
@property(retain, nonatomic) id obj; // @synthesize obj=_obj;
@property(retain, nonatomic) NSDate *fireDate; // @synthesize fireDate=_fireDate;

@end

