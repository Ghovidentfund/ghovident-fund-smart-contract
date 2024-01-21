import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";
import { deployGhovidentFund } from "./deploy/deployGhovidentFund";

async function main() {
  await deployGhovidentFactory();
  await deployGhovidentFund();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
