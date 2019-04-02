//
//  SOAddUserViewController.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOAddUserViewController.h"
#import "SOEditableFieldTableViewCell.h"
#import "SOEditableField.h"
#import "UIButton+Animations.h"


@interface SOAddUserViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSArray<SOEditableField*>* editableFields;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation SOAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Users";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = false;
    
    SOEditableField *displayName = [[SOEditableField alloc] init];
    displayName.name = @"displayName";
    displayName.numeric = false;
    
    SOEditableField *reputation = [[SOEditableField alloc] init];
    reputation.name = @"reputation";
    reputation.numeric = true;
    
    SOEditableField *goldBadge = [[SOEditableField alloc] init];
    goldBadge.name = @"goldBadge";
    goldBadge.numeric = true;
    
    SOEditableField *silverBadge = [[SOEditableField alloc] init];
    silverBadge.name = @"silverBadge";
    silverBadge.numeric = true;
    
    SOEditableField *bronzeBadge = [[SOEditableField alloc] init];
    bronzeBadge.name = @"bronzeBadge";
    bronzeBadge.numeric = true;

    self.editableFields = [NSArray arrayWithObjects:displayName,reputation,goldBadge,silverBadge,bronzeBadge, nil];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}


- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}


- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    
    self.bottomConstraint.constant = keyboardSize.height;
    
    [UIView animateWithDuration:duration.floatValue animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    self.bottomConstraint.constant = 20.f;
    [self.tableView setContentOffset:CGPointZero animated:YES];
    
}

- (IBAction)addUserButtonTapped:(id)sender {
    
    
    for (int i = 0; i < self.editableFields.count; i++) {
        SOEditableField *editableField = self.editableFields[i];
        NSString *value = [editableField.value stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([value isEqual: @""] || value == nil) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]
                             atScrollPosition:UITableViewScrollPositionMiddle animated:true];
            [self.button shake];
            return;
        }
    }
    
    
    // creating user from input data
    SOUser *user = [[SOUser alloc] init];
    user.displayName = self.editableFields[0].value;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *reputationNumber = [f numberFromString:self.editableFields[1].value];
    user.reputation = reputationNumber;
    
    NSNumber *goldNumber = [f numberFromString:self.editableFields[2].value];
    user.goldNumber = goldNumber;
    
    NSNumber *silverNumber = [f numberFromString:self.editableFields[3].value];
    user.silverNumber = silverNumber;
    
    NSNumber *bronzeNumber = [f numberFromString:self.editableFields[4].value];
    user.bronzeNumber = bronzeNumber;
    
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(addUserViewControllerAddUserTapped:)]){
        [self.delegate addUserViewControllerAddUserTapped:user];
    }
    [self.navigationController popViewControllerAnimated:true];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString * const identifier = @"SOEditableFieldTableViewCell";
    
    SOEditableFieldTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SOEditableFieldTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    cell.content = self.editableFields[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.editableFields.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}


@end
