//
//  Test.m
//  TestApp
//
//  Created by Anton Kuznetsov on 19.06.2018.
//  Copyright © 2018 AntonKuznetsov. All rights reserved.
//

#import "Test.h"

@implementation Test

+ (instancetype) sharedInstance {
    static Test *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Test alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configTest];
    }
    return self;
}

- (void) configTest {
    NSString *firstQuestion = @"Кто из перечисленных был одним из основателей компании Apple?"; // 1
    NSString *secondQuestion = @"В каком году была основана компания Apple?";                   // 3
    NSString *thirdQuestion = @"Кто сегодня является генеральным директором компании Apple?";   // 2
    NSString *fourthQuestion = @"С каким устройством в 2007 году Apple вышла на рынок?";        // 1
    NSString *fifthQuestion = @"Какова капитализация Apple на международном рынке в долларах?"; // 2
    
    self.questions = [NSArray arrayWithObjects:firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion, nil];
    
    NSArray *firstAnswersArray = [NSArray arrayWithObjects:@"Стив Джобс", @"Билл Гейтс", @"Юрий Гагарин", nil];
    NSArray *secondAnswersArray = [NSArray arrayWithObjects:@"1812", @"2007", @"1976", nil];
    NSArray *thirdAnswersArray = [NSArray arrayWithObjects:@"Дональд Трамп", @"Тим Кук", @"Юрий Гагарин", nil];
    NSArray *fourthAnswersArray = [NSArray arrayWithObjects:@"iPhone", @"Микроволновая печь", @"Play Station 3", nil];
    NSArray *fifthAnswersArray = [NSArray arrayWithObjects:@"850 тсч", @"850 млрд", @"850 мм", nil];
    
    self.answers = [NSDictionary dictionaryWithObjectsAndKeys:
                    firstAnswersArray, [NSNumber numberWithInteger:0],
                    secondAnswersArray, [NSNumber numberWithInteger:1],
                    thirdAnswersArray, [NSNumber numberWithInteger:2],
                    fourthAnswersArray, [NSNumber numberWithInteger:3],
                    fifthAnswersArray, [NSNumber numberWithInteger:4],
                    nil];
    
    self.userAnswers = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     [NSNumber numberWithInteger:0], firstQuestion,
                     [NSNumber numberWithInteger:0], secondQuestion,
                     [NSNumber numberWithInteger:0], thirdQuestion,
                     [NSNumber numberWithInteger:0], fourthQuestion,
                     [NSNumber numberWithInteger:0], fifthQuestion,
                     nil];
    
}

// переборным циклом проходим по всем ответам и увеличиваем результат на 1 если есть совпадение с правильным ответом
// единое условие проверки задать нельзя, поэтому использую swicth
- (void) calculateUserResult {
    self.userResult = 0;
    for (int i = 0; i < self.questions.count; i ++) {
        switch (i) {
            case 0:
                if ([self.userAnswers objectForKey:self.questions[0]] == [NSNumber numberWithInteger:1]) {
                    self.userResult += 1;
                }
                break;
            case 1:
                if ([self.userAnswers objectForKey:self.questions[1]] == [NSNumber numberWithInteger:3]) {
                    self.userResult += 1;
                }
                break;
            case 2:
                if ([self.userAnswers objectForKey:self.questions[2]] == [NSNumber numberWithInteger:2]) {
                    self.userResult += 1;
                }
                break;
            case 3:
                if ([self.userAnswers objectForKey:self.questions[3]] == [NSNumber numberWithInteger:1]) {
                    self.userResult += 1;
                }
                break;
            case 4:
                if ([self.userAnswers objectForKey:self.questions[4]] == [NSNumber numberWithInteger:2]) {
                    self.userResult += 1;
                }
                break;
            default:
                break;
        }
    }
}

@end
