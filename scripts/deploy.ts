import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";
import { deployBananaFund } from "./deploy/deployBananaFund";

async function main() {
  await deployGhovidentFactory();
  await deployBananaFund();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
