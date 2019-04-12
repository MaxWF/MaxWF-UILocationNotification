//
//  AppDelegate.m
//  UILocationNotification
//
//  Created by 吴凡 on 2018/10/31.
//  Copyright © 2018 吴凡. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	
//	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//	dispatch_async(dispatch_get_main_queue(), ^{
//
//	});
	
	// 使用 UNUserNotificationCenter 来管理通知
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	// 设置代理为self
	center.delegate = self;
	
	[center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
	}];
	
	// 注册一个本地的通知
	[self registerNotification:20];
	
	return YES;

}

-(void)registerNotification:(NSInteger )alerTime {

	// 1.使用 UNUserNotificationCenter 来管理通知
	UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
	
	// 2.需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
	UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
	content.title = @"这是一条通知的标题";
	content.body = @"这是一条通知的主体";
	content.sound = [UNNotificationSound defaultSound];
	
	// 在 alertTime 后推送本地推送,repeats:是否重复
	UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alerTime repeats:NO];
	
	// 新建一个推送请求
	UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"Notification" content:content trigger:trigger];
	
	//添加推送成功后，弹出提示框
	[center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
		[alert addAction:cancelAction];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
	}];

}

//- (void)setUserNotificationSettings:(UIApplication *)application{
//
//	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//	center.delegate = self;
//	if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//		UNAuthorizationOptions types10 = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
//		[center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
//			if (granted) {
//				NSLog(@"注册iOS10.0以上版本本地通知成功");
//				[center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//
//				}];
//			}else{
//				NSLog(@"本地通知失败");
//			}
//		}];
//	}
//
//}



- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
