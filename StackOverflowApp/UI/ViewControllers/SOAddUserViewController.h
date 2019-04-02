//
//  SOAddUserViewController.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOUser.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SOAddUserViewControllerDelegate <NSObject>

- (void)addUserViewControllerAddUserTapped:(SOUser*)user;

@end

@interface SOAddUserViewController : UIViewController

@property (nonatomic,weak) id<SOAddUserViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
