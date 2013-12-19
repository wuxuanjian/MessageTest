//
//  MessageTestController.m
//  MessageTest
//
//  Created by EinFachMann on 13-12-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MessageTestController.h"
#import "msmholle.h"


@interface MessageTestController()
{
    msmholle *_hollesms;
    UITextField* _textField1;
    UITextField* _textField;
}
@end

@implementation MessageTestController

- (UIView *)view
{
	if (_view == nil)
	{
		_view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 316, 320)];

		UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/MessageTest.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:55];
		UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
		bgView.frame = CGRectMake(2, 0, 316,320);
		[_view addSubview:bgView];
        
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(8, 4, 300, 35)];
        _textField1.backgroundColor = [UIColor whiteColor];
        _textField1.placeholder = @"输入发送文本";
        _textField1.borderStyle = UITextBorderStyleLine;
        _textField1.returnKeyType = UIReturnKeyDone;
        _textField1.delegate = self;
        [_view addSubview:_textField1];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 43, 300, 35)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"输入号段";
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_view addSubview:_textField];
        
        UIButton* but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 97, 150, 45);
        but.backgroundColor = [UIColor orangeColor];
        [but setTitle:@"发送" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [but addTarget:self action:@selector(butSelector) forControlEvents:UIControlEventTouchDown];
        [_view addSubview:but];
        
        
        UIButton* but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake(166, 97, 150, 45);
        but1.backgroundColor = [UIColor grayColor];
        [but1 setTitle:@"停止" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [but1 addTarget:self action:@selector(butSelector1) forControlEvents:UIControlEventTouchDown];
        [_view addSubview:but1];
        
        _hollesms = [[msmholle alloc] init];
	}

	return _view;
}

- (float)viewHeight
{
	return 300.0f;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(void)butSelector
{
    _hollesms.phoneTitle = _textField.text;
    _hollesms.messagetext = _textField1.text;
    [_hollesms planSendMessage];
}

-(void)butSelector1
{
    [_hollesms stopSendMessage];
    
}

@end