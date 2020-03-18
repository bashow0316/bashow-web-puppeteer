// trace.js
// author: bashow
// 2020/03/11

const puppeteer = require('puppeteer');


var url = process.argv[2];
var json = process.argv[3];

(async () => {

  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.tracing.start({
    path: json,
    screenshots: true
    // categories: ['devtools.timeline']
  })

  await page.goto(url);
  await page.tracing.stop();
  await browser.close();

})();

