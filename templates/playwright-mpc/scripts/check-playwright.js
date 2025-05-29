import { writeFileSync } from 'fs';
import { join } from 'path';
import { execSync } from 'child_process';

const { 
  NIX_PLAYWRIGHT_VERSION: nixVersion, 
  PLAYWRIGHT_BROWSERS_PATH: browsersPath, 
  CHROMIUM_REV: chromiumRev,
} = process.env;

if (!nixVersion || !browsersPath || !chromiumRev) {
  console.error('Error: Required environment variables are not set.');
  process.exit(1);
}

try {
  const npmVersion = execSync('npm show @playwright/test version', { encoding: 'utf8' }).trim();
  console.log(`❄️ Playwright nix version: ${nixVersion}`);
  console.log(`📦 Playwright npm version: ${npmVersion}`);

  if (nixVersion !== npmVersion) {
    console.error(`❌ Version mismatch: Nix (${nixVersion}) vs npm (${npmVersion})`);
  } else {
    console.log('✅ Playwright versions match');
    const config = {
      browser: {
        launchOptions: {
          executablePath: `${browsersPath}/chromium-${chromiumRev}/chrome-linux/chrome`,
        },
      },
    };

    writeFileSync(join(".", 'playwright-mcp.json'), JSON.stringify(config, null, 2));
    console.log('✅ Successfully wrote playwright-mcp.json');
  }
} catch (error) {
  console.error('Error:', error.stderr || error.message);
  process.exit(1);
} 