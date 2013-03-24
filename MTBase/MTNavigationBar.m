#import <QuartzCore/QuartzCore.h>
#import "MTNavigationBar.h"

static NSString *imageName = @"MTNavigationBar.png";
static UIColor *tintClr = nil;

@interface MTNavigationBar ()
{
    UIImage* _image;
}
@end

@implementation MTNavigationBar
+ (void)setImage:(NSString*)name
{
    imageName = name;
}

+ (void)setTintColor:(UIColor*)color
{
    tintClr = color;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _image = [UIImage imageNamed:imageName];
    self.tintColor = tintClr;

    [[self layer] setMasksToBounds:NO];
    [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self layer] setShadowOffset:CGSizeMake(0, 3)];
    [[self layer] setShadowOpacity:0.3];
    [[self layer] setShadowRadius:1.0];
    [[self layer] setShadowPath:[UIBezierPath bezierPathWithRect:self.bounds].CGPath];
}

- (void)drawRect:(CGRect)rect
{
    [_image drawInRect:rect];
}

@end
