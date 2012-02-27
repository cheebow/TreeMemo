#import "outlineTreeController.h"

@implementation outlineTreeController

- (void)awakeFromNib
{
	[self addObserver:self
           forKeyPath:@"selection"
			  options:0 context:nil];
    [super awakeFromNib];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
					   ofObject:(id)object
						 change:(NSDictionary *)change
						context:(void *)context
{
	NSLog( @"Value changed.(%@, %@)\n", keyPath, change );
    if ([keyPath isEqualToString:@"selection"]) {
        [self didChangeValueForKey:@"canIndent"];
        [self didChangeValueForKey:@"canDedent"];
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (BOOL)canIndent {
    NSIndexPath *selectionPath = [self selectionIndexPath];
    if (!selectionPath) {
        return NO;
    }
	unsigned index = [selectionPath indexAtPosition:([selectionPath length] - 1)];
    if (index == 0) {
        return NO;
    }
	
	return YES;
}

- (BOOL)canDedent {
	id selection = [self selection];
    id parent = [selection valueForKeyPath:@"parent"];
	if (parent == nil || parent == NSMultipleValuesMarker || parent == NSNoSelectionMarker || parent == NSNotApplicableMarker) {
        return NO;
    }
	
	return YES;
}

- (IBAction)indentNode:(id)sender {
    NSIndexPath *selectionPath = [self selectionIndexPath];
    if (!selectionPath) {
        NSBeep();
        return;
    }
    
	id selection = [self selection];
	
	// The selection is one of the root notes.
	// Get all the root notes to find our sibling.
	id parentNote = [selection valueForKeyPath:@"parent"];
	NSArray *children = (parentNote  == nil) ? (NSArray *)[self content] : [[parentNote valueForKeyPath:@"children"] allObjects];
	
	children = [children sortedArrayUsingDescriptors:[self sortDescriptors]];
	
	unsigned index = [selectionPath indexAtPosition:([selectionPath length] - 1)];
    if (index == 0) {   // Cannot indent the top root node
        NSBeep();
    }
    else {
        id sibling = [children objectAtIndex:index - 1];
        [selection setValue:sibling forKeyPath:@"parent"];
    }
    
}

- (IBAction)dedentNode:(id)sender {
    /* The controller's -selection method will return a proxy to the object or objects that are actually selected.
	 */
	id selection = [self selection];
    id parent = [selection valueForKeyPath:@"parent"];
    
    // make sure exactly one object is selected.
	if (parent == nil || parent == NSMultipleValuesMarker || parent == NSNoSelectionMarker || parent == NSNotApplicableMarker) {
        NSBeep();
        return;
    }
	
	parent = [parent valueForKeyPath:@"parent"];
	
    [selection setValue:parent forKeyPath:@"parent"];
    
}

@end
