//
//  SOEditableFieldTableViewCell.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOEditableField.h"

NS_ASSUME_NONNULL_BEGIN

@interface SOEditableFieldTableViewCell : UITableViewCell

@property (nonatomic,strong) SOEditableField *content;

@end

NS_ASSUME_NONNULL_END
