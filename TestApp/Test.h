//
//  Test.h
//  TestApp
//
//  Created by Anton Kuznetsov on 19.06.2018.
//  Copyright © 2018 AntonKuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) NSDictionary *answers;
@property (strong, nonatomic) NSMutableDictionary *userAnswers;
@property (assign, nonatomic) int userResult;

+ (instancetype) sharedInstance;
- (void) calculateUserResult;

@end
