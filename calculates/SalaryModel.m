//
//  SalaryModel.m
//  算工资
//
//  Created by mao on 2017/9/20.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "SalaryModel.h"

@implementation SalaryModel

- (id)initWithMoney:(NSNumber *)money ratio:(NSNumber *)ratio name:(NSString *)name {
    
    if (self = [super init]) {
        
        self.money = money;
        self.ratio = ratio;
        self.name = name;
        
    }
    
    return self;
}

@end
