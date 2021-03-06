/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "UIView.h"

#import "CKTranscriptButtonView.h"

@class UIPlacardButton;

@interface CKTranscriptHeaderView : UIView <CKTranscriptButtonView>
{
    id _transcriptButtonDelegate;
    UIPlacardButton *_callButton;
    UIPlacardButton *_faceTimeButton;
    UIPlacardButton *_contactsButton;
    UIPlacardButton *_loadMoreButton;
    BOOL _hasContact;
    BOOL _callingAvailable;
    BOOL _faceTimeAvailable;
    BOOL _isGroupMessage;
    BOOL _hasMoreMessages;
    BOOL _disableFirstButtonRow;
    BOOL _isPhoneTranscript;
}

+ (float)defaultHeight;
@property(nonatomic, getter=isFaceTimeAvailable) BOOL faceTimeAvailable; // @synthesize faceTimeAvailable=_faceTimeAvailable;
- (void)_updateCallButton;
@property(nonatomic, getter=isCallingAvailable) BOOL callingAvailable; // @synthesize callingAvailable=_callingAvailable;
@property(nonatomic) BOOL hasContact; // @synthesize hasContact=_hasContact;
@property(nonatomic) BOOL hasMoreMessages; // @synthesize hasMoreMessages=_hasMoreMessages;
@property(nonatomic) BOOL disableFirstButtonRow; // @synthesize disableFirstButtonRow=_disableFirstButtonRow;
- (id)initWithFrame:(struct CGRect)arg1 isPhoneTranscript:(BOOL)arg2 displayLoadPrevious:(BOOL)arg3 isGroupMessage:(BOOL)arg4;
- (void)dealloc;
- (struct CGSize)sizeThatFits:(struct CGSize)arg1;
- (void)layoutSubviews;
- (struct CGRect)frameForButton:(short)arg1;
- (void)setButtonsEnabled:(BOOL)arg1;
- (void)_buttonClicked:(id)arg1;
@property(readonly, nonatomic) BOOL isGroupMessage; // @synthesize isGroupMessage=_isGroupMessage;
@property(nonatomic) id <CKTranscriptButtonViewDelegate> transcriptButtonDelegate; // @synthesize transcriptButtonDelegate=_transcriptButtonDelegate;

@end

