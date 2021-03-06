/* Copyright 2010-2019 Urban Airship and Contributors */

#import "UARegistrationDelegateWrapper+Internal.h"

@implementation UARegistrationDelegateWrapper


- (void)registrationSucceededForChannelID:(NSString *)channelID deviceToken:(NSString *)deviceToken {
    id strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(registrationSucceededForChannelID:deviceToken:)]) {
        [strongDelegate registrationSucceededForChannelID:channelID deviceToken:deviceToken];
    }
}

- (void)registrationFailed {
    id strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(registrationFailed)]) {
        [strongDelegate registrationFailed];
    }
}

- (void)notificationRegistrationFinishedWithAuthorizedSettings:(UAAuthorizedNotificationSettings)authorizedSettings
                                                 legacyOptions:(UANotificationOptions)legacyOptions
                                                    categories:(NSSet *)categories
                                                        status:(UAAuthorizationStatus)status {

    id strongDelegate = self.delegate;

    SEL newSelector = @selector(notificationRegistrationFinishedWithAuthorizedSettings:categories:);
    SEL newSelectorWithStatus = @selector(notificationRegistrationFinishedWithAuthorizedSettings:categories:status:);
    SEL oldSelector = @selector(notificationRegistrationFinishedWithOptions:categories:);

    if ([strongDelegate respondsToSelector:newSelector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongDelegate notificationRegistrationFinishedWithAuthorizedSettings:authorizedSettings categories:categories];
        });
    }

    if ([strongDelegate respondsToSelector:newSelectorWithStatus]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongDelegate notificationRegistrationFinishedWithAuthorizedSettings:authorizedSettings
                                                                        categories:categories
                                                                            status:status];
        });
    }

    if ([strongDelegate respondsToSelector:oldSelector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            UA_LWARN(@"Warning: %@ is deprecated and will be removed in SDK 11. Please use %@", NSStringFromSelector(oldSelector), NSStringFromSelector(newSelector));
            [strongDelegate notificationRegistrationFinishedWithOptions:legacyOptions categories:categories];
#pragma GCC diagnostic pop
        });
    }
}

- (void)notificationAuthorizedSettingsDidChange:(UAAuthorizedNotificationSettings)authorizedSettings
                                  legacyOptions:(UANotificationOptions)legacyOptions {

    id strongDelegate = self.delegate;

    SEL newSelector = @selector(notificationAuthorizedSettingsDidChange:);
    SEL oldSelector = @selector(notificationAuthorizedOptionsDidChange:);

    if ([strongDelegate respondsToSelector:newSelector]) {
        [strongDelegate notificationAuthorizedSettingsDidChange:authorizedSettings];
    }

    if ([strongDelegate respondsToSelector:oldSelector]) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        UA_LWARN(@"Warning: %@ is deprecated and will be removed in SDK 11. Please use %@", NSStringFromSelector(oldSelector), NSStringFromSelector(newSelector));
        [strongDelegate notificationAuthorizedOptionsDidChange:legacyOptions];
#pragma GCC diagnostic pop
    }
}

- (void)apnsRegistrationSucceededWithDeviceToken:(NSData *)deviceToken {
    id strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(apnsRegistrationSucceededWithDeviceToken:)]) {
        [strongDelegate apnsRegistrationSucceededWithDeviceToken:deviceToken];
    }
}

- (void)apnsRegistrationFailedWithError:(NSError *)error {
    id strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(apnsRegistrationFailedWithError:)]) {
        [strongDelegate apnsRegistrationFailedWithError:error];
    }
}

@end
