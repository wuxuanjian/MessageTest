/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import <Message/MFMailDelivery.h>

@class MFSMTPConnection;

@interface MFSMTPDelivery : MFMailDelivery
{
    MFSMTPConnection *_connection;
}

- (void)dealloc;
- (Class)deliveryClass;
- (void)_openConnection;
- (id)newMessageWriter;
- (int)deliverMessageData:(id)arg1 toRecipients:(id)arg2;

@end

