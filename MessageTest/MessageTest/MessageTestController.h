//
//  MessageTestController.h
//  MessageTest
//
//  Created by EinFachMann on 13-12-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController.h"

@interface MessageTestController : NSObject <BBWeeAppController,UITextFieldDelegate>
{
    UIView *_view;
}

- (UIView *)view;

@end