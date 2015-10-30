//
//  AuthorizeViewController.m
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "AuthorizeViewController.h"

@interface AuthorizeViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) completionBlock myBlock;

@end

@implementation AuthorizeViewController

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle onComplete:(completionBlock)completion {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
        self.myBlock = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Вход";
    
    NSString *urlString = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?""client_id=5127395&""redirect_uri=https://success&""display=mobile&""scope=friends&""response_type=token&v=5.37&revoke=1"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    //[self.webView ]
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", [[request URL] host]);
    if ([[[request URL] host] isEqualToString:@"success"]) {
        NSString *absoluteString = [[request URL] absoluteString];
        NSArray *tokenArray = [absoluteString componentsSeparatedByString:@"#"];
        NSArray *elementArray = [tokenArray.lastObject componentsSeparatedByString:@"&"];
        AccessToken * accessToken = [[AccessToken alloc] init];

        if (elementArray.count > 2) {
            accessToken.token = [elementArray[0] componentsSeparatedByString:@"="].lastObject;
            accessToken.expireTime = [elementArray[1] componentsSeparatedByString:@"="].lastObject;
            accessToken.userID = [elementArray[2] componentsSeparatedByString:@"="].lastObject;
            if (self.myBlock) {
                self.myBlock(accessToken);
            }
        }
        

    }
    
    return YES;
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
