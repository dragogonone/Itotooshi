//
//  ResultViewController.h
//  Sayu
//
//  Created by USER on 2014/02/15.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface ResultViewController : UIViewController{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) UILabel *ResultLbl;
@property (strong, nonatomic) UILabel *ScoreLbl;
@property (strong, nonatomic) NSMutableArray *dataarr;
@property (strong, nonatomic) UIButton *Backbtn;

@end
