//
//  UIViewController+Extension.m
//  AlterIcon
//
//  Created by Admin on 2019/7/30.
//  Copyright © 2019 yzwl. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (Extension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method dismissM = class_getInstanceMethod(self.class, @selector(dismissAlertViewControllerPresentViewController:animated:completion:));
        //runtime 方法交换
        //通过拦截弹框事件，实现方法转换，从而去掉弹框
        method_exchangeImplementations(presentM, dismissM);
    });
}

- (void)dismissAlertViewControllerPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
    }
    
    [self dismissAlertViewControllerPresentViewController:viewControllerToPresent animated:animated completion:completion];
}

@end
