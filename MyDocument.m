//
//  MyDocument.m
//  TreeMemo
//
//  Created by CHEEBOW on 08/06/18.
//  Copyright ?????????? 2008 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument
- (id)init 
{
    self = [super init];
    if (self != nil) {
        // initialization code
    }
    return self;
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}

@end
