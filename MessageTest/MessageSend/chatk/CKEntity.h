/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

//#import "NSObject.h"
#import <Foundation/Foundation.h>

@class CKService, NSString, UIImage;

@interface CKEntity : NSObject
{
    int _addressBookUID;
    int _identifier;
    int _propertyType;
    BOOL _foundABNameForSender;
    BOOL _senderIsVoicemail;
    void *_abRecord;
    unsigned int _addressHash;
    CKService *_service;
    id _contactImageThumbnail;
}

+ (id)copyAllEntities;
+ (void)resetClassCache;
+ (id)contactImageThumbnailForMeCard;
- (void)resetCaches;
- (id)_initWithService:(id)arg1;
- (void)dealloc;
@property(readonly, nonatomic) NSString *rawAddress;
@property(readonly, nonatomic) NSString *name;
@property(readonly, nonatomic) unsigned int textTone; // @dynamic textTone;
- (void)setABRecord:(void *)arg1 withIdentifier:(int)arg2;
@property(readonly, nonatomic) struct __CFPhoneNumber *phoneNumberRef;
@property(readonly, nonatomic) NSString *normalizedRawAddress;
@property(readonly, nonatomic) unsigned int addressHash;
@property(readonly, nonatomic) BOOL hasContactImage;
@property(readonly, retain, nonatomic) UIImage *contactImageThumbnail;
@property(readonly, nonatomic) BOOL senderIsVoicemail; // @synthesize senderIsVoicemail=_senderIsVoicemail;
@property(readonly, nonatomic) BOOL foundABNameForSender; // @synthesize foundABNameForSender=_foundABNameForSender;
@property(nonatomic) int propertyType; // @synthesize propertyType=_propertyType;
@property(readonly, nonatomic) void *abRecord; // @synthesize abRecord=_abRecord;
@property(nonatomic) int identifier; // @synthesize identifier=_identifier;
@property(nonatomic) int addressBookUID; // @synthesize addressBookUID=_addressBookUID;
@property(readonly, nonatomic) CKService *service; // @synthesize service=_service;

@end

