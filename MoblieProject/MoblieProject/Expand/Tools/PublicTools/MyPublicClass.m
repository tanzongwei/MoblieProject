//
//  MyPublicClass.m
//  KTexpress
//
//  Created by yaodunp on 2017/4/1.
//  Copyright © 2017年 huan. All rights reserved.
//

#import "MyPublicClass.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>


#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface MyPublicClass ()
//@property(nonatomic,retain) dispatch_source_t timer;

/**
 isHaveDian or isFirstZero 用于判断首字符
 */
//@property (nonatomic, assign) BOOL isHaveDian;
//@property (nonatomic, assign) BOOL isFirstZero;

@end
@implementation MyPublicClass

#pragma mark - 字体，文本改变区域

/**
 自定义文字的宽高
 
 @param width label的宽度
 @param title 字符串
 @param font 字体大小
 @return 返回尺寸
 */
+ (CGRect)stringHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font
{
    CGRect ContentRect = [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ContentRect;
}
/**
 获取文字宽度
 
 @param font 字体大小
 @param height 高度
 @param content 文字
 */
+(CGFloat)widthWithFont:(UIFont *)font
    constrainedToHeight:(CGFloat)height
                content:(NSString *)content
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    } else {
        textSize = [content sizeWithFont:textFont
                       constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                           lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                     options:(NSStringDrawingUsesLineFragmentOrigin |
                                              NSStringDrawingTruncatesLastVisibleLine)
                                  attributes:attributes
                                     context:nil].size;
#endif
    
    return ceil(textSize.width);
}

/**
 *  @brief 计算文字的CGSize
 *
 *  @param size 宽高
 *  @param font  字体(默认为系统字体)
 *
 *  @return 宽高
 */
+ (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
                       content:(NSString *)content
{
    if ([content isEqualToString:@""]) {
        return CGSizeMake(0, 0);
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 0;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    return [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
}

/**
 自定义文字尺寸(根据不同屏幕进行改变)
 
 @param fontSize 最初始字体大小
 @return 根据不同屏幕返回font
 */
+(CGFloat)customSystemFontOfSize:(CGFloat)fontSize{
    
    CGFloat font = fontSize *(ScreenWidth/320);
    return font;
}

/**
 切边距和边框
 边框可以传0
 
 @param sender 需要切边距的控件
 @param cornerRadius 具体需要切多少
 */
+(void)layerMasksToBoundsForAnyControls:(UIView *)sender cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = cornerRadius;
    sender.layer.borderColor = borderColor.CGColor;
    sender.layer.borderWidth = borderWidth;
}


/**
 语言本地化
 
 @param language 内容
 @return 多语言
 */
+(NSString *)localizedLanguage:(NSString *)language
{
    return NSLocalizedString(language, nil);
}

/**
 修改占位符颜色，添加左边imageview
 
 @param attString 内容
 @param textField textField description
 @param imageString 图片名
 */
+(void)attributedString:(NSString *)attString andHolderColor:(UIColor *)color placeholder:(UITextField *)textField imageString:(NSString *)imageString andImageRect:(CGRect)imageRect{
    
    NSMutableAttributedString *att = [MyPublicClass attributedString:[MyPublicClass localizedLanguage:attString] andColor:color];
    textField.attributedPlaceholder = att;
    UIImageView *searImage = [[UIImageView alloc]initWithFrame:imageRect];
    searImage.image = [UIImage imageNamed:imageString];
    textField.leftView = searImage;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


/**
 设置某个字体大小
 
 @param String 需要修改的字符串
 @param Size 字体大小
 @param Range 通过坐标指定修改某个或多个
 @return return value description
 */
+(NSMutableAttributedString *)attributedString:(NSString *)String andFontOfSize:(CGFloat)Size andRange:(NSRange)Range{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:String];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Size]} range:Range];
    
    return attributedString;
}

/**
 设置某个字体颜色
 
 @param String 需要修改的字符串
 @param Color Color description
 @param Range 指定区域
 @return return value description
 */
+(NSMutableAttributedString *)attributedString:(NSString *)String andColor:(UIColor *)Color andRange:(NSRange)Range{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:String];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:Color} range:Range];
    
    return attributedString;
}


/**
 设置划线 多用于金额
 
 @param lineationString 需要修改的字符串
 @return return value description
 */
+(NSMutableAttributedString *)attributedStringOfLineation:(NSString *)lineationString{
    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc]initWithString:lineationString attributes:@{NSStrikethroughStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    
    
    return atString;
}



/**
 设置 中划线 和其他的颜色
 
 @param String  String description
 @param lRange  中划线的起止点
 @param cRange  颜色起止点
 @param color   Color description
 @return return value description
 */
+(NSMutableAttributedString *)attributedString:(NSString *)String LineationRange:(NSRange)lRange colorRange:(NSRange)cRange  andColor:(UIColor *)color {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:String];
    
    [attributedString addAttributes:@{NSStrikethroughStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:lRange];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:color} range:cRange];
    
    return attributedString;
}

/**
 设置所有字体颜色
 
 @param String String description
 @param Color Color description
 @return return value description
 */
+(NSMutableAttributedString *)attributedString:(NSString *)String  andColor:(UIColor *)Color {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:String attributes:@{NSForegroundColorAttributeName:Color}];
    
    return attributedString;
}

/**
 隐藏文字中间部分 多用于电话 隐藏中间
 
 @param information 需要隐藏的字符串
 @param location 从哪里开始
 @param length 隐藏多少个
 @param style 隐藏的样式 如：***** ，......
 @return return 136******1133
 */
+(NSString *)hidesThePartialInformations:(NSString *)information andLocation:(NSUInteger)location andLength:(NSInteger)length writingChangeStyle:(NSString *)style{
    
    NSString *change = [information stringByReplacingCharactersInRange:(NSMakeRange(location, length)) withString:style];
    
    return change;
}
/**
 阿拉伯数字转汉字数字
 
 @param numeral 例：1,2,3,4
 @return return 一,二,三,四
 */
+(NSString *)arabicNumerals:(int)numeral{
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    number.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [number stringFromNumber:[NSNumber numberWithInt: numeral]];
    
    return string;
}
#pragma mark - 汉字编码转化
+(NSString *)LanguageSwitchString:(NSString *)string{
    NSString *language = [NSString string];
    if ([string isEqualToString:@"en-CN"]) {
        language = @"English";
    }else if ([string isEqualToString:@"zh-Hans"]){
        language = @"简体中文";
    }else if ([string isEqualToString:@"zh-Hant-CN"]){
        language = @"繁体中文";
    }
    return language;
}

#pragma mark - 判断字符串

/**
 判断字符串是否为空
 
 @param string string description
 @return return 空为yes  反之 no
 */
+ (BOOL)stringIsNull:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 验证密码 只能是数字加字母
 
 @param passWord 密码
 @param minNum 最小长度
 @param maxNum 最大长度
 @return 返回yes正确 no 格式错误
 */
+ (BOOL)validatePassword:(NSString *)passWord minLength:(NSString *)minNum maxLength:(NSString *)maxNum
{
    NSString *regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%@,%@}$",minNum,maxNum];
    //6-20位数字和字母组成
    //    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [passWordPredicate evaluateWithObject:passWord];
    
}

/**
 判断手机号
 
 @param phone 手机号码
 @return yes 表示正确 no 表示错误
 
 * 手机号码:
 * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
 * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
 * 联通号段: 130,131,132,155,156,185,186,145,176,1709
 * 电信号段: 133,153,180,181,189,177,1700
 */
+(BOOL)isPhone:(NSString *)phone
{
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

+(BOOL)isFixedTelephone:(NSString *)phone{
    NSString * PHS = @"^([0-9]{3}-?[0-9]{8})|([0-9]{4}-?[0-9]{7,8})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    return [phoneTest evaluateWithObject:phone];
}

/**
 拨打电话

 @param tel 电话或者座机
 */
+(void)callPhone:(NSString *)tel{
    
    if ([MyPublicClass isPhone:tel] || [MyPublicClass isFixedTelephone:tel]) {
        
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]] options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]]];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"您拨打的号码有误！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
}
//检查银行卡号
+(BOOL)checkCardNo:(NSString*) cardNo {
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else {
        return NO;
    }
}
#pragma mark - UITextFieldDelegate 重写
static bool _isHaveDian;
static bool _isFirstZero;
/**
 textfield 设置输入小数点位数
 
 @param textField 代理自身textfield
 @param range    代理自身range
 @param string 代理自身string
 @param length 需要限制的最大输入长度
 @return yes可以编辑 no 不可编辑
 @supplement 与textfield代理方法对应（textField shouldChangeCharactersInRange:(NSRange)range replacementString）共用 多用于金额的输入
 */
+(BOOL)systemTextField:(UITextField *)textField systemRange:(NSRange)range replacementString:(NSString *)string retainLength:(NSInteger)length{
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian = NO;
    }
    if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
        _isFirstZero = NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            
            if([textField.text length]==0){
                if(single == '.'){
                    //首字母不能为小数点
                    return NO;
                }
                if (single == '0') {
                    _isFirstZero = YES;
                    return YES;
                }
            }
            
            if (single=='.'){
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian=YES;
                    return YES;
                }else{
                    return NO;
                }
            }else if(single=='0'){
                if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                    //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                    if([textField.text isEqualToString:@"0.0"]){
                        return NO;
                    }
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=(int)(range.location-ran.location);
                    if (tt <= length){
                        return YES;
                    }else{
                        return NO;
                    }
                }else if (_isFirstZero&&!_isHaveDian){
                    //首位有0没.不能再输入0
                    return NO;
                }else{
                    return YES;
                }
            }else{
                if (_isHaveDian){
                    //存在小数点，保留两位小数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt= (int)(range.location-ran.location);
                    if (tt <= length){
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(_isFirstZero&&!_isHaveDian){
                    //首位有0没点
                    return NO;
                }else{
                    return YES;
                }
            }
        }else{
            //输入的数据格式不正确
            return NO;
        }
    }else{
        return YES;
    }
    
    return YES;
}


/**
 textfield 限定最大编辑长度
 
 @param textField 代理自身textfield
 @param range    代理自身range
 @param string 代理自身string
 @param length 需要限制的最大输入长度
 @return yes可以编辑 no 不可编辑
 @supplement 与textfield代理方法对应（textField shouldChangeCharactersInRange:(NSRange)range replacementString）共用
 */
+(BOOL)textField:(UITextField *)textField customInputLength:(NSRange)range customReplacementString:(NSString *)string maxLength:(NSInteger)length{
    if(string.length == 0) return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    NSInteger finalLength = (existedLength-selectedLength+replaceLength);
    if(finalLength>length){
        return NO;
    }
    return YES;
}

/**
 md5加密 32位
 
 @param md5String 需要加密的字符串
 @return 加密后的字符串
 */
+(NSString *)md5:(NSString *)md5String
{
    const char *cStr = [md5String UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - 本地化区域

#pragma mark - 存储沙盒
+(void)document:(id)timeArray andDocumentName:(NSString *)documentName
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",documentName]];
    [timeArray writeToFile:file atomically:YES];
    
}

#pragma mark - 提取
+(NSDictionary *)userNameRead:(NSString *)documentName{
    //获取Documents目录
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //还要指定存储文件的文件名称,仍然使用字符串拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:documentName];
    
    //使用一个数组来接受数据
    NSDictionary *array = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return array;
}

+(void)documentfolder:(NSString *)fileName{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    [[NSFileManager defaultManager] createDirectoryAtPath:file withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark - 删除
+(void)clearWithFilePath:(NSString *)path
{
    NSFileManager *manger = [NSFileManager defaultManager];
    NSString *docment = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [docment stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    [manger removeItemAtPath:file error:nil];
}

#pragma mark - 缓存头像
+(void)createDirecctoryPathImageName:(NSString *)imageName imageData:(NSData *)data{
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@.png",imageName]] contents:data attributes:nil];
}
+(NSString *)filePath:(NSString *)path{
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@/%@.png",DocumentsPath,path];
    
    return filePath;
}

#pragma mark - 判断文件是否已经在沙盒中已经存在？
+(BOOL) isFileExist:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:fileName];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}

#pragma mark - 时间区域

static dispatch_source_t _timer;
/**
 倒计时
 
 @param num 多少秒
 @param sender 需要倒计时的按钮
 @param title 倒计时的提示信息
 */
+(void)countDownWithStratDate:(int)num timeButton:(UIButton *)sender buttonTitle:(NSString*)title{
    __block int timeout = num;
    if (timeout != 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sender setTitle:[MyPublicClass localizedLanguage:title] forState:(UIControlStateNormal)];
                    sender.userInteractionEnabled = YES;
                });
            }else{
                NSString *strTime = [NSString stringWithFormat:@"%d", timeout];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sender setTitle:[NSString stringWithFormat:@"%@(s)",strTime] forState:(UIControlStateNormal)];
                    sender.userInteractionEnabled = NO;
                    
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
    
}

#pragma mark - 注销计时器
+(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

#pragma mark - 将某个时间戳转化成 时间

/**
 将某个时间戳转化成 时间
 
 @param timestamp 时间戳
 @param format // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 返回标准时间
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    return confromTimespStr;
}

/**
 00:00:00转换成秒
 
 @param timeString 需要传的时间字符串
 @param key 需要切割的关键字 如@"," @":" @" " 等....
 @return 返回秒数总和
 */
-(NSInteger)conversion:(NSString *)timeString andkeyWords:(NSString *)key{
    
    NSArray *timeArray = [timeString componentsSeparatedByString:key];
    NSArray* reversedArray = [[timeArray reverseObjectEnumerator] allObjects];
    
    NSString *H_M_S = [NSString string];
    NSInteger setH_M_S = 0;
    
    for (int i = 0; i < reversedArray.count; i++) {
        H_M_S = reversedArray[i];
        switch (reversedArray.count) {
            case 3:
                if (i == 0) {
                    setH_M_S += [H_M_S integerValue];
                }else if (i == 1){
                    
                    setH_M_S += [H_M_S integerValue]*60;
                    
                }else{
                    setH_M_S += [H_M_S integerValue]*3600;
                    
                }
                break;
            case 2:{
                if (i == 0) {
                    setH_M_S += [H_M_S integerValue];
                }else{
                    
                    setH_M_S += [H_M_S integerValue]*60;
                }
            }
                break;
            case 1:{
                setH_M_S += [H_M_S integerValue];
            }
                break;
            default:
                break;
        }
        
        
    }
    return setH_M_S;
}

#pragma mark - 导航栏区域

/**
 导航栏添加图片
 
 @param itme 当前的导航栏
 @param parentRect 当前的view
 @param imageName 图片名
 */
+(void)navigationItem:(UINavigationItem *)itme andParentRect:(CGRect )parentRect andImageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:parentRect];
    imageView.image = [UIImage imageNamed:imageName];
    itme.titleView = imageView;
}

#pragma mark - 获取图片颜色

/**
 根据图片获取图片的主色调
 
 @param image png图片
 @return 返回colol
 */
+(UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大警告 12-10的 无法获取图片颜色
    
    CGSize thumbSize=CGSizeMake(image.size.width, image.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

#pragma mark -- UIImage
#pragma mark - =============颜色转图片=========================
+ (UIImage *)imgColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 系统信息UDID

/**
 获取设备唯一标识符UDID
 
 @return 返回udid
 */
+(NSString *)getSysteMmessageForUDID{
    
    NSString *udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    return udid;
    
}

#pragma mark - =========颜色转换=============================
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    UIColor *color = RGBA(r,g,b,1.0f);
    return color;
}

+ (void)saveImage:(UIImage *)image
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library saveImage:image toAlbum:app_name completion:^(NSURL *assetURL, NSError *error) {
        
        [YPProgressHUD showSuccessHUDWithTitle:@"保存成功！"];
    } failure:^(NSError *error) {
        
        [YPProgressHUD showErrorHUDWithTitle:error.localizedDescription];
    }];
}

@end
