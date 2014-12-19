//
//  ViewController.m
//  Itotooshi
//
//  Created by USER on 2014/02/27.
//  Copyright (c) 2014年 USER. All rights reserved.
//
//タップスタートというワンクッションを置く

#import "GameViewController.h"
#import "ResultViewController.h"

#define jyuryoku 9.8

@interface GameViewController (){
    float basewid;
    float basehet;
    NSTimer *movetimer;
    bool gamestart;
    bool gamestopper;//Result画面からの接触を阻止
    NSInteger score;
    NSInteger itohajicnt;//糸の一番左の点のタグ
    NSInteger itoowacnt;//糸の一番右の点のタグ
    NSInteger ndlcnt;//針が出た総回数
    NSInteger holecnt;//くぐった針の回数
    NSInteger framecnt;
    float speedlvl;
    float gvtime;
    int gvhoukou;//1:下 -1:上
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScreen *sc = [UIScreen mainScreen];
    CGRect rrr = sc.bounds;
    basewid = rrr.size.width/2;
    basehet = rrr.size.height/2 ;
    
    [self initItem];
    
    gamestart = NO;
    gamestopper = NO;
    score = 0;
    itohajicnt = 1;
    itoowacnt = 1;
    ndlcnt = 0;
    holecnt = 0;
    framecnt = 120;
    speedlvl = 0;
    gvhoukou = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initItem{
    _Taptolbl = [[UILabel alloc] initWithFrame:CGRectMake(basewid-100, basehet, 200, 30)];
    _Taptolbl.text = @"Tap anywhere to start";
    _Taptolbl.textAlignment = NSTextAlignmentCenter;
    _Taptolbl.textColor = [UIColor whiteColor];
    [self.view addSubview:_Taptolbl];
    
    _Holelbl = [[UILabel alloc] initWithFrame:CGRectMake(10, basehet*2-50, 100, 30)];
    _Holelbl.text = @"Score: 0";
    _Holelbl.textAlignment = NSTextAlignmentCenter;
    _Holelbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_Holelbl];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(gamestopper){
        return;
    }
    if(!gamestart){
        gamestart = YES;
        [_Taptolbl removeFromSuperview];
        [self GameStart];
    }
    //重力を反転
    gvtime = 0;
    gvhoukou *= -1;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //重力を反転
    gvtime = 0;
    gvhoukou *= -1;
}

-(void)GameStart{
    NSLog(@"Start");
    
    
    
    movetimer =
    [NSTimer
     scheduledTimerWithTimeInterval:0.02f
     target:self
     selector:@selector(Move:)
     userInfo:nil
     repeats:YES
     ];
}

- (void)Move: (NSTimer *)timer{
    
    //既存の糸の点が動く
    float xx, yy;
    for(int i = itohajicnt;i<itoowacnt;i++){
        UIImageView *iv = (UIImageView *)[self.view viewWithTag:i];
        xx = iv.frame.origin.x-0.7;
        yy = iv.frame.origin.y;
        if(xx<0){
            [iv removeFromSuperview];
            itohajicnt++;
        }
            iv.frame = CGRectMake(xx, yy,3,3);
    }
    
    float newxx = xx;
    float newyy = yy + (jyuryoku * gvtime * gvhoukou);
    if(itoowacnt==1){newyy = basehet;}
    if(newyy<0 || newyy>basehet*2){
        NSLog(@"死因y番外");
        [self GameEnd];
        return;
    }
    
    //針くぐれるか判定
    UIImageView *ivt = (UIImageView *)[self.view viewWithTag:holecnt+10000];
    if(ivt.frame.origin.x!=0){
        if(newxx>ivt.frame.origin.x){
            float tty = ivt.frame.origin.y;
            if(tty<=newyy+2 && newyy<=tty+8){
                holecnt++;
                _Holelbl.text = [NSString stringWithFormat:@"Score:%2d",holecnt];
                [ivt removeFromSuperview];
            }else{
                NSLog(@"死因針接触");
                [self GameEnd];
                return;
            }
        }
    }
    
    //新しい糸の点を生成
    UIImage *img = [UIImage imageNamed:@"whitedot.png"];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
    imgview.frame = CGRectMake(basewid,newyy, 3, 3);
    [imgview setTag:itoowacnt];
    [self.view addSubview:imgview];
    itoowacnt++;
    
    
    //針が動く
    for(int i = holecnt;i<ndlcnt;i++){
        UIImageView *iv = (UIImageView *)[self.view viewWithTag:(i+10000)];
        xx = iv.frame.origin.x-0.7;
        yy = iv.frame.origin.y;
        iv.frame = CGRectMake(xx, yy,3,300);
    }
    
    
    framecnt++;
    gvtime += 0.01;
    if (framecnt>=150){
        [self Plushari];
        framecnt = 0;
    }
}

-(void)Plushari{
    UIImage *img = [UIImage imageNamed:@"hari3w6h.png"];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
    float yza = arc4random() % 300 + 100;
    imgview.frame = CGRectMake(basewid*2-1,yza, 3, 300);
    [imgview setTag:ndlcnt+10000];
    [self.view addSubview:imgview];
    ndlcnt++;}


-(void)GameEnd{
    gamestopper = YES;
    for (UIView* subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
    gamestart = NO;
    [self TimerStop];
    NSLog(@"GameEnd");

    appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.passarr addObject:@[
                                 [NSString stringWithFormat:@"%d",holecnt],
                                ]];
NSLog(@"passarr:%@", appDelegate.passarr);

NSString *str =  [NSString stringWithFormat:@"くぐった回数:%d",holecnt];
UIAlertView *alert =
[[UIAlertView alloc] initWithTitle:@"終了！" message:str
                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
[alert show];




}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ResultViewController *resultViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Result"];
    [self presentViewController:resultViewController animated:YES completion:^{NSLog(@"ModalToResult");}];
//    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void)TimerStop{
    //タイマーが動いているときにタイマー停止
    if ( movetimer != nil ) {
        if ([movetimer isValid]) {
            NSLog(@"TimerStop");
            [movetimer invalidate];
        }
    }
}













@end
