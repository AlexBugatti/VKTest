//
//  LoginViewController.m
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthorizeViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *authButton;
@property (strong, nonatomic) AccessToken *accessToken;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authButton.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Actions

- (IBAction)authButtonTapped:(id)sender {
    AuthorizeViewController *authcontroller = [[AuthorizeViewController alloc] initWithNibName:@"AuthorizeViewController" bundle:nil onComplete:^(AccessToken *token) {
        self.accessToken = token;
    }];

    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:authcontroller];
    [self presentViewController:navigationController animated:YES completion:nil];
    
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
