//
//  ViewController.m
//  Pass Preview
//
//  Created by Mustafa Ahmedani on 11/17/12.
//  Copyright (c) 2012 Mustafa Ahmedani. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, PKAddPassesViewControllerDelegate> {
    
    NSMutableArray *_passes;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (![PKPassLibrary isPassLibraryAvailable]) {
        
        [[[UIAlertView alloc] initWithTitle:@"Passbook not available" message:@"The Passbook library is not available" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        return;
    }
    
    _passes = [[NSMutableArray alloc] init];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSArray *passFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:nil];
    for (NSString * passFile in passFiles) {
        
        if ( [passFile hasSuffix:@".pkpass"] ) {
            
            [_passes addObject:passFile];
        }
    }
    
    if ([_passes count] ==1) {
        
        [self openPassWithName:[_passes objectAtIndex:0]];
    }
}

#pragma mark - Table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _passes.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    NSString *object = _passes[indexPath.row];
    cell.textLabel.text = object;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *passName = _passes[indexPath.row];
    [self openPassWithName: passName];
}

-(void) openPassWithName:(NSString *)name
{
    
    NSString *passFile = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSData *passData = [NSData dataWithContentsOfFile:passFile];
    NSError *error = nil;
    PKPass *newPass = [[PKPass alloc] initWithData:passData error:&error];
    
    if (error!=nil) {
        [[[UIAlertView alloc] initWithTitle:@"Passes error"
                                    message:[error
                                             localizedDescription]
                                   delegate:nil
                          cancelButtonTitle:@"Ooops"
                          otherButtonTitles: nil] show];
        return;
    }
    
    PKAddPassesViewController *addController = [[PKAddPassesViewController alloc] initWithPass:newPass];
    addController.delegate = self;
    [self presentViewController:addController animated:YES completion:nil];
}

#pragma mark - Pass controller delegate

-(void) addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
