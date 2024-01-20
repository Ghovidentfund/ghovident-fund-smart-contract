import { deployGProvidentFund } from "./deploy/deployGProvidentFund";
import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";

async function main() {
  await deployGhovidentFactory();
  await deployGProvidentFund();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
