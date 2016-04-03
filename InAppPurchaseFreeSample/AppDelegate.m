//
//  AppDelegate.m
//  InAppPurchaseFreeSample
//
//  Created by hirauchi.shinichi on 2016/04/03.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "AppDelegate.h"
#import "CargoBay.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // レスポンスを受け取る
    [[CargoBay sharedManager] setPaymentQueueUpdatedTransactionsBlock:^(SKPaymentQueue *queue, NSArray *transactions) {
        for (SKPaymentTransaction *transaction in transactions){ // 複数のトランザクションを受け取る場合がある
            NSArray *statusString = @[@"Purchasing",@"Purchased",@"Failed",@"Restored",@"Deferred"];
            NSString *log = [NSString stringWithFormat:@"\n>レスポンス Status=%@",statusString[transaction.transactionState]];
            [_viewController appendLog:log]; // ログの追加

            switch (transaction.transactionState) { // ステータスによって処理を分岐する
                case SKPaymentTransactionStatePurchasing:
                    //進行中
                    break;
                case SKPaymentTransactionStatePurchased:
                    //購入処理

                    [_viewController purchased:transaction]; //トランザクションの確認

                    [queue finishTransaction:transaction]; // トランザクションの終了
                    break;
                case SKPaymentTransactionStateFailed:
                    //失敗
                    [queue finishTransaction:transaction]; // トランザクションの終了
                    break;
                case SKPaymentTransactionStateRestored:
                    //リストア

                    [_viewController purchased:transaction]; //トランザクションの確認

                    [queue finishTransaction:transaction]; // トランザクションの終了
                    break;
                case SKPaymentTransactionStateDeferred:
                    //エラー
                    [queue finishTransaction:transaction]; // トランザクションの終了
                    break;
            }
        }
    }];



    //オブザーバー登録
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[CargoBay sharedManager]];
    
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
