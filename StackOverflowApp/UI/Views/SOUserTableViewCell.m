//
//  SOUserTableViewCell.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOUserTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SOUserTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverLabel;
@property (weak, nonatomic) IBOutlet UILabel *bronzeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gravatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *reputationLabel;

@end

@implementation SOUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setUser:(SOUser *)user{
    _user = user;
    
    [self.gravatarImageView sd_setImageWithURL:user.profileImageURL];
    self.usernameLabel.text = user.displayName;
    self.reputationLabel.text = user.reputation.stringValue;
    self.goldLabel.text = user.goldNumber.stringValue;
    self.silverLabel.text = user.silverNumber.stringValue;
    self.bronzeLabel.text = user.bronzeNumber.stringValue;
    
}

@end
