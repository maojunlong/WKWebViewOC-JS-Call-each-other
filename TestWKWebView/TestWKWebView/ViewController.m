//
//  ViewController.m
//  TestWKWebView
//
//  Created by mao on 2017/8/15.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<WKScriptMessageHandler,WKUIDelegate>

@property(nonatomic, weak) WKWebView * wkWeb;

@property(nonatomic, weak) UIButton * invokeBtn;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    NSError *error = nil;
    NSStringEncoding encode;
    NSString *htmlStr = [[NSString alloc] initWithContentsOfFile:path usedEncoding:&encode error:&error];
    
   // NSString *htmlStr =[[NSString alloc] initWithContentsOfFile:@"index.html" encoding:NSUTF8StringEncoding error:&error];
    
    if (!error) {
        [self.wkWeb loadHTMLString:htmlStr baseURL:nil];
    }
    else {
        NSLog(@"error description:%@",[error description]);
    }
    
    [self.invokeBtn setBackgroundColor:[UIColor yellowColor]];
    
    [self registerActions];
}


- (void)registerActions {
    //OC注册供JS调用的方法
    [[self.wkWeb configuration].userContentController addScriptMessageHandler:self name:@"closeMe"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - js 调用 oc

// js 通过 name 调用 OC方法
//                window.webkit.messageHandlers.closeMe.postMessage("s");
// message.name  ----> closeMe
// message.body  ----> s
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message.name  ---->%@",message.name);
    NSLog(@"message.body  ---->%@",message.body);
}

#pragma mark - oc 执行 js

- (void)executeJS {
    //javaScriptString是JS方法名，completionHandler是异步回调block
    NSString *javaScriptString = [NSString stringWithFormat:@"ocInvokeJSFunction(\"%@\")",@"new btn title"];
    [self.wkWeb evaluateJavaScript:javaScriptString completionHandler:^(id object,NSError *error) {
        if (!error) {
            NSLog(@"success");
        }
        else {
            NSLog(@"%@", error.description);
        }
    }];
}

#pragma mark - alert
//下面3个方法网上摘录的
//http://www.cnblogs.com/n1ckyxu/p/5587722.html
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - lazy load

- (WKWebView *)wkWeb {
    if (!_wkWeb) {
        
        WKWebView *wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 20 - 40)];
        wk.contentScaleFactor = 1;
        wk.UIDelegate = self;
        [self.view addSubview:wk];
        _wkWeb = wk;
    }
    return _wkWeb;
}

- (UIButton *)invokeBtn {
    if (!_invokeBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"调用 JS" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(executeJS) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 40);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        _invokeBtn = btn;
    }
    
    return _invokeBtn;
}


@end
