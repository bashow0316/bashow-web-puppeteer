// trace-speedline.js
// author: bashow
// 2020/03/20

const puppeteer = require('puppeteer');
const speedline = require('speedline');
const fs = require('fs');

var url = process.argv[2];
var traceJson = process.argv[3];
var parseJson = process.argv[4];

(async () => {

  try {
    // timestamp
    const timestamp = new Date();

    // brower
    const browser = await puppeteer.launch({
      args: [
        '--no-sandbox', 
        '--disable-setuid-sandbox'
      ]
    });

    // new page
    const page = await browser.newPage();
    await page.tracing.start({
      path: traceJson,
      screenshots: true
      // categories: ['devtools.timeline']
    });

    // go page 
    await page.goto(url);
    await page.tracing.stop();
    await browser.close();

    // speedline
    speedline(traceJson).then(res => {
      const startTs = res.beginning;
      const visualProgress = res.frames.map(frame => {
        const ts = Math.floor(frame.getTimeStamp() - startTs);
        return `${ts}=${Math.floor(frame.getProgress())}%`;
      }).join(', ');

      const visualPreceptualProgress = res.frames.map(frame => {
        const ts = Math.floor(frame.getTimeStamp() - startTs);
        return `${ts}=${Math.floor(frame.getPerceptualProgress())}%`;
      }).join(', ');

      const jsonData = JSON.stringify({
        "Beginning timestamp": timestamp.toISOString(),
        "Recording duration" : res.duration,
        "First visual change" : res.first,
        "Last visual change" : res.complete,
        "Speed Index value" :  res.speedIndex,
        "Visual Progress" : visualProgress,
        "Perceptual Speed Index" : res.perceptualSpeedIndex,
        "Perceptual Visual Progress" : visualPreceptualProgress
      });
      fs.writeFile(parseJson, jsonData, (error) => { /* handle error */ });
    });

  } catch(e) {
    console.log(e);
    await browser.close();
    process.exit(200);
  }

})();

