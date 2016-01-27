//
//  ViewController.m
//  正则表达式
//
//  Created by 苏浩楠 on 16/1/27.
//  Copyright (c) 2016年 苏浩楠. All rights reserved.
//

#import "ViewController.h"

#import "RegexKitLite.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self checkEmotion];
    [self checkEmotionRegex];
    
}

//第三方正则匹配
- (void)checkEmotionRegex{
    
    NSString *str = @"5436786[happy]785435[哈哈]5437895789435[大笑]957894";
    NSString *regex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    //获得匹配到的表情
//    [str enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));
//    }];
    
    //根据匹配到的表情分割，得到分割后的字符
    [str enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));

    }];
}


//匹配QQ号
- (void)checkQQ {
    // QQ : 5 ~ 12，全部都是数字
    NSString *str = @"8882341";
    // 1.产生一个正则表达式对象
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{5,12}" options:NSRegularExpressionCaseInsensitive error:nil];
    //2.匹配
    NSArray *matches = [regex matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    if (matches.count) { // 有匹配结果
        NSLog(@"匹配成功");
        for (NSTextCheckingResult *matchResult in matches) {
            NSLog(@"%@", NSStringFromRange(matchResult.range));
        }
        if (str.length <= 12) {
            NSLog(@"QQ合法");
        } else {
            NSLog(@"匹配失败");
        }
    }
}
//匹配手机号
- (void)checkPhone {
    // 手机：13\15\18 + 9位数字
    NSString *str = @"18564565565";
    
    // 使用正则表达式判断是否为电话号码
    // 1.产生一个正则表达式对象
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"1[358]\\d{9}$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    // 2.匹配
    NSArray *matches = [regex matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    if (matches.count) { // 有匹配结果
        NSLog(@"匹配成功");
    } else {
        NSLog(@"匹配失败");
    }
}
//匹配表情
- (void)checkEmotion {
    NSString *str = @"5436786[happy]785435[哈哈]5437895789435[大笑]957894";
    // 1.产生一个正则表达式对象
    // ? 0个或者1个
    // * 0个或者多个
    // + 1个或者多个
    
    // unicode 汉字
    // \u4e00-\u9fa5
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //匹配
    NSArray *matches = [regex matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    if (matches.count) {
        for (NSTextCheckingResult *matchResult in matches) {
            NSLog(@"%@ %@", NSStringFromRange(matchResult.range), [str substringWithRange:matchResult.range]);
        }
    } else {
        NSLog(@"匹配失败");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
