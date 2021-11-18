@ignore
Feature: This feature will initialize driver instance to run UI tests in parallel

  Background:

  @name=driverStart
  Scenario Outline: <type>
    * configure driver = driverParam
    * driver baseUrl
    * delay(2000)
    * fullscreen()
    * waitUntil("document.readyState === 'complete'")

    Examples:
      | type                       | driverParam!                                                                                                               |
      | chrome                     | { type: 'chrome', showDriverLog: false}                                                                                    |
#      | chrome in headless mode    | { type: 'chrome', headless:true, showDriverLog: false}                                                                     |
#      | chrome in headless mode VM | { type: 'chrome', headless:true, showDriverLog: false, addOptions:['--no-sandbox'],executable:'/opt/google/chrome/chrome'} |
#      | chromeDriver               | { type: 'chrome',headless:true, executable: '/opt/google/chrome/google-chrome' }                                           |