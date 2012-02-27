#import <Cocoa/Cocoa.h>

@interface outlineTreeController : NSTreeController {

}
- (IBAction)dedentNode:(id)sender;
- (IBAction)indentNode:(id)sender;

- (BOOL)canIndent;
- (BOOL)canDedent;
@end
