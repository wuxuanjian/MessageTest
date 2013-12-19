/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSObject.h"

@class Account, AuthScheme, Connection;

@interface MFSASLAuthenticator : NSObject
{
    Connection *_connection;
    AuthScheme *_authScheme;
    Account *_account;
    int _authenticationState;
}

- (id)initWithAuthScheme:(id)arg1 account:(id)arg2 connection:(id)arg3;
- (void)dealloc;
- (id)authScheme;
- (id)account;
- (id)saslName;
- (BOOL)supportsInitialClientResponse;
- (id)responseForServerData:(id)arg1;
- (int)authenticationState;
- (void)setAuthenticationState:(int)arg1;
- (BOOL)justSentPlainTextPassword;
- (id)securityLayer;
- (BOOL)isUsingSSL;
- (BOOL)base64EncodeResponseData;
- (BOOL)couldRetry;
- (void)setMissingPasswordError;

@end

