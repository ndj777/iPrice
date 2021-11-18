function fn() {    
  var env = karate.env;
  if(!env)
  {
//  env = 'stage';
//  env = 'uat';
  env = 'prod';
  }
  karate.log('karate.env system property was:', env);
  karate.configure('retry', { count: 3, interval: 5000});
//  karate.configure('ssl', true) ;
  var config = {
        baseUrl: 'https://www.iprice.my',
        commonUtil : karate.call('classpath:com/iPrice/uiTest/util/commonMethods.feature')
    };
   // if env is stage use stage url
    if (env == 'stage') {
        config.baseUrl = 'https://www.stage.iprice.my'
    }
    // if env is uat use uat url
    else if(env == 'uat') {
    config.baseUrl = 'https://www.stage.iprice.my'
    }
    return config;
}