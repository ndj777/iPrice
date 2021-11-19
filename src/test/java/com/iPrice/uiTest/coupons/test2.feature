@coupons
Feature: Navigate to iPrice Malaysia Coupons (https://iprice.my/coupons/) website and perform
  some automated test based on the following.

  Background:
#   take screenshot on failure
    * configure afterScenario = function(){ if (karate.scenario.error) driver.screenshotFull()}
#   Invoke driver
#    * call read('classpath:com/iPrice/uiTest/util/initializeDriver.feature@name=driverStart')
    * def couponsPage = read('classpath:com/iPrice/pageElements/couponsPage.json')

  Scenario:Make sure that url of stores in Top Stores are all active
    * call read('classpath:com/iPrice/uiTest/util/initializeDriver.feature@name=driverStart')
    * submit().click(couponsPage.couponsTab)
    * waitUntil("document.readyState === 'complete'")
    * waitFor(couponsPage.topStores.allStores).click()
    * waitUntil("document.readyState === 'complete'")
    * def enabled = function(x) {return script("div[data-uat='coupon-store-item']",'!_.disabled')}
    * def storeTiles = locateAll(couponsPage.topStores.storeTile,enabled)
    * print 'enabled stores are -',karate.sizeOf(storeTiles)
    * match karate.sizeOf(storeTiles) == 82

  Scenario: Make sure that list of stores in Top Stores is redirected to their proper store url
    * call read('classpath:com/iPrice/uiTest/util/initializeDriver.feature@name=driverStart')
    * submit().click(couponsPage.couponsTab)
    * waitUntil("document.readyState === 'complete'")
    * waitFor(couponsPage.topStores.allStores).click()
    * waitUntil("document.readyState === 'complete'")
    * def storeTiles = locateAll(couponsPage.topStores.storeTile)
    * def totalStores = karate.sizeOf(storeTiles)
    * print 'enabled stores are -',totalStores
    * def loopCount = karate.repeat(totalStores, commonUtil.returnCount)
    * def storeBrandNameList = scriptAll(couponsPage.topStores.storeBrandName,'_.getAttribute("title")')
    * print 'store Brand names are -',storeBrandNameList
    * call read('classpath:com/iPrice/uiTest/coupons/test2.feature@name=validateStoreDetailsPage') loopCount

  @ignore
  @name=validateStoreDetailsPage
  Scenario: validate the store locator page
    * def storeTiles = locateAll(couponsPage.topStores.storeURL)
    * storeTiles[val].click()
    * print 'loop counter value is - ', val
    * print 'checking for store that clicked - ', storeBrandNameList[val]
    * waitUntil("document.querySelector('#breadcrumb-desktop') != null")
    * def storeBrandNameDetailsPage = script(couponsPage.storeDetails.detailsPageLogo,'_.getAttribute("alt")')
    * print 'store names are -',storeBrandNameDetailsPage
    * match storeBrandNameDetailsPage == storeBrandNameList[val]
#    * match (text(couponsPage.storeDetails.loadedPageHeader).toLowerCase()) contains storeNameList[val].toLowerCase()
    * submit().click(couponsPage.storeDetails.allStorePage)

    @ignore
  Scenario: Make sure that list of stores in Top Stores is redirected to their proper store url - method1
    * call read('classpath:com/iPrice/uiTest/util/initializeDriver.feature@name=driverStart')
    * submit().click(couponsPage.couponsTab)
    * waitUntil("document.readyState === 'complete'")
    * waitFor(couponsPage.topStores.allStores).click()
    * waitUntil("document.readyState === 'complete'")
    * delay(5000)
    * def storeNameList = scriptAll(couponsPage.topStores.storeName,'_.getAttribute("title")')
    * print 'store names are -',storeNameList
    * def storeListURL = commonUtil.generateURLSuffix(storeNameList)
    * print 'store names in URL are -',storeListURL
    * def storeUrlList = scriptAll(couponsPage.topStores.storeURL,'_.getAttribute("href")')
    * def storesAvailable = commonUtil.getStores(storeUrlList)
    * print 'link containing store names in URL are -',storesAvailable
#    * match storesAvailable contains storeListURL

