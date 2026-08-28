import fs from 'node:fs';
import path from 'node:path';

const configPath = 'C:\\Users\\super\\.agents\\config\\telegram.json';
const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
const { bot_token, chat_id } = config;

const [action, ...args] = process.argv.slice(2);
const message = args.join(' ');

async function sendMessage(text) {
  const url = `https://api.telegram.org/bot${bot_token}/sendMessage`;
  const res = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ chat_id, text })
  });
  const data = await res.json();
  return data;
}

async function askQuestion(promptText, timeoutSeconds = 300) {
  if (promptText) {
    await sendMessage(promptText);
  }

  // Get initial update ID offset
  const initRes = await fetch(`https://api.telegram.org/bot${bot_token}/getUpdates?offset=-1`);
  const initData = await initRes.json();
  let lastUpdateId = 0;
  if (initData.result && initData.result.length > 0) {
    lastUpdateId = initData.result[initData.result.length - 1].update_id;
  }

  const startTime = Date.now();
  console.log(`Waiting for response from Telegram (Timeout: ${timeoutSeconds}s)...`);

  while ((Date.now() - startTime) / 1000 < timeoutSeconds) {
    await new Promise(r => setTimeout(r, 2500));
    try {
      const offset = lastUpdateId + 1;
      const res = await fetch(`https://api.telegram.org/bot${bot_token}/getUpdates?offset=${offset}&timeout=5`);
      const data = await res.json();
      if (data.result && data.result.length > 0) {
        for (const u of data.result) {
          lastUpdateId = Math.max(lastUpdateId, u.update_id);
          if (u.message && String(u.message.chat.id) === String(chat_id) && u.message.text) {
            console.log(u.message.text);
            return u.message.text;
          }
        }
      }
    } catch (e) {
      // transient network error, retry
    }
  }

  console.error('Timed out waiting for response.');
  process.exit(1);
}

if (action === 'send') {
  const res = await sendMessage(message);
  console.log(JSON.stringify(res));
} else if (action === 'ask') {
  await askQuestion(message, 300);
} else {
  console.log('Usage: node telegram.js [send|ask] "message"');
}
