//
//  SCWelcomeViewController.m
//  StickyCollectionView
//
//  Created by Bogdan Matveev on 07.12.15.
//  Copyright © 2015 Bogdan Matveev. All rights reserved.
//

#import "SCWelcomeViewController.h"

@interface SCWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation SCWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.backgroundImageView.bounds;
    [self.backgroundImageView addSubview:visualEffectView];
}

@end
