// trace.js
// author: bashow
// 2020/03/11

// trace
const puppeteer = require('puppeteer');

(async () => {

  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.tracing.start({
    path: process.argv[2],
    categories: ['devtools.timeline']
  })

  await page.goto(process.argv[3]);
  await page.tracing.stop();
  await browser.close();

})();

