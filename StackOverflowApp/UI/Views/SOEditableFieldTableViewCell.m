//
//  SOEditableFieldTableViewCell.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOEditableFieldTableViewCell.h"

@interface SOEditableFieldTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation SOEditableFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.textField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
}

-(void)setContent:(SOEditableField *)content{
    
    _content = content;
    
    if (content.numeric) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    self.textField.text = content.value;
    self.textField.placeholder = content.name;
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    self.content.value = textField.text;
}



@end
