/**
 * @filename SBCUploadManagerTableViewController.h
 * @author Morgan Wall
 * @date 29-6-2014
 * @copyright Copyright 2014 Split Britches. All rights reserved.
 */

#import "SBCUploadManagerTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#pragma mark - Interface

@interface SBCUploadManagerTableViewController () <UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

/**
 * @brief The view controller responsible for accessing the camera.
 */
@property UIImagePickerController* cameraPicker;

/**
 * @brief The view controller for accessing multimedia files from the user's 
 * photo library.
 */
@property UIImagePickerController* albumPicker;

/**
 * @brief The UI button for adding a file for upload captured from the camera.
 */
@property UIBarButtonItem* cameraButton;

/**
 * @brief The UI button for adding a file for upload from the user's album.
 */
@property UIBarButtonItem* albumButton;

@end

#pragma mark - Implementation

@implementation SBCUploadManagerTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialise navigation elements
    self.cameraButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                      target:self
                                                      action:@selector(takePhoto)];
    self.navigationItem.rightBarButtonItem = self.cameraButton;
    
    self.albumButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(selectFromAlbum)];
    self.navigationItem.leftBarButtonItem = self.albumButton;
    
    // initialise camera picker
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.cameraPicker = [[UIImagePickerController alloc] init];
        self.cameraPicker.delegate = self;
        self.cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.cameraPicker.mediaTypes =
            [UIImagePickerController
             availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    // initialise album picker
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        self.albumPicker = [[UIImagePickerController alloc] init];
        self.albumPicker.delegate = self;
        self.albumPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.albumPicker.mediaTypes =
            [UIImagePickerController
             availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    } else {
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^(void) {
        
        NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        // handle image for file upload
        if (CFStringCompare((CFStringRef)mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
            UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // handle video for file upload
        } else if (CFStringCompare((CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
            NSURL* url =  [info objectForKey:UIImagePickerControllerMediaURL];
            NSData* videoData = [NSData dataWithContentsOfURL:url];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark Helper Methods

- (void)takePhoto {
    [self presentViewController:self.cameraPicker animated:YES completion:NULL];
}

- (void)selectFromAlbum {
    [self presentViewController:self.albumPicker animated:YES completion:NULL];
}

#pragma mark - Properties

@synthesize cameraPicker;
@synthesize albumPicker;
@synthesize cameraButton;
@synthesize albumButton;

@end
