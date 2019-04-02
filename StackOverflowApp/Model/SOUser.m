//
//  SOUser.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOUser.h"

@implementation SOUser

- (instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        self.displayName = dict[@"display_name"];
        self.reputation = dict[@"reputation"];
        
        NSString *profileImageString = dict[@"profile_image"];
        if (profileImageString) {
            self.profileImageURL = [NSURL URLWithString:profileImageString];
        }
        
        NSDictionary *badgeCounts = dict[@"badge_counts"];
        if (badgeCounts) {
            self.goldNumber = badgeCounts[@"gold"];
            self.silverNumber = badgeCounts[@"silver"];
            self.bronzeNumber = badgeCounts[@"bronze"];
        }
        
    }
    return self;
}


@end
