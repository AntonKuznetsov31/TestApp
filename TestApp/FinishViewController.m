//
//  FinishViewController.m
//  TestApp
//
//  Created by Anton Kuznetsov on 21.06.2018.
//  Copyright © 2018 AntonKuznetsov. All rights reserved.
//

#import "FinishViewController.h"
#import "Test.h"

@interface FinishViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userResultLabel;

@end

@implementation FinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[Test sharedInstance] calculateUserResult];
    self.userResultLabel.text = [NSString stringWithFormat:@"%d/5", [Test sharedInstance].userResult];
    
}

@end
