//
//  ViewController.h
//  InAppPurchaseFreeSample
//
//  Created by hirauchi.shinichi on 2016/04/03.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CargoBay.h"

@interface ViewController : UIViewController

- (void) purchased:(SKPaymentTransaction *)transaction;// 購入完了の処理
- (void) appendLog:(NSString *)log; // ログの追加

@end

