#import "WPSViewController.h"
#import <WPStatsViewController.h>

@interface WPSViewController ()

@property (nonatomic, strong) WPStatsViewController *statsViewController;

@end

@implementation WPSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#warning You have to replace the site ID & OAuth2 token with one generated by the WP.com API
    self.statsViewController = [[WPStatsViewController alloc] initWithSiteID:nil andOAuth2Token:nil];
    [self addChildViewController:self.statsViewController];
    [self.view addSubview:self.statsViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end