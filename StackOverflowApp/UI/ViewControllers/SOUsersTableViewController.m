//
//  SOUsersTableViewController.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOUsersTableViewController.h"
#import "SOAPI.h"
#import "SOUserTableViewCell.h"
#import "SOAddUserViewController.h"

@interface SOUsersTableViewController () <SOAddUserViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray <SOUser*> *users;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation SOUsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Stack Overflow Users";
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [self.view addSubview:self.activityIndicator];
    [self addPlusButton];
    
    [self requestUsers];
}

-(void)addPlusButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
}

-(void)addButtonPressed {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"  bundle:nil];
    SOAddUserViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SOAddUserViewController"];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:true];
    
}

-(void)requestUsers{
    [self.activityIndicator startAnimating];
    [SOAPI requestUsersWithCompletion:^(NSError * _Nullable error, NSArray<SOUser *> * _Nullable users) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Looks like there is no connection" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self requestUsers];
                }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            if (users){
                
                self.users = [NSMutableArray arrayWithArray:users];
                [self.tableView reloadData];
                
            }
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.users.count;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString * const identifier = @"SOUserTableViewCell";
    
    SOUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SOUserTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    cell.user = self.users[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
}

- (void)addUserViewControllerAddUserTapped:(SOUser *)user {
    [self.users addObject:user];
    [self.tableView reloadData];
}


@end
