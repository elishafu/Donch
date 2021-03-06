//
//  GoalViewController.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "GoalViewController.h"
#import "ExerciseViewController.h"
#import "DonchManager.h"
#import "Yoga.h"

@interface GoalViewController ()

@end

@implementation GoalViewController
@synthesize button1,button2,button3,button4,button5;
- (void)viewDidLoad
{
    [super viewDidLoad];
       
}
- (void)viewWillAppear:(BOOL)animated {
    NSArray *yogaList = [[DonchManager getInstance] listAllYoga];
    for (int i = 0; i < [yogaList count]; i++) {
        Yoga *yoga = [yogaList objectAtIndex:i];
        int tag = i + 1;
        UIButton *yogaButton = (UIButton *) [self.view viewWithTag:tag];
        [yogaButton setTitle:yoga.name forState:UIControlStateNormal];
        yogaButton.userInteractionEnabled = !yoga.status;
        [[self getYogaTimeLabel:tag] setText: [NSString stringWithFormat:@"%.1f min", [yoga.minutes doubleValue]]];
        [self getYogaBullet:tag].image = [UIImage imageNamed: yoga.status ? @"tableViewItem": @"tableViewItem2"];
        [self getYogaStatusImage:tag].image = [UIImage imageNamed: yoga.status ? @"tableViewTarget1": @"tableViewTarget2"];
    }

}
- (IBAction)selectExercise:(UIButton *)sender {
    NSArray *viewControllerArray =  [self.tabBarController viewControllers];
    for (UINavigationController *uiNaviController in viewControllerArray) {
        UIViewController *tabController = [[uiNaviController viewControllers] objectAtIndex:0];
        if ([tabController isKindOfClass:[ExerciseViewController class]]) {
            ExerciseViewController *exerciseController = (ExerciseViewController *) tabController;
            exerciseController.currentYogaIndex = sender.tag - 1;
            [self.tabBarController setSelectedIndex:[viewControllerArray indexOfObject:uiNaviController]];
        }
        
            
    }
}
- (UIImageView *) getYogaStatusImage: (NSInteger) tag {
    return (UIImageView *) [self.view viewWithTag:(tag + 10)];
}
- (UIImageView *) getYogaBullet: (NSInteger) tag {
    return (UIImageView *) [self.view viewWithTag:(tag + 20)];
}
- (UILabel *) getYogaTimeLabel: (NSInteger) tag {
    return (UILabel *) [self.view viewWithTag:(tag + 30)];
}
@end
