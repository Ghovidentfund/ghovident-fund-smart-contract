import { deployScamFund } from "./deploy/deployScamFund";
import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";

async function main() {
  await deployGhovidentFactory();
  await deployScamFund();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
