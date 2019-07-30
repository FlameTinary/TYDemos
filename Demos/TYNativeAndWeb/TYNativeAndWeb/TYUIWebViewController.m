//
//  TYUIWebViewController.m
//  TYNativeAndWeb
//
//  Created by Sheldon on 2019/4/1.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYUIWebViewController.h"

@interface TYUIWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TYUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    NSString *localHTMLPageName = @"TYTest";
    NSString *path = [[NSBundle mainBundle] pathForResource:localHTMLPageName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL];
    [_webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"TYLOG: the webview should start with request:%@", request);
    NSString *urlString = request.URL.absoluteString;
    
    // 执行OC方法
    if ([urlString containsString:@"sheldon://pop"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    return YES;
}

//开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"TYLOG: the webView did start load");
}
//网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"TYLOG: the webview did finished load");
    
    // 执行JS方法
    self.navigationItem.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [_webView stringByEvaluatingJavaScriptFromString:@"changeDemo('使用stringByEvaluatingJavaScriptFromString方法')"];
    NSString *jsReturnString = [_webView stringByEvaluatingJavaScriptFromString:@"returnFunc('返回的文字:')"];
    NSLog(@"js方法返回的字符串:%@", jsReturnString);
}
//网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"TYLOG: the webview did failed load with error:%@", error);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
