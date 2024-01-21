import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";
import { deployFund } from "./deploy/deployFund";

async function main() {
  await deployGhovidentFactory();
  await deployFund();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
