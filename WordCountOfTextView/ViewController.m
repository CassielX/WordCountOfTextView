//
//  ViewController.m
//  WordCountOfTextView
//
//  Created by 夏鸿杰 on 15/12/28.
//  Copyright © 2015年 夏鸿杰. All rights reserved.
//

#import "ViewController.h"
#define MAXVALUE 10
#define MINVALUE 5

@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width / 2)];
    self.textView.backgroundColor = [UIColor yellowColor];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.font = [UIFont systemFontOfSize:16.0f];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, self.textView.frame.size.height + 110, 150, 50)];
    self.tipLabel.backgroundColor = [UIColor clearColor];
    self.tipLabel.font = [UIFont systemFontOfSize:12];
    self.tipLabel.text = [NSString stringWithFormat:@"字数不少于%d个字", MINVALUE];
    self.tipLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.tipLabel];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, self.tipLabel.frame.origin.y + self.tipLabel.frame.size.height + 100, self.view.frame.size.width - 200, 50)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor redColor];
    [nextBtn addTarget:self action:@selector(doBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

- (void)doBtn
{
    if (self.textView.text.length > MAXVALUE) {
        NSLog(@"可以弹一个toast，说明不能超过某个限制的数字");
    } else if (self.textView.text.length < MINVALUE){
        NSLog(@"可以弹一个toast，说明不能小于某个限制的数字");
    } else {
        NSLog(@"可以进行下一步");
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
        NSUInteger count = textView.text.length;
        if (MINVALUE > 0 && count < MINVALUE) {
            self.tipLabel.text = [NSString stringWithFormat:@"字数不少于%d个字", MINVALUE];
        } else {
            self.tipLabel.text = [NSString stringWithFormat:@"%ld/%ld字", (unsigned long)count, (long)MAXVALUE];
        }
}

@end
