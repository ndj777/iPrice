@products
  Feature: Navigate to iPrice Malaysia (https://www.iprice.my) website and perform some
    automated test based on the following.

    Background:
#      take screenshot on failure
      * configure afterScenario = function(){ if (karate.scenario.error) driver.screenshotFull()}
#      Invoke driver
      * call read('classpath:com/iPrice/uiTest/util/initializeDriver.feature@name=driverStart')
      * def bestDeals = read('classpath:com/iPrice/pageElements/productsPage.json')

      Scenario: Grab the list of stores in the “Find the Best Deals Online”
        * waitFor(bestDeals.findBestDealsOnline.stores)
        * def storeList = scriptAll(bestDeals.findBestDealsOnline.storeName,'_.getAttribute("href")')
        * def storesAvailable = commonUtil.getStores(storeList)
        * print 'stores available under find the best deals online section are - ',storesAvailable

      Scenario: Count the list of the stores in the “Find the Best Deals Online”
        * waitFor(bestDeals.findBestDealsOnline.stores)
        * def totalStores = karate.sizeOf(locateAll(bestDeals.findBestDealsOnline.storeName))
        * print 'Total number of stores under find the best deals online section are - ',totalStores

     Scenario: Count the list of items in “Top Trending Products”
       * waitFor(bestDeals.topTrendingProducts.products)
       * def totalProducts = karate.sizeOf(locateAll(bestDeals.topTrendingProducts.products))
       * print 'Total number of products under Top Trending Products section are - ',totalProducts

     Scenario: Validate that each item in “Top Trending Products” contains “data-vars-cgt”
       * waitFor(bestDeals.topTrendingProducts.checkLinkAttribute)
       * def isAttributePresent = scriptAll(bestDeals.topTrendingProducts.checkLinkAttribute,'_.hasAttribute("data-vars-cgt")')
       * print 'is attribute present',isAttributePresent
       * match isAttributePresent !contains false