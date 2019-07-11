//
//  MyPublicClass.h
//  KTexpress
//
//  Created by yaodunpeng on 2017/4/1.
//  Copyright © 2017年 huan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface MyPublicClass : NSObject

//自定义文字的宽高 第一种

+ (CGRect)stringHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

// 获取文字宽度 第二种
+ (CGFloat)widthWithFont:(UIFont *)font
     constrainedToHeight:(CGFloat)height
                 content:(NSString *)content;

/**
 *  @brief 计算文字的CGSize
 */
+ (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
                       content:(NSString *)content;

//自定义文字尺寸(根据不同屏幕进行改变)
+(CGFloat)customSystemFontOfSize:(CGFloat)fontSize;
//切边距
+(void)layerMasksToBoundsForAnyControls:(UIView *)sender cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
//语言本地化
+(NSString *)localizedLanguage:(NSString *)language;
//修改占位符颜色，添加左边imageview
+(void)attributedString:(NSString *)attString andHolderColor:(UIColor *)color placeholder:(UITextField *)textField imageString:(NSString *)imageString andImageRect:(CGRect)imageRect;
//隐藏文字中间部分
+(NSString *)hidesThePartialInformations:(NSString *)information andLocation:(NSUInteger)location andLength:(NSInteger)length writingChangeStyle:(NSString *)style;
//阿拉伯数字转汉字数字
+(NSString *)arabicNumerals:(int)numeral;
//汉字编码转化
+(NSString *)LanguageSwitchString:(NSString *)string;

//设置某个字体
+(NSMutableAttributedString *)attributedString:(NSString *)String andFontOfSize:(CGFloat)Size andRange:(NSRange)Range;
//设置某个字体颜色
+(NSMutableAttributedString *)attributedString:(NSString *)String andColor:(UIColor *)Color andRange:(NSRange)Range;
//设置划线
+(NSMutableAttributedString *)attributedStringOfLineation:(NSString *)lineationString;
/** 设置 中划线 和其他的颜色
 */
+(NSMutableAttributedString *)attributedString:(NSString *)String LineationRange:(NSRange)lRange colorRange:(NSRange)cRange  andColor:(UIColor *)color;

//设置所有字体颜色
+(NSMutableAttributedString *)attributedString:(NSString *)String andColor:(UIColor *)Color;
//判断字符串是否为空
+ (BOOL)stringIsNull:(NSString *)string;
//判断密码类型
+ (BOOL)validatePassword:(NSString *)passWord minLength:(NSString *)minNum maxLength:(NSString *)maxNum;
//判断手机号码
+(BOOL)isPhone:(NSString *)phone;
+(BOOL)isFixedTelephone:(NSString *)phone;
+(void)callPhone:(NSString *)tel;
/**
 检查银行卡号
 @param cardNo 银行卡号
 */
+(BOOL)checkCardNo:(NSString*)cardNo;
//md5 
+(NSString *)md5:(NSString *)md5String;


//存储沙盒
+(void)document:(id)timeArray andDocumentName:(NSString *)documentName;
//提取
+(NSDictionary *)userNameRead:(NSString *)documentName;
//删除
+(void)clearWithFilePath:(NSString *)path;

+(void)documentfolder:(NSString *)fileName;
//缓存头像
+(void)createDirecctoryPathImageName:(NSString *)imageName imageData:(NSData *)data;
+(NSString *)filePath:(NSString *)path;
//判断文件是否已经在沙盒中已经存在？
+(BOOL) isFileExist:(NSString *)fileName;

/**
 textfield 限定最大编辑长度
 */

+(BOOL)textField:(UITextField *)textField customInputLength:(NSRange)range customReplacementString:(NSString *)string maxLength:(NSInteger)length;

// textfield输入金额时进行的判断
+(BOOL)systemTextField:(UITextField *)textField systemRange:(NSRange)range replacementString:(NSString *)string retainLength:(NSInteger)length;
//倒计时
+(void)countDownWithStratDate:(int)num timeButton:(UIButton *)sender buttonTitle:(NSString*)title;
//计时器销毁-一定要调用
+(void)destoryTimer;
// 将某个时间戳转化成 时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

//导航栏titleView
+(void)navigationItem:(UINavigationItem *)itme andParentRect:(CGRect )parentRect andImageName:(NSString *)imageName;
//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image;

/**
 颜色转图片
 */
+ (UIImage *)imgColor:(UIColor *)color;
//系统信息
+(NSString *)getSysteMmessageForUDID;


/**
 颜色转换

 @param stringToConvert string 颜色码
 @return UIColor
 */
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;

/** 保存图片 */
+ (void)saveImage:(UIImage *)image;

@end
