@ignore
  Feature: this file contains util methods

Scenario:
    * def getStores =
  """
  function(storeList)
  {
   var stores = [];
    for(i=0 ; i < storeList.length;i++)
    {
      stores.push((storeList[i].split("/"))[(storeList[i].split("/")).length - 2]);
    }
    return stores;
  }
  """
  * def generateURLSuffix =
  """
  function(storeNameList)
  {
   var storeURLList = [];
   var storeNameURL;
    for(i=0 ; i < storeNameList.length;i++)
    {
      storeNameURL = storeNameList[i];
      if(storeNameList[i].includes("'") && storeNameList[i].includes(" "))
      {
        storeNameURL = storeNameList[i].replace(" ","-");
        storeNameURL = storeNameURL.replace("'","");
      }
      else if(storeNameList[i].includes("."))
      storeNameURL = storeNameList[i].replace(".","");
      else if(storeNameList[i].includes("'") && !storeNameList[i].includes(" "))
        storeNameURL = storeNameList[i].replace("'","");
      else if(storeNameList[i].includes(" "))
      storeNameURL = storeNameList[i].replace(/ /g,"");
      storeURLList.push(storeNameURL.toLowerCase());
    }
    return storeURLList;
  }
  """
  * def returnCount = function(i){ return { val: i } }