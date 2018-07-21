//
//  AppDelegate.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "AppDelegate.h"
#import "SJViewController.h"
#import "FindViewController.h"
#import "MYViewController.h"
#import "NOVMessageViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    UITabBarController *tabBar;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    FindViewController *findViewController = [[FindViewController alloc] init];
    UINavigationController *findNavigation = [[UINavigationController alloc] initWithRootViewController:findViewController];
    findNavigation.tabBarItem.image = [[UIImage imageNamed:@"发现.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"发现-1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findNavigation.tabBarItem.title = @"发现";
    [findNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [findNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00]} forState:UIControlStateSelected];
    
    SJViewController *sjViewController = [[SJViewController alloc] init];
    UINavigationController *sjNavigation = [[UINavigationController alloc] initWithRootViewController:sjViewController];
    sjNavigation.tabBarItem.image = [[UIImage imageNamed:@"书架.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sjNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"书架-1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sjNavigation.tabBarItem.title = @"书架";
    [sjNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [sjNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00]} forState:UIControlStateSelected];
    
    NOVMessageViewController *messgeViewController = [[NOVMessageViewController alloc] init];
    UINavigationController *messageNavgation = [[UINavigationController alloc] initWithRootViewController:messgeViewController];
    messageNavgation.tabBarItem.image = [[UIImage imageNamed:@"消息.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageNavgation.tabBarItem.selectedImage = [[UIImage imageNamed:@"消息-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageNavgation.tabBarItem.title = @"消息";
    [messageNavgation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [messageNavgation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00]} forState:UIControlStateSelected];
    
    MYViewController *myViewcontroller = [[MYViewController alloc] init];
    UINavigationController *myNavigation = [[UINavigationController alloc] initWithRootViewController:myViewcontroller];
    myNavigation.tabBarItem.image = [[UIImage imageNamed:@"账户"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"账户-1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myNavigation.tabBarItem.title = @"账户";
    [myNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [myNavigation.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00]} forState:UIControlStateSelected];
    
    tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = [NSArray arrayWithObjects:findNavigation,sjNavigation,messageNavgation,myNavigation,nil];
    tabBar.tabBar.barTintColor = [UIColor whiteColor];
    tabBar.tabBar.translucent = NO;
    tabBar.selectedViewController = findNavigation;
    
    ViewController *viewController = [[ViewController alloc] init];
    self.window.rootViewController = viewController;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signsucceed) name:@"signinSucceed" object:nil];
    return YES;
}

- (void)signsucceed{
    self.window.rootViewController = tabBar;
}

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
