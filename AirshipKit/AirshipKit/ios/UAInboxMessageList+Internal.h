/* Copyright 2010-2019 Urban Airship and Contributors */

#import "UAInboxMessageList.h"
#import "UAInboxAPIClient+Internal.h"
#import "UAInboxStore+Internal.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * SDK-private extensions to UAInboxMessageList
 */
@interface UAInboxMessageList ()

///---------------------------------------------------------------------------------------
/// @name Message List Internal Properties
///---------------------------------------------------------------------------------------

/**
 * The Inbox API client instance.
 */
@property (nonatomic, strong) UAInboxAPIClient *client;

/**
 * The User instance.
 */
@property (nonatomic, strong) UAUser *user;

/**
 * The inbox store.
 */
@property (nonatomic, strong) UAInboxStore *inboxStore;

/**
 * The current count of batch operations.
 */
@property (atomic, assign) NSUInteger batchOperationCount;

/**
 * The current count of retrieve operations.
 */
@property (atomic, assign) NSUInteger retrieveOperationCount;

/**
 * An array of messages in the inbox.
 */
@property (nonatomic, strong) NSArray<UAInboxMessage *> *messages;

/**
 * A dictionary of messages mapped to their IDs
 */
@property (nonatomic, strong) NSDictionary *messageIDMap;

/**
 * A dictionary of messages mapped to their URLs
 */
@property (nonatomic, strong) NSDictionary *messageURLMap;

///---------------------------------------------------------------------------------------
/// @name Message List Internal Methods
///---------------------------------------------------------------------------------------

/**
 * Loads the inbox with the current saved messages.
 */
- (void)loadSavedMessages;

/**
 * Factory method for creating an Inbox Message List
 *
 * @param user The user.
 * @param client The internal inbox API client.
 * @param config The config.
 * @return An allocated UAInboxMessageList instance.
 */
+ (instancetype)messageListWithUser:(UAUser *)user
                             client:(UAInboxAPIClient *)client
                             config:(UAConfig *)config;

/**
 * Factory method for creating an Inbox Message List. Used for testing.
 *
 * @param user The user.
 * @param client The internal inbox API client.
 * @param config The config.
 * @param inboxStore The inbox message store.
 * @param notificationCenter The notification center.
 * @return An allocated UAInboxMessageList instance.
 */
+ (instancetype)messageListWithUser:(UAUser *)user
                             client:(UAInboxAPIClient *)client
                             config:(UAConfig *)config
                         inboxStore:(UAInboxStore *)inboxStore
                 notificationCenter:(NSNotificationCenter *)notificationCenter;

@end

NS_ASSUME_NONNULL_END
