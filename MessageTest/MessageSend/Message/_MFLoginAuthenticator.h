/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import <Message/MFSASLAuthenticator.h>

@interface _MFLoginAuthenticator : MFSASLAuthenticator
{
    BOOL _justSentPassword;
}

- (id)saslName;
- (id)responseForServerData:(id)arg1;
- (BOOL)justSentPlainTextPassword;

@end

