//
//  HighScoreViewController.m
//  Sayu
//
//  Created by USER on 2014/02/16.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController (){
    NSInteger scwidth;
    NSInteger scheight;
    NSInteger LabelNo;
}

@end

@implementation HighScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScreen *sc = [UIScreen mainScreen];
    CGRect rrr = sc.bounds;
    scwidth = rrr.size.width;
    scheight = rrr.size.height;
	// Do any additional setup after loading the view.
    LabelNo = 0;
    [self initLabel];
    [self ScoreDraw];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initLabel{
    NSLog(@"initLabel");
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    //    [ud removeObjectForKey:@"KEY_HighScore"];
    NSArray* arr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSLog(@"arr:%@",[arr description]);
    [defaults setObject:arr forKey:@"KEY_HighScore"];  // デフォルト設定（初回のみ）
    [defaults setObject:@"0" forKey:@"KEY_TotalFlick"];
    [ud registerDefaults:defaults];
    NSArray *higharr = [ud arrayForKey:@"KEY_HighScore"];
    
    _TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _Lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl5 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl6 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl7 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl8 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _Lbl9 = [[UILabel alloc] initWithFrame:CGRectMake(40, scheight, 300, 20)];
    _TitleLbl.text = @"HighScore";
    _Lbl0.text = [NSString stringWithFormat:@"  1: Score  %d",[higharr[0] intValue]];
    _Lbl1.text = [NSString stringWithFormat:@"  2: Score  %d",[higharr[1] intValue]];
    _Lbl2.text = [NSString stringWithFormat:@"  3: Score  %d",[higharr[2] intValue]];
    _Lbl3.text = [NSString stringWithFormat:@"  4: Score  %d",[higharr[3] intValue]];
    _Lbl4.text = [NSString stringWithFormat:@"  5: Score  %d",[higharr[4] intValue]];
    _Lbl5.text = [NSString stringWithFormat:@"  6: Score  %d",[higharr[5] intValue]];
    _Lbl6.text = [NSString stringWithFormat:@"  7: Score  %d",[higharr[6] intValue]];
    _Lbl7.text = [NSString stringWithFormat:@"  8: Score  %d",[higharr[7] intValue]];
    _Lbl8.text = [NSString stringWithFormat:@"  9: Score  %d",[higharr[8] intValue]];
    _Lbl9.text = [NSString stringWithFormat:@"10: Score  %d",[higharr[9] intValue]];
    _TitleLbl.center = CGPointMake(scwidth/2, 50);
    _TitleLbl.font =[UIFont systemFontOfSize:20];
    _TitleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_TitleLbl];
    [self.view addSubview:_Lbl0];
    [self.view addSubview:_Lbl1];
    [self.view addSubview:_Lbl2];
    [self.view addSubview:_Lbl3];
    [self.view addSubview:_Lbl4];
    [self.view addSubview:_Lbl5];
    [self.view addSubview:_Lbl6];
    [self.view addSubview:_Lbl7];
    [self.view addSubview:_Lbl8];
    [self.view addSubview:_Lbl9];
    
    _Backbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _Backbtn.frame = CGRectMake(scwidth/2-25, scheight-70, 50, 30);
    [_Backbtn setTitle:@"Back" forState:UIControlStateNormal];
    [_Backbtn addTarget:self
                 action:@selector(BackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Backbtn];
    
}





- (void)ScoreDraw{
    NSLog(@"ScoreDraw");
    
    {NSTimer *timer;
        timer = [NSTimer
                 scheduledTimerWithTimeInterval:0.01
                 target:self
                 selector:@selector(moveLabel:)
                 userInfo:nil
                 repeats:YES];
        
    }
    NSLog(@"FlickDraw");
}


- (void)moveLabel:(NSTimer *)timer {
    
    UILabel *label;
    float posYhosei;
    
    switch (LabelNo) {
        case 0://Result
            label = _Lbl0;
            posYhosei = 100;
            break;
        case 1://Result
            label = _Lbl1;
            posYhosei = 120;
            break;
        case 2://Flick
            label = _Lbl2;
            posYhosei = 140;
            break;
        case 3://Score
            label = _Lbl3;
            posYhosei = 160;
            break;
        case 4://Cool
            label = _Lbl4;
            posYhosei = 180;
            break;
        case 5://Good
            label = _Lbl5;
            posYhosei = 200;
            break;
        case 6://Late
            label = _Lbl6;
            posYhosei = 220;
            break;
        case 7://Cool
            label = _Lbl7;
            posYhosei = 240;
            break;
        case 8://Good
            label = _Lbl8;
            posYhosei = 260;
            break;
        case 9://Late
            label = _Lbl9;
            posYhosei = 280;
            break;
        default:
            posYhosei= 0;
            break;
    }
    float posX = label.center.x;
    float posY = label.center.y;
    //ラベルを移動させる
    posY -= 20;
    //端までアニメーションしたか判定
    //if ([self isLimitLabelX:posX]) posX = 0;
    //if ([self isLimitLabelY:posY]) posY = 0;
    //座標反映
    label.center = CGPointMake(posX, posY);
    
    if (posY < posYhosei){
        LabelNo++;
    }
    if(LabelNo >= 10){
        [timer invalidate];
    }
    
}

-(void)BackBtn:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}



















@end