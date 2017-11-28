//
//  SalaryModel.h
//  算工资
//
//  Created by mao on 2017/9/20.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalaryModel : NSObject 

@property(nonatomic, copy) NSNumber *money;

@property(nonatomic, copy) NSNumber *ratio;

@property(nonatomic, copy) NSString *name;

- (id)initWithMoney:(NSNumber *)money ratio:(NSNumber *)ratio name:(NSString *)name;

@end
