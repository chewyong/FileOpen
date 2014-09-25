//
//  FileOpener.h
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-4-24.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileOpener : NSObject<UIDocumentInteractionControllerDelegate> {
    
}

@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;

//设置文件路径的URL
- (void)setFileURL:(NSURL *)url;

//获取文件icon小图标
- (UIImage *)documentIcon;

//格式化以后的文件大小
- (NSString *)formattedFileSize;

//弹出第三方app的选择菜单
- (void)showOpenInMenuInView:(UIView *)view;

@end
