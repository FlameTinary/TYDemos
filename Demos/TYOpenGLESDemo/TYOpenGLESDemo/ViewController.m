//
//  ViewController.m
//  TYOpenGLESDemo
//
//  Created by 田宇 on 2019/5/31.
//  Copyright © 2019 田宇. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES3/glext.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

BOOL CheckForExtension(NSString * searchName)
{
    int max = 0;
    glGetIntegerv(GL_NUM_EXTENSIONS, &max);
    NSMutableSet *extensions = [NSMutableSet set];
    for (int i = 0; i < max; i++) {
        [extensions addObject:@((char *)glGetStringi(GL_EXTENSIONS, i))];
    }
    return [extensions containsObject:searchName];
}


@end
