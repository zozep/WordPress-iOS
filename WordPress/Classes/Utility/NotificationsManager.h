#import <Foundation/Foundation.h>

/**
 These notifications are sent when the user Registers / Unregisters for Push Notifications
 */
extern NSString *const NotificationsManagerDidRegisterDeviceToken;
extern NSString *const NotificationsManagerDidUnregisterDeviceToken;


@interface NotificationsManager : NSObject

///--------------------------------
/// @name Device Token registration
///--------------------------------

/**
 Register for push notifications with iOS
 */
+ (void)registerForPushNotifications;

/**
 Register to receive notifications from WordPress.com
 
 @param deviceToken received from applicationDidRegisterForRemoteNotifications:
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/**
 Perform cleanup when the registration for iOS notifications failed
 
 @param error detailing the reason for failure
 */
+ (void)registrationDidFail:(NSError *)error;

/**
 Unregister the device from WordPress.com notifications
 */
+ (void)unregisterDeviceToken;


/**
 Returns whether the app has Push Notifications Enabled in Settings.app
 @return Boolean, indicating whether Push Notifications are enabled, or not.
 */

+ (BOOL)pushNotificationsEnabledInDeviceSettings;

/**
 Retrieves and returns the last registered Device Token
*/
+ (NSString *)registeredPushNotificationsToken;

/**
 Retrieves and returns the current Device ID
 */
+ (NSString *)registeredPushNotificationsDeviceId;


///----------------------------
/// @name Notification Handling
///----------------------------

/**
 Handle the notification received, and call the completion handler for background work
 
 @param UIApplicationState at the time of receiving the notification
 @param completionHandler to call in order to complete the task.
        Pass the block the result of the fetch.
 */
+ (void)handleNotification:(NSDictionary *)userInfo forState:(UIApplicationState)state completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;


/**
 Handle a potential remote notification from application launch
 
 @param launchOptions The launch options dictionary passed
 */
+ (void)handleNotificationForApplicationLaunch:(NSDictionary *)launchOptions;

/**
 Handle an action taken from a remote notification
 
 @param identifier the identifier of the action
 @param remoteNotification the notification object
 */
+ (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification;

@end
