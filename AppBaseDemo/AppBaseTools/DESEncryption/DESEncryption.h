//
//  DESEncryption.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/19.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
/**
 *  iOS端 DES 加密/解密
 */
@interface DESEncryption : NSObject

// triple DES Encrypt/Decrypt for NSString
+ (NSString*)TripleDES:(NSString*)plainText
      encryptOrDecrypt:(CCOperation)encryptOrDecrypt
                   key:(NSString*)key;
// triple DES Encrypt/Decrypt for NSData
+ (NSData*)TripleDESWithData:(NSData*)recourceData
            encryptOrDecrypt:(CCOperation)encryptOrDecrypt
                         key:(NSString*)key;


@end
