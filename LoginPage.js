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
  NativeEventEmitter,
  NativeModules,
  TouchableOpacity,
} from 'react-native';


var gt3CaptchaManagerModule =  require('react-native').NativeModules.GT3CaptchaManagerModule
const gt3CaptchaManagerEmitter = new NativeEventEmitter(NativeModules.GT3CaptchaManagerEmitter)

//验证码登录
const onPressButton = () => {
    gt3CaptchaManagerModule.startGTCaptcha().then((datas)=> {
      console.log('data', datas);
    }).catch((err)=> {
      console.log('err', err);
    });

};

export default class RNPage extends Component<{}> {

  constructor(props) {
        super(props);
    }

  // 组件渲染后调用
  componentDidMount(){

    // console.log('枚举常量:%d',loginViewController.secondaryCaptchaPolicyForbidden)
    // gt3CaptchaManagerModule.shouldUseDefaultRegisterAPIEnabled(true)
    // gt3CaptchaManagerModule.shouldUseDefaultSecondaryValidateEnabled(true)
    // gt3CaptchaManagerModule.getCookieValue("cookieName",(error, events) => {
    
    // })

    //初始化GT3CaptchaManager
    gt3CaptchaManagerModule.initWithAPI('https://www.geetest.com/demo/gt/register-slide', 'https://www.geetest.com/demo/gt/validate-slide');
    gt3CaptchaManagerModule.gtViewWithTimeout(10000);
    gt3CaptchaManagerModule.disableBackgroundUserInteraction(true);
    gt3CaptchaManagerModule.enableDebug(false);

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
    gt3CaptchaManagerModule.closeSensebot();
    this.closeListener.remove();
    this.secondaryListener.remove();
    this.failListener.remove();
  };

  render() {
    return (

           <View style={styles.container}>
                <Text style={styles.welcome}>
                       Welcome to react-native-geetest!
                </Text>
                <TouchableOpacity onPress={onPressButton}>
                    <View style={{borderWidth: 1, borderColor: '#CCCCCC', padding: 10}}>
                          <Text>Trigger Sensebot</Text>
                    </View>
                </TouchableOpacity>
           </View>

    );
  }
}
 
const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#39ffd6',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    }
});
