/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSObject.h"

@class NSArray, NSAttributedString, NSDate, NSString;

@interface CKDBMessage : NSObject
{
    CDStruct_9d69e73c *_record;
    NSString *_text;
    NSString *_subject;
    NSString *_address;
    NSString *_groupID;
    NSString *_guid;
    NSString *_madridRoomname;
    NSString *_madridService;
    NSString *_madridAccount;
    NSString *_madridAccountGUID;
    BOOL _isMadrid;
    BOOL _isVoicemailIndicator;
    BOOL _hasBeenRead;
    BOOL _isOutgoing;
    BOOL _hasBeenDelivered;
    int _madridType;
    int _identifier;
    unsigned long long _madridFlags;
    NSDate *_date;
    NSArray *_recipients;
    NSArray *_messageParts;
    NSString *_plainBody;
    CDStruct_9d69e73c *_madridChatRecord;
    NSAttributedString *_madridAttributedBody;
    NSString *_voicemailString;
}

- (id)initWithMadridMessageGUID:(id)arg1;
- (id)initWithRecordID:(int)arg1;
- (void)dealloc;
- (id)description;
@property(readonly, nonatomic) BOOL hasAttachments; // @dynamic hasAttachments;
@property(readonly, copy, nonatomic) NSString *attachmentText; // @dynamic attachmentText;
@property(readonly, retain, nonatomic) NSString *formattedAddress; // @dynamic formattedAddress;
- (void)_loadSMSGroupID;
- (void)_loadMadridGroupID;
- (void)_loadGroupID;
@property(readonly, retain, nonatomic) NSString *groupID; // @dynamic groupID;
- (void)_loadMadridRecipients;
- (void)_loadSMSRecipients;
- (void)_loadRecipients;
@property(readonly, copy, nonatomic) NSArray *recipients; // @dynamic recipients;
- (void)_loadMadridPlainBody;
- (void)_loadSMSPlainBody;
@property(readonly, retain, nonatomic) NSString *plainBody;
- (void)_loadSMSMessageParts;
- (void)_loadMadridMessageParts;
- (void)_loadMessageParts;
- (id)_madridChatIdentifier;
- (void)_loadMadridChatRecord;
- (CDStruct_9d69e73c *)madridChatRecord;
- (BOOL)_madridHasAttachments;
- (struct __IMDMadridAttachmentRecord *)_copyMadridAttachmentRecordForGUID:(id)arg1;
@property(readonly, nonatomic) BOOL isMessageFullyLoaded;
- (id)voicemailString;
- (BOOL)senderIsVoicemail;
- (id)alertImageData;
- (id)previewText;
- (id)attachmentText:(BOOL)arg1;
@property(nonatomic) int identifier; // @synthesize identifier=_identifier;
@property(readonly, nonatomic) CDStruct_9d69e73c *record; // @synthesize record=_record;
@property(readonly, copy, nonatomic) NSArray *messageParts; // @synthesize messageParts=_messageParts;
@property(readonly, retain, nonatomic) NSAttributedString *madridAttributedBody; // @synthesize madridAttributedBody=_madridAttributedBody;
@property(readonly, retain, nonatomic) NSDate *date; // @synthesize date=_date;
@property(readonly, nonatomic) unsigned long long madridFlags; // @synthesize madridFlags=_madridFlags;
@property(readonly, nonatomic) int madridType; // @synthesize madridType=_madridType;
@property(readonly, nonatomic) BOOL hasBeenDelivered; // @synthesize hasBeenDelivered=_hasBeenDelivered;
@property(readonly, nonatomic) BOOL isOutgoing; // @synthesize isOutgoing=_isOutgoing;
@property(readonly, nonatomic) BOOL hasBeenRead; // @synthesize hasBeenRead=_hasBeenRead;
@property(readonly, nonatomic) BOOL isVoicemailIndicator; // @synthesize isVoicemailIndicator=_isVoicemailIndicator;
@property(readonly, nonatomic) BOOL isMadrid; // @synthesize isMadrid=_isMadrid;
@property(readonly, retain, nonatomic) NSString *madridAccountGUID; // @synthesize madridAccountGUID=_madridAccountGUID;
@property(readonly, retain, nonatomic) NSString *madridAccount; // @synthesize madridAccount=_madridAccount;
@property(readonly, retain, nonatomic) NSString *madridService; // @synthesize madridService=_madridService;
@property(readonly, retain, nonatomic) NSString *madridRoomname; // @synthesize madridRoomname=_madridRoomname;
@property(readonly, retain, nonatomic) NSString *guid; // @synthesize guid=_guid;
@property(readonly, retain, nonatomic) NSString *address; // @synthesize address=_address;
@property(readonly, retain, nonatomic) NSString *subject; // @synthesize subject=_subject;
@property(readonly, retain, nonatomic) NSString *text; // @synthesize text=_text;

@end

