//
//  FourthViewController.m
//  TestApp
//
//  Created by Anton Kuznetsov on 19.06.2018.
//  Copyright © 2018 AntonKuznetsov. All rights reserved.
//

#import "FourthViewController.h"
#import "FifthViewController.h"
#import "Test.h"

@interface FourthViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSMutableArray *arrayOfAnswerButtons;

// дополнительные переменные для отслеживания поведения пользователя
@property (assign, nonatomic) BOOL answerChosen;    // устанавливаем YES, если пользователь выбрал ответ
@property (assign, nonatomic) id pressedButtonTag;  // сохраняем тэг нажатой кнопки, используя его сможем в дальнейшем менять цвет кнопок в зависимости от поведения пользователя

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.pressedButtonTag = nil;
    self.answerChosen = NO;
    
    self.arrayOfAnswerButtons = [NSMutableArray new];
    self.questionLabel.numberOfLines = 0;
    self.questionLabel.text = [[Test sharedInstance].questions objectAtIndex:3];
}

- (void) answerButtonPressed:(UIButton *) sender {
    // первый выбор ответа или смена ответа
    if (self.pressedButtonTag != [NSNumber numberWithInteger: sender.tag]) {
        
        // первый выбор ответа
        if (!self.answerChosen) {
            sender.backgroundColor = [UIColor colorWithRed:0 green:0.560 blue:0 alpha:1];
            self.nextButton.backgroundColor = [UIColor colorWithRed:0 green:0.329 blue:0.576 alpha:1];
            [self.nextButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            // смена ответа (пользователь нажал на другой ответ)
        } else if (self.answerChosen) {
            [self resetButtonsColor];
            sender.backgroundColor = [UIColor colorWithRed:0 green:0.560 blue:0 alpha:1];
        }
        // выбор сделан, сохранили тэг нажатой кнопки
        // сохранили ответ пользователя в модель по ключу
        // ключ - это сам вопрос, значение - ответ пользователя
        self.answerChosen = YES;
        self.pressedButtonTag = [NSNumber numberWithInteger: sender.tag];
        [[Test sharedInstance].userAnswers setValue:[NSNumber numberWithInteger: sender.tag + 1] forKey: self.questionLabel.text];
        
        // отмена выбора (пользователь передумал)
    } else if (self.pressedButtonTag == [NSNumber numberWithInteger: sender.tag]){
        self.answerChosen = NO;
        self.pressedButtonTag = nil;
        [[Test sharedInstance].userAnswers setValue:nil forKey: self.questionLabel.text];
        
        sender.backgroundColor = [UIColor lightGrayColor];
        [self.nextButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.nextButton.backgroundColor = [UIColor lightGrayColor];
    }
    
}

// устанавливает цвет всех кнопок серым
- (void) resetButtonsColor {
    for (UIButton *button in self.arrayOfAnswerButtons) {
        button.backgroundColor = [UIColor lightGrayColor];
    }
}

- (IBAction)nextButtonPressed:(UIButton *)sender {
    [self shouldPerformSegueWithIdentifier:@"fifthSegue" sender:self];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.answerChosen) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Table view data source protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    if (cell) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        self.tableView.separatorColor = [UIColor clearColor];
        
        UIButton *answerButton = [[UIButton alloc] initWithFrame:CGRectMake(13, 34, 60, 60)];
        
        // добавляем все кнопки в отдельный массив, чтобы можно было менять их цвет
        [self.arrayOfAnswerButtons addObject:answerButton];
        
        answerButton.backgroundColor = [UIColor lightGrayColor];
        UIColor *black = [UIColor blackColor];
        [answerButton setTitleColor:black forState:(UIControlStateNormal)];
        [answerButton setTitle:[NSString stringWithFormat:@"%ld", indexPath.row + 1 ] forState:(UIControlStateNormal)];
        answerButton.clipsToBounds = YES;
        answerButton.layer.cornerRadius = 60/2.0f;
        
        [answerButton addTarget:self action:@selector(answerButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
        answerButton.tag = indexPath.row;
        
        [cell addSubview:answerButton];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(91, 27, 247, 74)];
        NSArray *answersArray = [[Test sharedInstance].answers objectForKey: [NSNumber numberWithInteger:3]];
        label.text = [answersArray objectAtIndex:indexPath.row];
        [cell addSubview:label];
        
    }
    return cell;
}

#pragma mark - Table view delegate protocol

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

@end
