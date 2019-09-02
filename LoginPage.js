/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Touchableopacity,
  NativeEventEmitter,
  NativeModules
} from 'react-native';


var gt3CaptchaManagerModule =  require('react-native').NativeModules.GT3CaptchaManagerModule
const gt3CaptchaManagerEmitter = new NativeEventEmitter(NativeModules.GT3CaptchaManagerEmitter)


export default class RNPage extends Component<{}> {

  // 组件渲染后调用
  componentDidMount(){

    // console.log('枚举常量:%d',loginViewController.secondaryCaptchaPolicyForbidden)
    // gt3CaptchaManagerModule.shouldUseDefaultRegisterAPIEnabled(true)
    // gt3CaptchaManagerModule.shouldUseDefaultSecondaryValidateEnabled(true)
    // gt3CaptchaManagerModule.getCookieValue("cookieName",(error, events) => {
    
    // })

    //初始化GT3CaptchaManager
    gt3CaptchaManagerModule.initWithAPI('http://www.geetest.com/demo/gt/register-slide', 'http://www.geetest.com/demo/gt/validate-slide')

    // 监听验证码界面回调
    this.closeListener = gt3CaptchaManagerEmitter.addListener('userCloseCaptchaView',(dic)=>{
      console.log('登录界面||验证码视图关闭');
    });

        //监听验证码成功回调
    // this.secondaryListener = gt3CaptchaManagerEmitter.addListener('GT3DidReceiveSecondaryCaptchaDataEvent',(dic)=>{
    //   console.log('登录界面||验证登录成功回调');
    //   for(var key in dic){
    //     console.log("key: " + key + " ,value: " + dic[key]);
    //   }
    // });

    // // 监听验证失败的回调 
    // this.failListener = gt3CaptchaManagerEmitter.addListener('GT3CaptchaErrorHandlerEvent',(dic)=>{
    //   console.log('登录界面||验证结果发生错误');
    //   for(var key in dic){
    //      console.log("key: " + key + " ,value: " + dic[key]);
    //   }
    // });

  };

  componentWillUnmount(){
    this.closeListener.remove();
    this.secondaryListener.remove();
    this.failListener.remove();
  };

  //验证码登录  
  login() {
    // alert("准备登录")
    // gt3CaptchaManagerModule.startGTCaptchaWithAnimated(true);
    gt3CaptchaManagerModule.startGTCaptcha().then((datas)=> {
      console.log('data', datas);
    }).catch((err)=> {
      console.log('err', err);
    })
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.login} onPress={()=>this.login()}>
          RN验证码登录
        </Text>
      </View>
    );
  }
}
 
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  login: {
    width: 180,
    fontSize: 22,
    backgroundColor: '#33acdc',
    textAlign: 'center',
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
