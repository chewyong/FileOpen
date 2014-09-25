//
//  FileOpener.m
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-4-24.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "FileOpener.h"
#import "AppDelegate.h"

@implementation FileOpener
@synthesize docInteractionController;


- (id)init {
    //先让父类进行初始化
    if (self = [super init]) {
        // do something
    }
    return self;
}

- (void)setFileURL:(NSURL *)url {
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
    
}

- (UIImage *)documentIcon {

    NSInteger iconCount = [self.docInteractionController.icons count];
    if (iconCount > 0)
    {
        return [self.docInteractionController.icons objectAtIndex:iconCount - 1];
    }
    return nil;
}

- (NSString *)formattedFileSize {
    NSError *error;
    NSString *fileURLString = [self.docInteractionController.URL path];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileURLString error:&error];
    NSInteger fileSize = [[fileAttributes objectForKey:NSFileSize] intValue];
    return [self formattedFileSize:fileSize];
}

- (NSString *)formattedFileSize:(unsigned long long)size
{
	NSString *formattedStr = nil;
    if (size == 0)
		formattedStr = @"Empty";
	else
		if (size > 0 && size < 1024)
			formattedStr = [NSString stringWithFormat:@"%qu bytes", size];
        else
            if (size >= 1024 && size < pow(1024, 2))
                formattedStr = [NSString stringWithFormat:@"%.1f KB", (size / 1024.)];
            else
                if (size >= pow(1024, 2) && size < pow(1024, 3))
                    formattedStr = [NSString stringWithFormat:@"%.2f MB", (size / pow(1024, 2))];
                else
                    if (size >= pow(1024, 3))
                        formattedStr = [NSString stringWithFormat:@"%.3f GB", (size / pow(1024, 3))];
	
	return formattedStr;
}

- (void)showOpenInMenuInView:(UIView *)view {
    //弹出第三方App选择菜单
    BOOL isValid = [self.docInteractionController presentOpenInMenuFromRect:CGRectMake(0, 190, 320, 100) inView:view animated:YES];
    NSLog(@"isValid:%@",isValid?@"yes":@"no");
    //未弹出成功，则提示“不支持的文件类型”
    if (!isValid) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"不支持的文件类型"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

//- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
//{
//    return [AppDelegate getDelegate].nav;
//}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    NSLog(@"%@ %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));

}


@end
