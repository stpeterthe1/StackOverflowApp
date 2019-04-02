//
//  SOUserTableViewCell.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface SOUserTableViewCell : UITableViewCell

@property (nonatomic,strong) SOUser *user;

@end

NS_ASSUME_NONNULL_END
