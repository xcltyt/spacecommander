
#import "ViewController.h"

@protocol myProtocol <NSObject>

- (void)goTo;

@end


@interface ViewController ()
{
   @private

    int one;
    int two;
}

@property NSString *str;

@end


@implementation ViewController

- (void)viewDidLoad
{
    //注释
    [super viewDidLoad];  //注释1
[self methodOne:@""]; //注释2

    [self methodTwoInView:@""]; //注释3
}

//方法一
- (void)methodOne:(NSString *)str
{
    int i = 10;
    int j = 0;

    NSString *msg = @"1234";
    NSString *result = @"5678";


    while (i > 0) {
        i--;
        j++;}


    NSLog(@"%@--%@--%d", msg, result, j);
}

//方法二
- (void)methodTwoInView:(NSString *)str
{
    if ([str isEqualToString:@""]) {
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
