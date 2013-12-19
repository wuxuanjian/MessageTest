/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import <Message/MessageLibrary.h>

@class MFWeakSet, NSDate, NSMutableSet, NSSet, NSString, NSTimer;

@interface MFMailMessageLibrary : MessageLibrary
{
    int _availability;
    NSDate *_lastUpdateDate;
    NSTimer *_commitTimer;
    double _beginTransactionTime;
    struct sqlite3 *_writerDB;
    struct __CFDictionary *_mailboxCache;
    NSMutableSet *_cachedDatabases;
    struct __CFDictionary *_statementCachesByDB;
    double _dateDatabaseBecameLocked;
    struct _opaque_pthread_mutex_t _dbLock;
    struct _opaque_pthread_mutex_t _seqNumbersLock;
    struct _opaque_pthread_mutex_t _priorityLock;
    struct dispatch_queue_s *_writingQueue;
    BOOL _outstandingWritesExist;
    BOOL _writerDBIsBeingUsedAsReader;
    void *_ICUSearchContext;
    void *_CPSearchContext;
    id <MFMailboxPathProvider> _mailboxPathProvider;
    void *resetHandler;
    void *_busyHandler;
    void *_busyHandlerContext;
    MFWeakSet *_accounts;
    NSString *_activeAccountClause;
    id <MFLibraryMigrationHandler> _migrationHandler;
    unsigned int _attached:1;
    NSSet *_messagesToUpdateThreadingInfo;
}

+ (id)defaultInstance;
+ (unsigned long)priorityKey;
+ (void)initialize;
- (id)initWithPath:(id)arg1;
- (void)dealloc;
- (void)registerForMobileKeyBagNotifications;
- (void)deleteDatabaseAtPath:(id)arg1;
- (void)renameDatabaseAtPath:(id)arg1;
- (void)renameOrRemoveDatabase;
- (void)queueCommitOnMainThread;
- (void)scheduleCommitOnMainThread;
- (void)queueCommitForCurrentThread;
- (void)rescheduleCommit;
- (void)maybeCommitTransaction;
- (void)synchronouslyCommitTransaction;
- (void)commit;
- (void)setFlags:(unsigned long long)arg1 forMessage:(id)arg2;
- (void)setFlagsForMessages:(id)arg1 mask:(unsigned long long)arg2;
- (id)setFlagsFromDictionary:(id)arg1 forMessages:(id)arg2;
- (void)setNumberOfAttachments:(unsigned int)arg1 isSigned:(BOOL)arg2 isEncrypted:(BOOL)arg3 forMessage:(id)arg4;
- (void)setMessage:(id)arg1 isPartial:(BOOL)arg2;
- (BOOL)initializeDatabase:(struct sqlite3 *)arg1;
- (void)_invalidateActiveAccountsClause;
- (BOOL)_writeEmlxFile:(id)arg1 withBodyData:(id)arg2 protectionClass:(int)arg3;
- (void)notifyConversation:(long long)arg1 hasMergedIntoConversation:(long long)arg2;
- (void)notifyMessage:(unsigned int)arg1 hasConversationID:(long long)arg2;
- (id)referencesFromHeaders:(id)arg1;
- (id)addThreadingInfoBySubjectForMessageID:(unsigned int)arg1 nonPrefixedSubject:(id)arg2 messageIDsBySubject:(id)arg3 usingDatabase:(struct sqlite3 *)arg4 toReferences:(id)arg5 withinMailbox:(int)arg6;
- (long long)addReferencesForMessage:(id)arg1 libraryID:(unsigned int)arg2 messageIDHash:(long long)arg3 withSubject:(id)arg4 withReferences:(id)arg5 usingDatabase:(struct sqlite3 *)arg6 otherSubjectIDMappings:(id)arg7 usingMailbox:(int)arg8 notify:(BOOL)arg9;
- (id)addMessages:(id)arg1 withMailbox:(id)arg2 fetchBodies:(BOOL)arg3 newMessagesByOldMessage:(id)arg4 remoteIDs:(id)arg5 setFlags:(unsigned long long)arg6 clearFlags:(unsigned long long)arg7 messageFlagsForMessages:(id)arg8 copyFiles:(BOOL)arg9 addPOPUIDs:(BOOL)arg10 dataSectionsByMessage:(id)arg11;
- (void)updateRecipientsForMessage:(id)arg1 fromHeaders:(id)arg2;
- (void)updateThreadingInfoForMessage:(id)arg1 fromHeaders:(id)arg2;
- (void)setThreadPriority:(int)arg1;
- (int)threadPriority;
- (unsigned int)updateSequenceNumber;
- (unsigned int)accessSequenceNumber;
- (void)_rebuildActiveAccountsClause;
- (void)setBusyHandler:(void *)arg1 context:(void *)arg2;
- (void)iterateStatement:(struct sqlite3_stmt *)arg1 db:(struct sqlite3 *)arg2 withProgressMonitor:(id)arg3 andRowHandler:(void *)arg4 context:(void *)arg5;
- (void)sendMessagesForStatement:(struct sqlite3_stmt *)arg1 db:(struct sqlite3 *)arg2 to:(id)arg3 options:(unsigned int)arg4 timestamp:(unsigned long long)arg5;
- (void)sendMessagesMatchingQuery:(const char *)arg1 to:(id)arg2 options:(unsigned int)arg3;
- (id)messagesMatchingQuery:(const char *)arg1 options:(unsigned int)arg2;
- (id)messagesForMailbox:(id)arg1 olderThanNumberOfDays:(int)arg2;
- (id)serverSearchResultMessagesForMailbox:(id)arg1;
- (id)messagesNeedingSyncConfirmationForMailbox:(id)arg1;
- (id)dateOfOldestNonSearchResultMessageInMailbox:(id)arg1;
- (id)copyMessageInfosForMailbox:(id)arg1;
- (struct __CFSet *)copyLibraryIDsWithoutConversationHashesForMailbox:(id)arg1;
- (id)messagesWithSummariesForMailbox:(id)arg1 range:(struct _NSRange)arg2;
- (id)messagesWithoutSummariesForMailbox:(id)arg1;
- (id)messagesWithSummariesForMailbox:(id)arg1 fromRowID:(unsigned int)arg2 limit:(unsigned int)arg3;
- (id)messagesWithoutSummariesForMailbox:(id)arg1 fromRowID:(unsigned int)arg2 limit:(unsigned int)arg3;
- (unsigned int)integerForQuery:(id)arg1 withTextArgument:(id)arg2;
- (unsigned int)unreadCountForMailbox:(id)arg1;
- (unsigned int)deletedCountForMailbox:(id)arg1;
- (unsigned int)nonDeletedCountForMailbox:(id)arg1 includeServerSearchResults:(BOOL)arg2 includeThreadSearchResults:(BOOL)arg3;
- (unsigned int)nonDeletedCountForMailbox:(id)arg1;
- (unsigned int)totalCountForMailbox:(id)arg1;
- (id)oldestMessageInMailbox:(id)arg1;
- (id)messageWithRemoteID:(id)arg1 inRemoteMailbox:(id)arg2;
- (id)copyMessagesWithRemoteIDs:(id)arg1 options:(unsigned int)arg2 inRemoteMailbox:(id)arg3;
- (unsigned int)maximumRemoteIDForMailbox:(id)arg1;
- (unsigned int)minimumRemoteIDForMailbox:(id)arg1;
- (id)sequenceIdentifierForMailbox:(id)arg1;
- (void)setSequenceIdentifier:(id)arg1 forMailbox:(id)arg2;
- (id)sequenceIdentifierForMessagesWithRemoteIDs:(id)arg1 inMailbox:(id)arg2;
- (void)setSequenceIdentifier:(id)arg1 forMessageWithLibraryID:(unsigned int)arg2;
- (void)setSequenceIdentifier:(id)arg1 forMessagesWithRemoteIDs:(id)arg2 inMailbox:(id)arg3;
- (id)getDetailsForMessagesWithRemoteIDInRange:(struct _NSRange)arg1 fromMailbox:(id)arg2;
- (id)getDetailsForAllMessagesFromMailbox:(id)arg1;
- (id)messageWithMessageID:(id)arg1 options:(unsigned int)arg2 inMailbox:(id)arg3;
- (id)messagesWithMessageIDHeader:(id)arg1;
- (id)messageWithLibraryID:(unsigned int)arg1 options:(unsigned int)arg2 inMailbox:(id)arg3;
- (int)mailboxLocationOfMessageID:(unsigned int)arg1 usingDatabase:(struct sqlite3 *)arg2;
- (id)conversationIDsOfMessagesInSameThreadAsMessageWithLibraryID:(unsigned int)arg1 messageIDHash:(long long)arg2;
- (id)copyMessageInfosOfMessagesInSameThreadAsMessage:(id)arg1 onlyWithinMailbox:(BOOL)arg2;
- (struct __CFDictionary *)_copyReferenceHashesWithoutMessagesForMessageWithConversation:(id)arg1;
- (id)_getReferencesForHashesWithOwners:(struct __CFDictionary *)arg1;
- (int)countOfMessagesMissingFromThreadContainingMessage:(id)arg1;
- (int)loadMoreMessagesForThreadContainingMessage:(id)arg1 hasNoMoreMessages:(char *)arg2;
- (id)stringForQuery:(id)arg1 monitor:(id)arg2;
- (id)stringForQuery:(id)arg1;
- (id)urlForMailboxID:(unsigned int)arg1;
- (unsigned int)mailboxIDForURLString:(id)arg1;
- (id)pathForMailboxURL:(id)arg1;
- (id)mailboxURLForMessage:(id)arg1;
- (id)mailboxUidForMessage:(id)arg1;
- (id)remoteStoreForMessage:(id)arg1;
- (id)accountForMessage:(id)arg1;
- (BOOL)shouldCancel;
- (void)messagesWereCompacted:(id)arg1 mailboxes:(id)arg2;
- (void)compactMessages:(id)arg1 permanently:(BOOL)arg2;
- (void)compactMailbox:(id)arg1;
- (BOOL)renameMailboxes:(id)arg1 to:(id)arg2;
- (void)deleteMailboxes:(id)arg1;
- (void)removeAllMessagesFromMailbox:(id)arg1 removeMailbox:(BOOL)arg2 andNotify:(BOOL)arg3;
- (id)messageWithMessageID:(id)arg1 inMailbox:(id)arg2;
- (id)dataPathForMessage:(id)arg1 type:(int)arg2;
- (id)dataPathForMessage:(id)arg1;
- (id)attachmentsDirectoryForLibraryID:(unsigned int)arg1 mailboxID:(unsigned int)arg2;
- (id)dataPathForMessage:(id)arg1 part:(id)arg2;
- (id)dataConsumerForMessage:(id)arg1 part:(id)arg2;
- (id)dataConsumerForMessage:(id)arg1 part:(id)arg2 incomplete:(BOOL)arg3;
- (id)dataConsumerForMessage:(id)arg1 isPartial:(BOOL)arg2;
- (id)dataConsumerForMessage:(id)arg1;
- (void)setData:(id)arg1 forMessage:(id)arg2 isPartial:(BOOL)arg3;
- (BOOL)_setMessageData:(id)arg1 libraryID:(unsigned int)arg2 part:(id)arg3 partial:(BOOL)arg4 complete:(BOOL)arg5;
- (void)_setMessageDataString:(id)arg1 forKey:(id)arg2 forMessage:(id)arg3;
- (void)setSummary:(id)arg1 forMessage:(id)arg2;
- (void)updateMessage:(id)arg1 withMetadata:(id)arg2;
- (id)metadataForMessage:(id)arg1 key:(id)arg2;
- (id)loadMeetingDataForMessage:(id)arg1;
- (id)loadMeetingExternalIDForMessage:(id)arg1;
- (id)bodyDataAtPath:(id)arg1 headerData:(id *)arg2;
- (id)headerDataAtPath:(id)arg1;
- (id)bodyDataForMessage:(id)arg1 andHeaderDataIfReadilyAvailable:(id *)arg2 isComplete:(char *)arg3;
- (id)bodyDataForMessage:(id)arg1;
- (id)headerDataForMessage:(id)arg1;
- (id)fullBodyDataForMessage:(id)arg1 andHeaderDataIfReadilyAvailable:(id *)arg2;
- (id)dataForMimePart:(id)arg1 isComplete:(char *)arg2;
- (BOOL)hasCompleteDataForMimePart:(id)arg1;
- (BOOL)isMessageContentsLocallyAvailable:(id)arg1;
- (id)queryForCriterion:(id)arg1 options:(unsigned int)arg2 baseTable:(unsigned int)arg3 isSubquery:(BOOL)arg4 range:(struct _NSRange)arg5;
- (id)queryForCriterion:(id)arg1 options:(unsigned int)arg2 baseTable:(unsigned int)arg3 isSubquery:(BOOL)arg4;
- (id)queryForCriterion:(id)arg1 options:(unsigned int)arg2 baseTable:(unsigned int)arg3;
- (id)queryForCriterion:(id)arg1 options:(unsigned int)arg2 range:(struct _NSRange)arg3;
- (id)queryForCriterion:(id)arg1 options:(unsigned int)arg2;
- (void)sendMessagesMatchingCriterion:(id)arg1 to:(id)arg2 options:(unsigned int)arg3 range:(struct _NSRange)arg4;
- (void)sendMessagesMatchingCriterion:(id)arg1 to:(id)arg2 options:(unsigned int)arg3;
- (void)iterateMessagesMatchingCriterion:(id)arg1 withResultHandler:(id)arg2 options:(unsigned int)arg3 withMonitor:(id)arg4;
- (id)messagesMatchingCriterion:(id)arg1 options:(unsigned int)arg2 range:(struct _NSRange)arg3;
- (id)messagesMatchingCriterion:(id)arg1 options:(unsigned int)arg2;
- (id)filterContiguousMessages:(id)arg1 forCriterion:(id)arg2 options:(unsigned int)arg3;
- (int)createLibraryIDForAccount:(id)arg1;
- (int)libraryIDForAccount:(id)arg1;
- (void)deleteAccount:(id)arg1;
- (void)appendOfflineCacheOperation:(id)arg1 forAccount:(int)arg2 lastTemporaryID:(unsigned int)arg3;
- (void)markOfflineCacheOperationAsComplete:(id)arg1;
- (id)offlineCacheOperationsForAccount:(int)arg1 lastTemporaryID:(unsigned int *)arg2;
- (void)appendOfflineCacheReplayData:(id)arg1 forAccountID:(int)arg2;
- (void)consumeOfflineCacheReplayDataForAccount:(int)arg1 usingBlock:(id)arg2;
- (void)deleteOfflineCacheDataForAccount:(int)arg1;
- (void)setDatabasePath:(id)arg1;
- (id)defaultDatabasePath;
- (BOOL)isBusy;
- (void)setBusyTimeoutInterval:(double)arg1;
- (void)cleanOldDatabases;
- (void)closeDatabaseConnections;
- (void)deletePOPUID:(id)arg1 inMailbox:(id)arg2;
- (id)UIDsToDeleteInMailbox:(id)arg1;
- (id)deletedUIDsInMailbox:(id)arg1;
- (id)allUIDsInMailbox:(id)arg1;
- (id)hiddenPOPUIDsInMailbox:(id)arg1;
- (void)unlockDB:(struct sqlite3 *)arg1;
- (void)closeDB:(struct sqlite3 *)arg1;
- (void)checkInDB:(struct sqlite3 *)arg1;
- (void)setMigrationHandler:(id)arg1;
- (struct sqlite3 *)_getWriterDBWithRetryCount:(int)arg1;
- (struct sqlite3 *)setupWriterDB;
- (BOOL)cleanupProtectedTables:(struct sqlite3 *)arg1 checkForInconsistencies:(BOOL)arg2;
- (void)_reconcileJournal:(struct sqlite3 *)arg1;
- (int)attachProtectedDatabase:(struct sqlite3 *)arg1;
- (int)detachProtectedDatabase:(struct sqlite3 *)arg1;
- (void)handleKeybagLock;
- (void)handleKeybagUnlock;
- (struct sqlite3 *)openNewHandle;
- (BOOL)outstandingWritesExist;
- (struct sqlite3 *)getWriterDB;
- (struct sqlite3_stmt *)preparedStatement:(struct sqlite3 *)arg1 pattern:(id)arg2;
- (int)handleSqliteError:(struct sqlite3 *)arg1 format:(id)arg2;
- (void)lockDBForWriting;
- (void)_yieldDBToOtherProcess;
- (void)setMailAccounts:(id)arg1;
- (unsigned int)locationOfMessageID:(long long)arg1 inMailbox:(id)arg2;
- (void)setResetHandler:(void *)arg1;
- (void)setMailboxPathProvider:(id)arg1;
- (id)allMailboxURLStrings;
- (void)populateThreadingInfoForMessage:(id)arg1 withLibraryID:(unsigned int)arg2 andMailboxID:(int)arg3 withHeaders:(id)arg4 andMessageIDSubjectMapping:(id)arg5 inDatabase:(struct sqlite3 *)arg6;
- (void)populateAddressListInfoForLibraryID:(unsigned int)arg1 withHeaders:(id)arg2 inDatabase:(struct sqlite3 *)arg3;
- (id)populateExternalIDForLibraryID:(unsigned int)arg1 inDatabase:(struct sqlite3 *)arg2;
- (void)migrateExternalFilesForMessage:(id)arg1 withLibraryID:(unsigned int)arg2 andMailboxID:(int)arg3 externalID:(id)arg4 listingsByDirectory:(id)arg5;
- (void)populateInfo:(unsigned int)arg1 fromMessageDataForAllMessages:(struct sqlite3 *)arg2;
@property(readonly, nonatomic) int availability; // @synthesize availability=_availability;

@end

